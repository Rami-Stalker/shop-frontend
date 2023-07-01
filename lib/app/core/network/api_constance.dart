class ApiConstance {
  // base
  static const String baseUrl = "http://192.168.13.79:3000";
  // admin
  static const String addProduct = "$baseUrl/admin/add-product";
  static const String getProducts = "$baseUrl/admin/get-products";
  static const String deleteProduct = "$baseUrl/admin/delete-product";
  static const String updateProduct = "$baseUrl/admin/update-product";
  static const String getEarnings = "$baseUrl/admin/analytics";
  // auth
  static const String signUp = "$baseUrl/api/signup";
  static const String signIn = "$baseUrl/api/signin";
  static const String isTokenValid = "$baseUrl/tokenIsValid";
  // get user data
  static const String getUserData = "$baseUrl/get-user-data";
  // cart
  static const String removeFromCart = "$baseUrl/api/remove-from-cart/";
  // check out
  static const String addOrder = "$baseUrl/api/add-order";
  // home
  static const String category = "$baseUrl/api/products?category=";
  static const String getRatingProducts = "$baseUrl/api/get-rating-products";
  static const String getNewestProducts = "$baseUrl/api/get-newest-products";
  static const String getUserOrder = "$baseUrl/api/get-user-Orders";
  // product details
  static const String updateProductQuantity =
      "$baseUrl/api/update-product-quantity";
  static const String rateProduct = "$baseUrl/api/rate-product";
  // search
  static const String productsSearch = "$baseUrl/api/products/search/";
  // update profile
  static const String saveUserData = "$baseUrl/api/save-user-data";
  // order
  static const String getAllOrder = "$baseUrl/admin/get-orders";
  static const String changeOrderStatus = "$baseUrl/admin/change-order-status";
  static const String deleteOrder = "$baseUrl/admin/delete-order";
}
