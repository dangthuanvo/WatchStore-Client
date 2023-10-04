// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:ecommerce_domain/core/use_case/use_case.dart';

import '../../entities/products/product.dart';
import '../../repositories/products/product_repository.dart';

class GetProductDetailParams {
  final String id;
  GetProductDetailParams({
    required this.id,
  });
}

class GetProductDetailUseCase implements UseCase<Product, GetProductDetailParams> {
  final ProductRepository _productRepository;

  GetProductDetailUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;
  @override
  Future<Either<Product, Exception>> call(GetProductDetailParams params) {
    return _productRepository.getProduct(params.id);
  }
}
