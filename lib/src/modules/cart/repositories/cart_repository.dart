import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_model.dart';

class CartRepository {
  final SharedPreferences prefs;
  CartRepository(this.prefs);

  final cartKey = 'cashe-cart';
  final cartHistoryKey = "cashe-cart-history";

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      element.product?.ratings = [];
      cart.add(jsonEncode(element));
    }
    prefs.setStringList(cartKey, cart);
  }

  void addToCartHistoryList() {
    if (prefs.getStringList(cartHistoryKey) != null) {
      cartHistory = prefs.getStringList(cartHistoryKey) ?? [];
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    prefs.setStringList(cartHistoryKey, cartHistory);
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];

    var rawData = prefs.getStringList(cartKey);
    if (rawData != null) {
      for (var element in rawData) {
        cartList.add(CartModel.fromJson(jsonDecode(element)));
      }
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartHistoryList = [];

    var rawData = prefs.getStringList(cartHistoryKey);
    if (rawData != null) {
      for (var element in rawData) {
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
      }
    }
    return cartHistoryList;
  }

  void removeCart() {
    cart = [];
    prefs.remove(cartKey);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    prefs.remove(cartHistoryKey);
  }
}
