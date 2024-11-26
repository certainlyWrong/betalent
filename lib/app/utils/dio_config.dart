import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

// Global options
final options = CacheOptions(
  // A default store is required for interceptor.
  store: MemCacheStore(
    maxSize: 1024 * 1024 * 100, // 100MB. Default.
    maxEntrySize: 1024 * 1024 * 10, // 10MB. Default.
  ),

  // All subsequent fields are optional.

  // Default.
  policy: CachePolicy.forceCache,
  // Returns a cached response on error but for statuses 401 & 403.
  // Also allows to return a cached response on network errors (e.g. offline usage).
  // Defaults to [null].
  hitCacheOnErrorExcept: [401, 403],
  // Overrides any HTTP directive to delete entry past this duration.
  // Useful only when origin server has no cache config or custom behaviour is desired.
  // Defaults to [null].
  maxStale: const Duration(minutes: 10),
  // Default. Allows 3 cache sets and ease cleanup.
  priority: CachePriority.normal,
  // Default. Body and headers encryption with your own algorithm.
  cipher: null,
  // Default. Key builder to retrieve requests.
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  // Default. Allows to cache POST requests.
  // Overriding [keyBuilder] is strongly recommended when [true].
  allowPostMethod: false,
);

// Add cache interceptor with global/default options
final dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));

Future<(Response<dynamic> response, bool isCache)> fetchData(String url) async {
  final response = await dio.get(
    url,
  );

  final isCache = response.extra[CacheResponse.cacheKey] != null;
  if (isCache) {
    // Cache hit
    log('Fetched data from cache for $url', name: 'dio_cache');
  } else {
    // Network response
    log('Fetched data from server for $url', name: 'dio_cache');
  }

  return (response, isCache);
}
