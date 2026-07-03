#!/usr/bin/env python3
"""
generate-fal-asset.py — generate an image or a true vector (SVG) via fal.ai,
for use whenever a diagram, icon, or illustration is needed and nothing
suitable exists in the icon library (see assets/icons/index.md).

Requires FAL_KEY in the environment. Get one from https://fal.ai/dashboard/keys
and export it in your shell — never paste it into a prompt or hardcode it here:

    export FAL_KEY=your-key-here

Uses only the Python standard library (urllib), no pip install required.

Usage:
    # Generate a true SVG vector directly from a text prompt
    generate-fal-asset.py --mode text-to-vector --prompt "a shield icon, line art" \
        --out shield.svg --colors "#FE414D,#0A0A0A"

    # Generate a raster image (photo/illustration) from a text prompt
    generate-fal-asset.py --mode text-to-image --prompt "abstract network of nodes" \
        --out hero.png --style digital_illustration --size landscape_16_9

    # Convert an existing raster image (must be a public URL) into a true SVG
    generate-fal-asset.py --mode vectorize --image-url https://example.com/logo.png \
        --out logo.svg
"""
import argparse
import json
import os
import sys
import time
import urllib.request
import urllib.error

FAL_QUEUE_BASE = "https://queue.fal.run"

MODELS = {
    "text-to-vector": "fal-ai/recraft/v4/text-to-vector",
    "text-to-image": "fal-ai/recraft-v3",
    "vectorize": "fal-ai/recraft/vectorize",
}


def fal_request(method, url, api_key, payload=None):
    data = json.dumps(payload).encode("utf-8") if payload is not None else None
    req = urllib.request.Request(url, data=data, method=method)
    req.add_header("Authorization", f"Key {api_key}")
    if payload is not None:
        req.add_header("Content-Type", "application/json")
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        print(f"!! fal.ai API error {e.code}: {body}", file=sys.stderr)
        sys.exit(1)


def hex_to_rgb_obj(hex_colour):
    h = hex_colour.strip().lstrip("#")
    return {"r": int(h[0:2], 16), "g": int(h[2:4], 16), "b": int(h[4:6], 16)}


def build_payload(args):
    if args.mode == "vectorize":
        if not args.image_url:
            print("!! --image-url is required for --mode vectorize (must be a public URL, "
                  "not a local path)", file=sys.stderr)
            sys.exit(1)
        return {"image_url": args.image_url}

    if not args.prompt:
        print(f"!! --prompt is required for --mode {args.mode}", file=sys.stderr)
        sys.exit(1)

    payload = {"prompt": args.prompt}

    colours = None
    if args.colors:
        colours = [hex_to_rgb_obj(c) for c in args.colors.split(",")]

    if args.mode == "text-to-vector":
        payload["image_size"] = args.size
        if colours:
            payload["colors"] = colours
    elif args.mode == "text-to-image":
        payload["style"] = args.style
        payload["size"] = args.size
        if colours:
            payload["colors"] = colours

    return payload


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--mode", required=True, choices=list(MODELS.keys()))
    parser.add_argument("--prompt", help="Text prompt (required for text-to-vector / text-to-image)")
    parser.add_argument("--image-url", help="Public URL of the source raster image (required for vectorize)")
    parser.add_argument("--out", required=True, help="Output file path (.svg or .png/.jpg depending on mode)")
    parser.add_argument("--style", default="digital_illustration",
                         choices=["realistic_image", "digital_illustration", "vector_illustration"],
                         help="text-to-image only. Note: this is a raster styled like a vector, "
                              "not a true SVG — use --mode text-to-vector for a real SVG.")
    parser.add_argument("--size", default="square_hd",
                         choices=["square_hd", "square", "portrait_4_3", "portrait_16_9",
                                  "landscape_4_3", "landscape_16_9"])
    parser.add_argument("--colors", help="Comma-separated hex colours, e.g. '#FE414D,#0A0A0A', "
                                          "to bias the palette toward your brand-core palette")
    parser.add_argument("--poll-interval", type=float, default=2.0)
    parser.add_argument("--timeout", type=float, default=180.0)
    args = parser.parse_args()

    api_key = os.environ.get("FAL_KEY")
    if not api_key:
        print("!! FAL_KEY is not set. Export it in your shell:\n"
              "     export FAL_KEY=your-key-here\n"
              "   Get a key from https://fal.ai/dashboard/keys", file=sys.stderr)
        sys.exit(1)

    model = MODELS[args.mode]
    payload = build_payload(args)

    print(f"==> Submitting to {model}")
    submit = fal_request("POST", f"{FAL_QUEUE_BASE}/{model}", api_key, payload)
    request_id = submit.get("request_id")
    if not request_id:
        print(f"!! No request_id in submit response: {submit}", file=sys.stderr)
        sys.exit(1)

    status_url = f"{FAL_QUEUE_BASE}/{model}/requests/{request_id}/status"
    result_url = f"{FAL_QUEUE_BASE}/{model}/requests/{request_id}"

    print(f"==> Polling {request_id}")
    start = time.time()
    while True:
        if time.time() - start > args.timeout:
            print(f"!! Timed out after {args.timeout}s waiting on request {request_id}", file=sys.stderr)
            sys.exit(1)
        status = fal_request("GET", status_url, api_key)
        state = status.get("status")
        if state == "COMPLETED":
            break
        if state in ("FAILED", "ERROR"):
            print(f"!! fal.ai job failed: {status}", file=sys.stderr)
            sys.exit(1)
        time.sleep(args.poll_interval)

    result = fal_request("GET", result_url, api_key)
    images = result.get("images") or result.get("image") and [result["image"]]
    if not images:
        print(f"!! No image/vector in result: {result}", file=sys.stderr)
        sys.exit(1)

    file_url = images[0]["url"]
    print(f"==> Downloading {file_url}")
    urllib.request.urlretrieve(file_url, args.out)
    print(f"==> Saved to {args.out}")


if __name__ == "__main__":
    main()
