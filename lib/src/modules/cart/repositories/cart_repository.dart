import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../models/cart_model.dart';

class CartRepository {
  CartRepository();

  final _getStorage = GetStorage();
  final cartKey = 'cashe-cart';
  final cartHistoryKey = "cashe-cart-history";

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    _getStorage.write(cartKey, cart);
  }

  void addToCartHistoryList() {
    if (_getStorage.read(cartHistoryKey) != null) {
      cartHistory = _getStorage.read<List<String>>(cartHistoryKey)??[];
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart();
    _getStorage.write(cartHistoryKey, cartHistory);
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];

    var rawData = _getStorage.read(cartKey);
    if (rawData != null) {
      for (var element in rawData) {
        cartList.add(CartModel.fromJson(jsonDecode(element)));
      }
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartHistoryList = [];

    var rawData = _getStorage.read(cartHistoryKey);
    if (rawData != null) {
      for (var element in rawData) {
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
      }
    }
    return cartHistoryList;
  }

  void removeCart() {
    cart = [];
    _getStorage.remove(cartKey);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    _getStorage.remove(cartHistoryKey);
  }
}
