import 'package:dartz/dartz.dart';
import 'package:ecommerce_domain/core/use_case/use_case.dart';
import 'package:ecommerce_domain/domain/repositories/cart/cart_repository.dart';

class AddProductToCartParams {
  final String productId;
  final String accessToken;

  AddProductToCartParams({
    required this.productId,
    required this.accessToken,
  });
}

class AddProductToCartUseCase extends UseCase<void, AddProductToCartParams> {
  final CartRepository _cartRepository;

  AddProductToCartUseCase({
    required final CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<void, Exception>> call(AddProductToCartParams params) async {
    final result = await _cartRepository.addProductByIdToCart(
      params.productId,
      accessToken: params.accessToken,
    );
    return result;
  }
}
