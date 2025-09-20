class ApiConstants {
  static const String apiBaseUrl = "https://fakestoreapi.com";
  static const String productsEndpoint = "$apiBaseUrl/products";
  static const String productDetailsEndpoint = "$apiBaseUrl/products/{id}";
  static const String categoriesEndpoint = "$apiBaseUrl/products/categories";
}

class ApiErrors {
  static const String unknownError = "Unknown Error";
  static const String noInternetError = "No Internet Connection";
  static const String timeoutError = "Request Timed Out";
}

class AppMessages {
  static const String loading = "Loading...";
}
