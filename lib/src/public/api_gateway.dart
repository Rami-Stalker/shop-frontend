
import '../config/application.dart';

class ApiGateway {
  // base
  static final BASEURL = Application.baseUrl;

  // Auth
  static final REGISTER = "$BASEURL/api/authentication/register";
  static final LOGIN = "$BASEURL/api/authentication/login";
  static final IS_TOKEN_VALID = "$BASEURL/api/authentication/is-token-valid";
  static const DELETE_ACCOUNT = 'api/authentication';

  // Upload File
  static const UPLOAD_SINGLE_FILE = 'api/up-load-file/upload';
  static const UPLOAD_MULTIPLE_FILE = 'api/up-load-file/uploads';
  static const GET_FILE_INFO = 'api/up-load-file';

  // User
  static final USER = "$BASEURL/api/user/";
  static final GET_INFO = "$BASEURL/api/user/info";
  static const UPDATE_AVATAR = 'api/user/avatar';
  static final SAVE_USER_TOKEN_FCM = "$BASEURL/api/user/save-user-token-fcm";
  static final MODIFY_USER_INFO = "$BASEURL/api/user/modify-user-info";

  // Product
  static final GET_PRODUCTS = "$BASEURL/api/product/";
  static final GET_CATEGORY = "$BASEURL/api/product/categories?category=";
  static final GET_SEARCH = "$BASEURL/api/product/search/";
  static final GET_RATING = "$BASEURL/api/product/get-rating";
  static final GET_NEWEST = "$BASEURL/api/product/get-newest";
  static final ADD_PRODUCT = "$BASEURL/api/product/add-product";
  static final UPDATE_PRODUCT = "$BASEURL/api/product/update-product";
  static final DELETE_PRODUCT = "$BASEURL/api/product/delete-product";
  // static final RATE_PRODUCT = "$BASEURL/api/product/get-rate-product";

  // Order
  static final GET_ORDERS = "$BASEURL/api/order/";
  static final GET_ORDERS_BY_ID = "$BASEURL/api/order/get-by-id";
  static final ADD_ORDER = "$BASEURL/api/order/add-order";
  static final CHANGE_ORDER_STATUS = "$BASEURL/api/order/change-order-status";
  static final DELETE_ORDER = "$BASEURL/api/order/delete-order";
  static final GET_EARNINGS = "$BASEURL/api/order/analytics";

  // Twillio
  static final SEND_OTP = "$BASEURL/api/otp/send-otp";
  static final VERIFY_OTP = "$BASEURL/api/otp/verify-otp";

  // Notification
  static final NOTIFICATIONURL = "https://fcm.googleapis.com//v1/projects/shop-app-1e566/messages:send";
  static final SEND_NOTIFICATION = "$BASEURL/api/notification/send-notification";
  static final GET_NOTIFICATIONS = "$BASEURL/api/notification/";
  static final SEEN_NOTIFICATION = "$BASEURL/api/notification/seen-notification";
}
