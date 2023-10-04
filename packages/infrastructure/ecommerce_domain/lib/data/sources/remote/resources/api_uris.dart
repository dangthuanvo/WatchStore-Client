class ApiUris {
  static const base = "http://localhost:8080/api/v1";

  // Products
  static const topProductList = "$base/products/top";
  static const product = "$base/product";

  // Auth
  static const customerLogin = "$base/authentication/customer/login";
  static const customerSignup = "$base/authentication/customer/register";

  // Customer
  static const productInCustomerCart = '$base/customer-cart/product';
  static const productListInCustomerCart = '$base/customer-cart/product-list';

  // Admin
}
