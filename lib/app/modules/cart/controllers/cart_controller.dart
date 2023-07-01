import 'package:get/get.dart';
import 'package:shop_app/app/core/utils/components/components.dart';
import 'package:shop_app/app/modules/cart/repositories/cart_repository.dart';

import '../../../core/utils/app_colors.dart';
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

  void addItem(String? id, ProductModel product, int quantity) {
    if (_items.containsKey(id)) {
      if (quantity > 0) {
        _items.update(
          id!,
          (value) {
            return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              image: value.image,
              isExist: true,
              quantity: quantity,
              time: DateTime.now().toString(),
              rating: value.rating,
              product: product,
            );
          },
        );
      } else {
        _items.remove(id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(id!, () {
          return CartModel(
            id: product.id,
            image: product.images[0],
            name: product.name,
            price: product.price,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
            rating: product.rating,
            product: product,
          );
        });
      } else {
        Get.snackbar('no Add', 'no Add');
      }
    }
    cartRepository.addToCartList(getItems);
    update();
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    Rx<int> totalQuantity = 0.obs;
    _items.forEach((key, value) {
      totalQuantity.value += value.quantity!;
    });
    return totalQuantity.value;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  int get totalOldAmount {
    int totalOld = 0;
    _items.forEach((key, value) {
      totalOld += value.quantity! * value.product!.oldPrice;
    });
    return totalOld;
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
      Components.showCustomSnackBar(
        "You ordered more than the available quantity \n available quantity is $productQuantity !",
        title: "Item count",
        color: AppColors.mainColor,
      );
      _isValid.value = false;
      return productQuantity;
    } else {
      _isValid.value = true;
      return quantity;
    }
  }
}
