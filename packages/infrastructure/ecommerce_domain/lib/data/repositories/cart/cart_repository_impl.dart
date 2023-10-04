import 'package:dartz/dartz.dart';
import 'package:ecommerce_domain/data/models/products/data_product.dart';
import 'package:ecommerce_domain/data/sources/remote/resources/api_uris.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';
import 'package:ecommerce_domain/domain/repositories/cart/cart_repository.dart';

import '../../sources/remote/network_service_mixin.dart';

class CartRepositoryImpl with NetworkServiceMixin implements CartRepository {
  @override
  Future<Either<void, Exception>> addProductByIdToCart(
    final String productId, {
    required String accessToken,
  }) async {
    final response = await post(
      "${ApiUris.productInCustomerCart}/$productId",
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return response.bimap((l) => l, (r) => r);
  }

  @override
  Future<Either<List<Product>, Exception>> getProductListInCart({
    required String accessToken,
  }) async {
    final response = await get(
      ApiUris.productListInCustomerCart,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return response.bimap(
      (l) => ((l['data'] ?? []) as List)
          .map((e) => DataProduct.fromMap(e).toEntity())
          .toList(),
      (r) => r,
    );
  }

  @override
  Future<Either<void, Exception>> removeProductByIdFromCart(
    String productId, {
    required String accessToken,
  }) async {
    final response = await delete(
      "${ApiUris.productInCustomerCart}/$productId",
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return response.bimap((l) => l, (r) => r);
  }
}
