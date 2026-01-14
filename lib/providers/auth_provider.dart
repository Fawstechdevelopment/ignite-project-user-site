import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool loading = false;
  String? lastError;
  static const String _envGoogleIdToken = String.fromEnvironment(
    'GOOGLE_ID_TOKEN',
    defaultValue: '',
  );

  String _extractErrorMessage(Object e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map && data.isNotEmpty) {
        final first = data.values.first;
        return first?.toString() ?? (e.message ?? 'Unexpected error');
      }
      return e.message ?? 'Network error';
    }
    return e.toString();
  }

  AuthProvider() {
    _tryAutoLogin();
  }

  Future<void> _tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      // token exists, fetch profile
      await fetchProfile();
    }
  }

  Future<bool> login(String email, String password) async {
    loading = true;
    notifyListeners();
    try {
      final form = FormData.fromMap({"email": email, "password": password});
      final res = await ApiService.dio.post(Endpoints.login, data: form);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        if (res.data['access'] != null) {
          await prefs.setString('access_token', res.data['access']);
        }
        if (res.data['refresh'] != null) {
          await prefs.setString('refresh_token', res.data['refresh']);
        }
        await fetchProfile();
        loading = false;
        notifyListeners();
        lastError = null;
        return true;
      }
    } catch (e) {
      lastError = _extractErrorMessage(e);
    }
    loading = false;
    notifyListeners();
    return false;
  }

  Future<bool> loginWithGoogle({String? idToken}) async {
    loading = true;
    notifyListeners();
    try {
      final token = (idToken ?? _envGoogleIdToken).trim();
      final data = FormData.fromMap({
        'id_token': token,
        'firebase_token': token,
        'provider': 'google',
      });
      final res = await ApiService.dio.post(Endpoints.googleLogin, data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        final access =
            res.data['access'] ?? res.data['access_token'] ?? res.data['token'];
        final refresh = res.data['refresh'] ?? res.data['refresh_token'];
        if (access != null) {
          await prefs.setString('access_token', access.toString());
        }
        if (refresh != null) {
          await prefs.setString('refresh_token', refresh.toString());
        }
        await fetchProfile();
        loading = false;
        notifyListeners();
        lastError = null;
        return true;
      }
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map && data.isNotEmpty) {
          lastError = data.values.first?.toString();
        } else {
          lastError = e.message;
        }
      } else {
        lastError = e.toString();
      }
    }
    loading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    user = null;
    notifyListeners();
  }

  Future<bool> register(Map<String, dynamic> payload) async {
    loading = true;
    notifyListeners();
    try {
      final res = await ApiService.dio.post(Endpoints.register, data: payload);
      loading = false;
      notifyListeners();
      lastError = null;
      return res.statusCode == 201 || res.statusCode == 200;
    } catch (e) {
      lastError = _extractErrorMessage(e);
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchProfile() async {
    try {
      await ApiService.init(); // ensure dio is ready
      final res = await ApiService.dio.get(Endpoints.me);
      if (res.statusCode == 200) {
        user = User.fromJson(res.data);
        notifyListeners();
        return true;
      }
    } catch (e) {
      // ignore
    }
    return false;
  }

  Future<bool> sendPasswordReset(String email) async {
    loading = true;
    notifyListeners();
    try {
      final res = await ApiService.dio.post(
        Endpoints.passwordReset,
        data: FormData.fromMap({'email': email}),
      );
      loading = false;
      notifyListeners();
      lastError = null;
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      lastError = _extractErrorMessage(e);
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> confirmPasswordReset({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    loading = true;
    notifyListeners();
    try {
      final res = await ApiService.dio.post(
        Endpoints.passwordResetConfirm,
        data: FormData.fromMap({
          'email': email,
          'otp': otp,
          'password': newPassword,
        }),
      );
      loading = false;
      notifyListeners();
      lastError = null;
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      if (e is DioException) {
        final data = e.response?.data;
        if (data is Map && data.isNotEmpty) {
          lastError = data.values.first?.toString();
        } else {
          lastError = e.message;
        }
      } else {
        lastError = e.toString();
      }
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
