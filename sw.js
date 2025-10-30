self.addEventListener('install', (e) => {
  e.waitUntil(caches.open('wb-v2').then(c => c.addAll([
    './','./index.html','./poster_template.png','./manifest.webmanifest'
  ])));
});
self.addEventListener('fetch', (e) => {
  e.respondWith(caches.match(e.request).then(r => r || fetch(e.request)));
});
