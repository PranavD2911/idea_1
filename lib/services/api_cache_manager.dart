import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:idea_1/services/log.dart';

/// Registered as lazy singleton in Get It. CacheManger can only have one instance per documentation.
class ApiCacheManager {
  static const cacheManagerKey = 'activityPlannerCacheManager';
  // final _defaultCacheManager = DefaultCacheManager();
  final _cacheManager = CacheManager(
    Config(
      cacheManagerKey,
      stalePeriod: const Duration(
        minutes: 10,
      ),
    ),
  );

  Future<void> emptyCache() async {
    await _cacheManager.emptyCache();
  }

  Future<void> emptyCacheOfFile({required String key}) async {
    try {
      await _cacheManager.removeFile(key);
    } catch (e) {}
  }

  Future<Uint8List?> getFile({required String key}) async {
    if (key.isEmpty) return null;

    FileInfo? fileInfo = await _cacheManager.getFileFromCache(key);
    if (fileInfo == null) {
      return null;
    }

    try {
      if (fileInfo.validTill.isAfter(DateTime.now())) {
        final fileBytes = await fileInfo.file.readAsBytes();
        return fileBytes;
      }
    } catch (e) {
      Log.error('ApiCacheManager failed to getFile for $key with error: $e');
    }

    return null;
  }

  Future<void> saveFile({
    required Uint8List bytes,
    required String key,
    String fileExtension = "json",
  }) async {
    if (key.isEmpty) return;

    try {
      await _cacheManager.putFile(
        key,
        Uint8List.fromList(bytes),
        maxAge: const Duration(minutes: 30),
        fileExtension: fileExtension,
      );
    } catch (e) {
      Log.error("ApiCacheManager failed to saveFile with error: $e");
    }
  }
}
