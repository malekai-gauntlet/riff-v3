self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('riff-v1').then((cache) => {
      return cache.addAll([
        '/',
        '/index.html',
        '/main.dart.js',
      ]);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
}); 