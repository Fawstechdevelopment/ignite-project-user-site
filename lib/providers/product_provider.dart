import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool loading = false;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();
    try {
      final res = await ApiService.dio.get(Endpoints.products);
      if (res.statusCode == 200) {
        products = (res.data as List).map((e) => Product.fromJson(e)).toList();
      }
    } catch (e) {
      // handle
    }
    loading = false;
    notifyListeners();
  }

  Future<List<dynamic>> getGallery() async {
    final res = await ApiService.dio.get(Endpoints.gallery);
    return res.data as List<dynamic>;
  }

  Future<List<dynamic>> getTestimonials() async {
    final res = await ApiService.dio.get(Endpoints.testimonials);
    return res.data as List<dynamic>;
  }
}
