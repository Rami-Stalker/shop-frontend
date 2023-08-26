import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api/api_client.dart';
import '../../../models/cart_model.dart';

class CartRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CartRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });
  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList('cashe-cart', cart);
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey('cashe-cart-history')) {
      cartHistory =
          sharedPreferences.getStringList('cashe-cart-history')!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList('cashe-cart-history', cartHistory);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey('cashe-cart')) {
      carts = sharedPreferences.getStringList('cashe-cart') ?? [];
    }

    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<String> cartsHistory = [];
    if (sharedPreferences.containsKey('cashe-cart-history')) {
      cartsHistory =
          sharedPreferences.getStringList('cashe-cart-history') ?? [];
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartsHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove('cashe-cart');
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove('cashe-cart-history');
  }
}
