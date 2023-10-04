import 'package:dartz/dartz.dart';

import '../../entities/products/product.dart';

abstract class CartRepository {
  Future<Either<void, Exception>> addProductByIdToCart(
    final String productId, {
    required String accessToken,
  });
  Future<Either<void, Exception>> removeProductByIdFromCart(
    final String productId, {
    required String accessToken,
  });
  Future<Either<List<Product>, Exception>> getProductListInCart({
    required final String accessToken,
  });
}
