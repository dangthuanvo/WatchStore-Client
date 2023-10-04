import 'package:dartz/dartz.dart';

import '../../../domain/entities/products/product.dart';
import '../../../domain/repositories/products/product_repository.dart';
import '../../models/products/data_product.dart';
import '../../sources/remote/network_service_mixin.dart';
import '../../sources/remote/resources/api_uris.dart';

class ProductRepositoryImpl
    with NetworkServiceMixin
    implements ProductRepository {
  @override
  Future<Either<List<Product>, Exception>> getProductListOnTop() async {
    final response = await get(ApiUris.topProductList);
    return response.bimap(
      (l) {
        final objects = l['data'];
        return objects is Iterable
            ? objects.map((e) => DataProduct.fromMap(e).toEntity()).toList()
            : [];
      },
      (r) => r,
    );
  }

  @override
  Future<Either<Product, Exception>> getProduct(String id) async {
    final response = await get("${ApiUris.product}/$id");
    return response.bimap(
      (l) {
        return DataProduct.fromMap(l['data']).toEntity();
      },
      (r) => r,
    );
  }
}
