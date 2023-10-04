import 'package:dartz/dartz.dart';
import 'package:ecommerce_domain/core/use_case/use_case.dart';
import 'package:ecommerce_domain/domain/repositories/cart/cart_repository.dart';

class RemoveProductFromCartParams {
  final String productId;
  final String accessToken;

  RemoveProductFromCartParams({
    required this.productId,
    required this.accessToken,
  });
}

class RemoveProductFromCartUseCase
    extends UseCase<void, RemoveProductFromCartParams> {
  final CartRepository _cartRepository;

  RemoveProductFromCartUseCase({
    required final CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  @override
  Future<Either<void, Exception>> call(
      RemoveProductFromCartParams params) async {
    final result = await _cartRepository.removeProductByIdFromCart(
      params.productId,
      accessToken: params.accessToken,
    );
    return result;
  }
}
