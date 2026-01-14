import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> items = [];
  bool loading = false;

  Future<void> fetchCart() async {
    loading = true; notifyListeners();
    try {
      final res = await ApiService.dio.get(Endpoints.cart);
      if (res.statusCode == 200) {
        items = (res.data['items'] as List).map((e) => CartItem.fromJson(e)).toList();
      }
    } catch (e) {}
    loading = false; notifyListeners();
  }

  Future<bool> addToCart(int productId, int qty) async {
    try {
      final res = await ApiService.dio.post(Endpoints.cart, data: {"product_id": productId, "quantity": qty});
      if (res.statusCode == 200 || res.statusCode == 201) {
        await fetchCart();
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> updateCart(int productId, int qty) async {
    try {
      final res = await ApiService.dio.patch(Endpoints.cart, data: {"product_id": productId, "quantity": qty});
      if (res.statusCode == 200) {
        await fetchCart();
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<Response> checkout(Map<String, dynamic> payload) async {
    return ApiService.dio.post(Endpoints.checkout, data: payload);
  }
}
