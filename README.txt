Wanted Poster Booth (Mobile-friendly, Free, Offline-first)
=================================================================

What you get:
- Modern UI
- Big WANTED title + optional Name field
- Camera capture (works best over HTTPS)
- Upload/take photo, compose poster locally, and download
- PWA (installable, basic offline cache)
- Works on iPhone/Android (use HTTPS link printed by setup)

How to run (macOS M1):
----------------------
1) Unzip this folder and open Terminal here:
   cd wanted-booth-v2
2) Run:
   bash setup.sh

This starts:
- http://localhost:8080  (for your Mac)
- https://<LAN_IP>:8443  (for your phone; accept the self-signed warning)

Notes:
------
- iOS Safari blocks live camera over plain HTTP on local network. Use the HTTPS link.
- If camera still fails, use the Upload button — it can open camera via the file picker.
- All processing happens in your browser; nothing is uploaded to any server.
