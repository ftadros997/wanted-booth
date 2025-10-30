#!/bin/bash
set -euo pipefail
echo "🚀 Setting up Wanted Poster Booth"

if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ python3 not found. Please install from https://www.python.org/"
  exit 1
fi

LAN_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "localhost")
echo "🔎 Detected LAN IP: $LAN_IP"

echo "1) Starting local HTTP server (desktop preview) on http://localhost:8080"
python3 -m http.server 8080 &
HTTP_PID=$!
sleep 1
open "http://localhost:8080" || true

echo
echo "2) Preparing secure HTTPS server (for phone camera support) on port 8443"
if [ ! -f cert.pem ] || [ ! -f key.pem ]; then
  echo "   🔐 Generating self-signed certificate (valid 365 days)..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/CN=$LAN_IP" -keyout key.pem -out cert.pem >/dev/null 2>&1
fi

echo "   ➜ On your phone, open: https://$LAN_IP:8443"
echo "      (You may see a security warning — continue to the site.)"

python3 serve_https.py &
HTTPS_PID=$!

trap "kill $HTTP_PID $HTTPS_PID >/dev/null 2>&1 || true" EXIT
wait
