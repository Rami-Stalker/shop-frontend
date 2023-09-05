class ApiGateway {
  // Auth
  static final REGISTER = "api/authentication/register";
  static final LOGIN = "api/authentication/login";
  static final IS_TOKEN_VALID = "api/authentication/is-token-valid";
  static const DELETE_ACCOUNT = "api/authentication";

  // Upload File
  static const UPLOAD_SINGLE_FILE = "api/up-load-file/upload";
  static const UPLOAD_MULTIPLE_FILE = "api/up-load-file/uploads";
  static const GET_FILE_INFO = "api/up-load-file";

  // User
  static final USER = "api/user/";
  static final GET_INFO = "api/user/info";
  static final UPDATE_AVATAR = "api/user/avatar";
  static final SAVE_USER_TOKEN_FCM = "api/user/save-user-token-fcm";
  static final MODIFY_USER_INFO = "api/user/modify-user-info";

  // Product
  static final GET_PRODUCTS = "api/product/";
  static final GET_CATEGORY = "api/product/categories?category=";
  static final GET_SEARCH = "api/product/search/";
  static final GET_RATING = "api/product/get-rating";
  static final GET_NEWEST = "api/product/get-newest";
  static final ADD_PRODUCT = "api/product/add-product";
  static final UPDATE_PRODUCT = "api/product/update-product";
  static final DELETE_PRODUCT = "api/product/delete-product";
  static final RATE_PRODUCT = "api/product/rate-product";

  // Order
  static final GET_ORDERS = "api/order/";
  static final GET_ORDERS_BY_ID = "api/order/get-by-id";
  static final ADD_ORDER = "api/order/add-order";
  static final CHANGE_ORDER_STATUS = "api/order/change-order-status";
  static final DELETE_ORDER = "api/order/delete-order";
  static final GET_EARNINGS = "api/order/analytics";

  // Twillio
  static final SEND_OTP = "api/otp/send-otp";
  static final VERIFY_OTP = "api/otp/verify-otp";

  // Notification
  static final NOTIFICATIONURL = "https://fcm.googleapis.com//v1/projects/shop-app-1e566/messages:send";
  static final SEND_NOTIFICATION = "api/notification/send-notification";
  static final GET_NOTIFICATIONS = "api/notification/";
  static final SEEN_NOTIFICATION = "api/notification/seen-notification";
}
