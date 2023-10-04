import 'package:dartz/dartz.dart';

import '../../entities/products/product.dart';

abstract class ProductRepository {
  Future<Either<List<Product>, Exception>> getProductListOnTop();
  Future<Either<Product, Exception>> getProduct(String id);
}
