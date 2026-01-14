class Endpoints {
  static const String baseUrl = "http://13.126.97.38:8000/api/";
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
  // Auth
  static const String register = "auth/register/";
  static const String login = "auth/login/";
  static const String googleLogin = "auth/google/";
  static const String passwordReset = "auth/password-reset/";
  static const String passwordResetConfirm = "auth/password-reset/confirm/";
  static const String me = "auth/me/";
  static const String refresh = "auth/token/refresh/";
  // Content / Home
  static const String products = "store/products/";
  static const String gallery = "content/gallery/";
  static const String testimonials = "content/testimonials/";
  // Cart / Orders
  static const String cart = "orders/cart/";
  static const String checkout = "orders/checkout/";
  static const String coupons = "orders/coupons/";
  // Projects / Requests
  static const String projectDashboard = "projects/dashboard/";
  static const String projectRequests = "projects/requests/";
  // Classes
  static const String classesSchedule = "projects/classes/schedule/";
  static String classReschedule(int id) => "projects/classes/$id/reschedule/";
}
