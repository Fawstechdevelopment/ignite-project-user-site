import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';
import '../models/custom_request.dart';

class RequestProvider extends ChangeNotifier {
  List<CustomRequest> requests = [];
  bool loading = false;

  Future<bool> createCustomRequest({
    required Map<String, dynamic> fields,
    String? filePath, // file path on local - for web you will pass bytes
  }) async {
    loading = true;
    notifyListeners();
    try {
      FormData fd = FormData();
      fields.forEach((k, v) => fd.fields.add(MapEntry(k, v.toString())));
      if (filePath != null) {
        fd.files.add(
          MapEntry('reference_file', await MultipartFile.fromFile(filePath)),
        );
      }
      final res = await ApiService.dio.post(
        Endpoints.projectRequests,
        data: fd,
      );
      loading = false;
      notifyListeners();
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchMyRequests() async {
    loading = true;
    notifyListeners();
    try {
      final res = await ApiService.dio.get(Endpoints.projectRequests);
      if (res.statusCode == 200) {
        requests = (res.data as List)
            .map((j) => CustomRequest.fromJson(j))
            .toList();
      }
    } catch (e) {}
    loading = false;
    notifyListeners();
  }

  Future<bool> payRequest(
    int id, {
    bool useDefaultAddress = true,
    String coupon = "",
  }) async {
    final res = await ApiService.dio.post(
      "${Endpoints.projectRequests}$id/pay/",
      data: {"use_default_address": useDefaultAddress, "coupon_code": coupon},
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
}
