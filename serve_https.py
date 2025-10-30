#!/usr/bin/env python3
import http.server, ssl, os, sys

PORT = int(os.environ.get("PORT", "8443"))
CERT_FILE = "cert.pem"
KEY_FILE = "key.pem"

Handler = http.server.SimpleHTTPRequestHandler
httpd = http.server.HTTPServer(("", PORT), Handler)
if not (os.path.exists(CERT_FILE) and os.path.exists(KEY_FILE)):
    print("Missing cert.pem/key.pem. Run setup.sh to generate a self-signed cert.")
    sys.exit(1)

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile=CERT_FILE, keyfile=KEY_FILE)
httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

print(f"🔒 HTTPS server on https://0.0.0.0:{PORT}")
httpd.serve_forever()
