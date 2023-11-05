import 'package:get/get.dart';
import '../../../public/components.dart';
import '../../../routes/app_pages.dart';
import '../repositories/cart_repository.dart';
import '../../../themes/app_colors.dart';

import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

class CartController extends GetxController implements GetxService {
  final CartRepository cartRepository;
  CartController({
    required this.cartRepository,
  });

  late Map<String, CartModel> _items = {};
  Map<String, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  final Rx<int> quantity = 0.obs;
  final Rx<bool> _isValid = false.obs;
  Rx<bool> get isValid => _isValid;

  void addItem(ProductModel product, int quantity) {
    if (_items.containsKey(product.id)) {
      if (quantity > 0) {
        _items.update(
          product.id!,
          (value) {
            return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              image: value.image,
              isExist: true,
              userQuant: quantity,
              time: DateTime.now().toString(),
              rating: value.rating,
              product: product,
            );
          },
        );
      } else {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            image: product.images[0],
            name: product.name,
            price: product.price,
            isExist: true,
            userQuant: quantity,
            time: DateTime.now().toString(),
            rating: product.ratings,
            product: product,
          );
        });
      } else {
        Components.showSnackBar(title: "Cart", "Not Add To Cart");
      }
    }
    cartRepository.addToCartList(getItems);
    update();
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      print('11111111111');
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.userQuant!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    Rx<int> totalQuantity = 0.obs;
    _items.forEach((key, value) {
      totalQuantity.value += value.userQuant!;
    });
    return totalQuantity.value;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get subtotal {
    int total = 0;
    _items.forEach((key, value) {
      total += value.userQuant! * value.price!;
    });
    return total;
  }

  double get tax {
    double tax = 0;
    _items.forEach((key, value) {
      String taxString = "14 %";
      int taxPercentage = int.tryParse(taxString.replaceAll('%', '')) ?? 0;

      double itemDiscount =
          (value.userQuant! * value.price! * taxPercentage / 100);
      tax += itemDiscount;
    });
    return tax;
  }

  double get discount {
    double totalDiscount = 0;
    _items.forEach((key, value) {
      int discount = value.product!.discount!;

      double itemDiscount =
          (value.userQuant! * value.price! * discount / 100);
      totalDiscount += itemDiscount;
    });
    return totalDiscount;
  }

  double get total {
    double total = 0;
    total = subtotal + tax - discount;
    return total;
  }

  void addToCartList() {
    cartRepository.addToCartList(getItems);
    update();
  }

  List<CartModel> getCartList() {
    setCart = cartRepository.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
    }
    update();
  }

  void addToCartHistoryList() {
    cartRepository.addToCartHistoryList();
    clear();
    AppNavigator.popUntil(AppRoutes.NAVIGATION);
    update();
  }

  void clear() {
    _items.clear();
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepository.getCartHistoryList();
  }

  set setItems(Map<String, CartModel> setItems) {
    _items = {};
    _items = setItems;
    update();
  }

  void clearCartHistory() {
    cartRepository.clearCartHistory();
    update();
  }

  void setQuantity(bool isIncrement, int productQuantity) {
    if (isIncrement) {
      quantity.value = checkQuantity(quantity.value + 1, productQuantity);
    } else {
      quantity.value = checkQuantity(quantity.value - 1, productQuantity);
    }
  }

  int checkQuantity(int quantity, int productQuantity) {
    if (quantity > productQuantity) {
      Components.showSnackBar(
        "You ordered more than the available quantity \n available quantity is $productQuantity !",
        title: "Item count",
        color: colorBranch,
      );
      _isValid.value = false;
      return productQuantity;
    } else {
      _isValid.value = true;
      return quantity;
    }
  }
}
