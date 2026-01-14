import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';

class ProjectProvider extends ChangeNotifier {
  bool loading = false;
  List<dynamic> projects = [];
  List<dynamic> gallery = [];
  List<dynamic> cartItems = [];
  String? errorMessage;

  Future<void> loadProjects() async {
    loading = true;
    notifyListeners();

    try {
      final productsRes = await ApiService.dio.get(Endpoints.products);
      final productsData = productsRes.data;
      if (productsData is Map && productsData['results'] is List) {
        projects = List.from(productsData['results']);
      } else if (productsData is List) {
        projects = productsData;
      } else {
        projects = [];
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("Error loading projects: $e");
    }

    loading = false;
    notifyListeners();
  }

  Future<void> loadGallery() async {
    try {
      final res = await ApiService.dio.get(Endpoints.gallery);
      final data = res.data;
      if (data is Map && data['results'] is List) {
        gallery = List.from(data['results']);
      } else if (data is List) {
        gallery = data;
      } else {
        gallery = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading gallery: $e');
    }
  }

  Future<bool> addToCart({required int productId, int quantity = 1}) async {
    try {
      final res = await ApiService.dio.post(
        Endpoints.cart,
        data: FormData.fromMap({'product_id': productId, 'quantity': quantity}),
      );
      await loadCart();
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      debugPrint('Add to cart failed: $e');
      return false;
    }
  }

  Future<void> loadCart() async {
    try {
      final res = await ApiService.dio.get(Endpoints.cart);
      final data = res.data;
      if (data is Map && data['results'] is List) {
        cartItems = List.from(data['results']);
      } else if (data is Map && data['items'] is List) {
        cartItems = List.from(data['items']);
      } else if (data is List) {
        cartItems = data;
      } else {
        cartItems = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Load cart failed: $e');
    }
  }
}
