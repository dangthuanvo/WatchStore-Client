import 'package:dartz/dartz.dart';

import '../../../core/use_case/use_case.dart';
import '../../entities/products/product.dart';
import '../../repositories/products/product_repository.dart';

class GetProductListOnTopUseCase implements UseCase<List<Product>, void> {
  final ProductRepository _productRepository;

  GetProductListOnTopUseCase({
    required final ProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  Future<Either<List<Product>, Exception>> call(params) {
    return _productRepository.getProductListOnTop();
  }
}
