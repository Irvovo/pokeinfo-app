'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "87591ac47b67a8b23cae386ebf351d21",
"assets/AssetManifest.bin.json": "07de14b37353abba54149097bac6711c",
"assets/AssetManifest.json": "bb04e35cc0d0340349ed3f6b1b27aa58",
"assets/assets/capa_jogos/1.jpg": "1819072ae322596c389cf47e7e0bdbb2",
"assets/assets/capa_jogos/2.jpg": "915da9a0a2875110481f06a02386bdff",
"assets/assets/capa_jogos/3.jpg": "e4bb68924f2fb51faa7868a9f7688433",
"assets/assets/capa_jogos/4.jpg": "560349f2f72aa72bfeea293f65976b29",
"assets/assets/capa_jogos/5.jpg": "137b69da0606096d704b199a1053cd55",
"assets/assets/capa_jogos/6.jpg": "a2932f541ec0dad12e2f9321393a3352",
"assets/assets/capa_jogos/7.jpg": "9b7042d0ed42f73d977e7262da5e100f",
"assets/assets/capa_jogos/8.jpg": "e4d010f8811dc11e69a7855cc48aca0e",
"assets/assets/icons_type/bug.png": "8d9d4dc2100050062d23e6da6eeccf31",
"assets/assets/icons_type/dark.png": "ce3060adc43201d6bb72ead59ee77227",
"assets/assets/icons_type/dragon.png": "48a3e3f9ee27efee27b63e9569ee02cf",
"assets/assets/icons_type/electric.png": "5c25eb3ebd50d27a19e8e6dd853d1f70",
"assets/assets/icons_type/fairy.png": "ac799dfe1cd05ae4576f09f78f6dc386",
"assets/assets/icons_type/fighting.png": "106877d4ff409ce657243fc878653704",
"assets/assets/icons_type/fire.png": "38c7197de49923b8eee8938cf580668a",
"assets/assets/icons_type/flying.png": "a3bbe1033952ff3f91ae946a9f56009b",
"assets/assets/icons_type/ghost.png": "361c0a14ee7f69d6568e903e24497fe3",
"assets/assets/icons_type/grass.png": "de88252673bba5d07d689841a24d513a",
"assets/assets/icons_type/ground.png": "890a5d64ac2d10eb2a65ab79bc234c4b",
"assets/assets/icons_type/ice.png": "4265107b0d7113df838b9535ed5aa200",
"assets/assets/icons_type/normal.png": "cc64914fdf794120c402ef28c174aba3",
"assets/assets/icons_type/poison.png": "c6d40ee751e607967290c8b3a77203f2",
"assets/assets/icons_type/psychic.png": "715dbcc4fdd1d987366fed875c64f9ee",
"assets/assets/icons_type/rock.png": "49993f20c32b839e94c7c38daed7b86d",
"assets/assets/icons_type/steel.png": "e06c01c33f5fdc742a67d2979bb77757",
"assets/assets/icons_type/stellar.png": "be969d072b0345d0e3e0b3f9cc48c023",
"assets/assets/icons_type/unknown.png": "d0f5932e0d5a6052a0915a5e3b531e09",
"assets/assets/icons_type/water.png": "79fa8f2feb4a8edd15943daf446872dd",
"assets/assets/imagem_2025-04-06_133701040.svg": "fbbed4c16922a6a9d5cdd9578dd3cb4d",
"assets/assets/logo.png": "d29f0fa7195258cb7d357b025b5ceff6",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "06761efa3fd4e8efef526198a1a3a7c3",
"assets/NOTICES": "f4642e24f5dd3aec978a055d0bb64291",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "c1987beb82fd630d526e2ec6e7028b69",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "acfffd1a083ede0eda1ab3d5f3f26ff8",
"/": "acfffd1a083ede0eda1ab3d5f3f26ff8",
"main.dart.js": "5548644c6743930d3054af048c160523",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "9ea3ef83837ee2afc18b4c64172c70b2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
