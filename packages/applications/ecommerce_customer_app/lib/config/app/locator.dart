import 'package:get_it/get_it.dart';
import 'package:ecommerce_domain/data/repositories/auth/auth_repository_impl.dart';
import 'package:ecommerce_domain/data/repositories/products/product_repository_impl.dart';
import 'package:ecommerce_domain/domain/repositories/cart/cart_repository.dart';
import 'package:ecommerce_domain/data/repositories/cart/cart_repository_impl.dart';
import 'package:ecommerce_domain/domain/repositories/repositories.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/auth/customer_login_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/auth/customer_signup_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/add_product_to_cart_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/get_product_list_in_cart_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/remove_product_from_cart_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/general/get_product_detail_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/general/get_product_list_on_top_use_case.dart';

final GetIt _getIt = GetIt.instance;

final ProductRepository _productRepository = ProductRepositoryImpl();
final AuthRepository _authRepository = AuthRepositoryImpl();
final CartRepository _cartRepository = CartRepositoryImpl();

void registerUseCases() {
  _getIt.registerSingleton(
    CustomerLoginUseCase(authRepository: _authRepository),
  );
  _getIt.registerSingleton(
    CustomerSignupUseCase(authRepository: _authRepository),
  );
  _getIt.registerSingleton(
    GetProductListOnTopUseCase(productRepository: _productRepository),
  );
  _getIt.registerSingleton(
    GetProductDetailUseCase(productRepository: _productRepository),
  );
  _getIt.registerSingleton(
    AddProductToCartUseCase(cartRepository: _cartRepository),
  );
  _getIt.registerSingleton(
    GetProductListInCartUseCase(cartRepository: _cartRepository),
  );
  _getIt.registerSingleton(
    RemoveProductFromCartUseCase(cartRepository: _cartRepository),
  );
}
