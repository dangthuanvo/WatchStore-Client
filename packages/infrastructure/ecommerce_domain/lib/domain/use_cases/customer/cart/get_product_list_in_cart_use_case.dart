import 'package:dartz/dartz.dart';
import 'package:ecommerce_domain/core/use_case/use_case.dart';

import '../../../entities/products/product.dart';
import '../../../repositories/cart/cart_repository.dart';

class GetProductListInCartParams {
  final String accessToken;
  GetProductListInCartParams({
    required this.accessToken,
  });
}

class GetProductListInCartUseCase
    implements UseCase<List<Product>, GetProductListInCartParams> {
  final CartRepository _cartRepository;

  GetProductListInCartUseCase({
    required final CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<List<Product>, Exception>> call(
      GetProductListInCartParams params) {
    return _cartRepository.getProductListInCart(accessToken: params.accessToken);
  }
}
