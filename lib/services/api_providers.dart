import 'dart:async';
import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:idea_1/services/api_cache_manager.dart';
import 'package:idea_1/services/error/server_exceptions.dart';
import 'package:idea_1/services/error/server_failures.dart';

class ApiProvider {
  final ApiCacheManager _cacheManager = ApiCacheManager();
  Future<dynamic> callTypeGet({
    bool? isUpdated,
    required String url,
    String? cacheKey,
  }) async {
    final headers = await _buildHeaders();

    if (cacheKey?.isNotEmpty == true) {
      final cachedResponse = await _getCache(cacheKey, isUpdated);
      if (cachedResponse != null) return cachedResponse;
    }
    final response = await _handleRequest(
      method: 'GET',
      url: url,
      cacheKey: cacheKey,
      isUpdated: isUpdated,
      headers: headers,
    );

    if (cacheKey?.isNotEmpty == true) {
      await _saveToCache(cacheKey, response);
    }
    return response;
  }

  FutureOr<Either<Failure, dynamic>> callTypePost({
    bool? isUpdated,
    required String url,
    String? cacheKey,
    required Map<String, dynamic>? body,
  }) async {
    final headers = await _buildHeaders();

    if (cacheKey?.isNotEmpty == true) {
      final cachedResponse = await _getCache(cacheKey, isUpdated);
      if (cachedResponse != null) return cachedResponse;
    }
    final response = await _handleRequest(
      method: 'POST',
      url: url,
      cacheKey: cacheKey,
      isUpdated: isUpdated,
      headers: headers,
      body: body,
    );

    if (cacheKey?.isNotEmpty == true) {
      await _saveToCache(cacheKey, response);
    }

    return response;
  }

  Future<Map<String, String>> _buildHeaders() async {
    final headers = <String, String>{
      "Content-Type": "application/json",
      // "Authorization": "Bearer",
    };
    return headers;
  }

  Future<dynamic> _handleRequest({
    required String method,
    required String url,
    String? cacheKey,
    bool? isUpdated,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      http.Response response;
      if (method == 'POST') {
        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
      } else {
        response = await http.get(Uri.parse(url), headers: headers);
      }
      final responseJson = _response(response);

      return responseJson;
    } on TimeoutException catch (e) {
      return Left(BadRequestException('Timeout Error: $e'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected Error: $e'));
    }
  }

  Either<Failure, dynamic> _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return Right(responseJson);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorizedException('Error: UNAUTHORIZED');
      case 403:
        throw ForbiddenException('Error: ${response.body.toString()}');
      case 404:
        throw NotFoundException('Error: ${response.body.toString()}');
      case 409:
        throw ConflictException('Error: ${response.body.toString()}');
      case 500:
        throw InternalServerErrorException(
            'Error: ${response.body.toString()}');
      case 503:
        throw ServiceUnavailableException('Error: ${response.body.toString()}');
      default:
        throw FetchDataException(
            'Unexpected error with StatusCode: ${response.statusCode}');
    }
  }

  FutureOr<Either<Failure, dynamic>?> _getCache(
      String? cacheKey, bool? isUpdated) async {
    if (cacheKey?.isNotEmpty == true) {
      final cachedData = await _cacheManager.getFile(key: cacheKey ?? "");
      if (cachedData != null && isUpdated != true) {
        // If cache exists and isUpdated is false, return cached data
        final decodedData = json.decode(utf8.decode(cachedData));
        return Future.value(Right(decodedData));
      }
    }
    return null;
  }

// Private method to save the response data to the cache
  Future<void> _saveToCache(String? cacheKey, dynamic response) async {
    if (cacheKey?.isNotEmpty == true && response is Right) {
      final responseData = response.value;
      await _cacheManager.saveFile(
        bytes: Uint8List.fromList(utf8.encode(json.encode(responseData))),
        key: cacheKey ?? "",
      );
    }
  }
}
