class ApiGateway {
  // Auth
  static const AUTH_PATH = "api/authentication";
  static final REGISTER = "$AUTH_PATH/register";
  static final LOGIN = "$AUTH_PATH/login";
  static final IS_TOKEN_VALID = "$AUTH_PATH/is-token-valid";
  static const DELETE_ACCOUNT = "$AUTH_PATH/delete";

  // Upload File
  static const UPLOAD_FILE_PATH = "api/up-load-file";
  static const GET_FILE_INFO = "$UPLOAD_FILE_PATH/";
  static const UPLOAD_SINGLE_FILE = "$UPLOAD_FILE_PATH/upload";
  static const UPLOAD_MULTIPLE_FILE = "$UPLOAD_FILE_PATH/uploads";

  // User
  static const USER_PATH = "api/user";
  static final GET_USER_DATA = "$USER_PATH/";
  // static final GET_INFO = "$USER_PATH/info";
  static final UPDATE_AVATAR = "$USER_PATH/avatar";
  static final SAVE_USER_TOKEN_FCM = "$USER_PATH/save-user-token-fcm";
  static final UPDATE_USER_INFO = "$USER_PATH/update-user-info";
  static final GET_FAVORITES = "$USER_PATH/get-favorites";

  // Product
  static const PRODUCT_PATH = "api/product";
  static final GET_PRODUCTS = "$PRODUCT_PATH/";
  static final GET_PRODUCT_CATEGORY = "$PRODUCT_PATH/categories?category=";
  static final GET_PRODUCT_SEARCH = "$PRODUCT_PATH/search/";
  static final GET_PRODUCT_TOP_REST = "$PRODUCT_PATH/get-products-top-rest";
  static final GET_PRODUCT_MOST_POPULAR =
      "$PRODUCT_PATH/get-products-most-popular";
  static final GET_PRODUCT_MOST_RECENT =
      "$PRODUCT_PATH/get-products-most-recent";
  static final ADD_PRODUCT = "$PRODUCT_PATH/add-product";
  static final UPDATE_PRODUCT = "$PRODUCT_PATH/update-product";
  static final DELETE_PRODUCT = "$PRODUCT_PATH/delete-product";
  static final RATE_PRODUCT = "$PRODUCT_PATH/rate-product";
  static final FAVORITE_PRODUCT = "$PRODUCT_PATH/favorate-product";

  // Order
  static const ORDER_PATH = "api/order";
  static final GET_ORDERS = "$ORDER_PATH/";
  static final GET_ORDERS_BY_ID = "$ORDER_PATH/get-by-id";
  static final ADD_ORDER = "$ORDER_PATH/add-order";
  static final CHANGE_ORDER_STATUS = "$ORDER_PATH/change-order-status";
  static final DELETE_ORDER = "$ORDER_PATH/delete-order";
  static final GET_EARNINGS = "$ORDER_PATH/analytics";

  // Twillio
  static const OTP_PATH = "api/otp";
  static final SEND_OTP = "$OTP_PATH/send-otp";
  static final VERIFY_OTP = "$OTP_PATH/verify-otp";

  // Notification
  static const NOTIFICATION_PATH = "api/notification";
  static final NOTIFICATION_URL =
      "https://fcm.googleapis.com//v1/projects/shop-app-1e566/messages:send";
  static final GET_NOTIFICATIONS = "$NOTIFICATION_PATH/";
  static final SEND_NOTIFICATION = "$NOTIFICATION_PATH/send-notification";
  static final SEEN_NOTIFICATION = "$NOTIFICATION_PATH/seen-notification";
}
