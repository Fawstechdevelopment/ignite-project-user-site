import 'dart:async';
import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'endpoints.dart';

class ApiService {
  static late Dio dio;
  static final _lock = Lock();
  static String _runtimeApiKey = '';

  static void setApiKey(String key) {
    _runtimeApiKey = key;
  }

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Accept": "application/json"},
      ),
    );

    // Add interceptor for Authorization and token refresh
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          final key = _runtimeApiKey.isNotEmpty
              ? _runtimeApiKey
              : Endpoints.apiKey;
          if (key.isNotEmpty) {
            options.headers['x-api-key'] = key;
            options.headers['X-Api-Key'] = key;
            options.headers['Api-Key'] = key;
            options.queryParameters = {
              'api_key': key,
              ...?options.queryParameters,
            };
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Try refresh on 401
          if (error.response?.statusCode == 401) {
            try {
              await _lock.synchronized(() async {
                final refreshed = await _refreshToken();
                if (refreshed) {
                  // repeat original request
                  final opts = error.requestOptions;
                  final clonedReq = await dio.request(
                    opts.path,
                    data: opts.data,
                    queryParameters: opts.queryParameters,
                    options: Options(
                      method: opts.method,
                      headers: opts.headers,
                      contentType: opts.contentType,
                      responseType: opts.responseType,
                    ),
                  );
                  return handler.resolve(clonedReq);
                } else {
                  // logout: tokens invalid
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('access_token');
                  await prefs.remove('refresh_token');
                }
              });
            } catch (e) {
              // ignore
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  static Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString('refresh_token');
    if (refresh == null) return false;

    try {
      final res = await Dio().post(
        '${Endpoints.baseUrl}${Endpoints.refresh}',
        data: {"refresh": refresh},
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (res.statusCode == 200) {
        final access = res.data['access'];
        if (access != null) {
          await prefs.setString('access_token', access);
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
