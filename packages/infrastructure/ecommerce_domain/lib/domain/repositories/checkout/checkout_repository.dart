import 'package:dartz/dartz.dart';

abstract class CheckoutRepository {
  Future<Either<void, Exception>> buyProductBydId(String productId);
  Future<Either<void, Exception>> buyProductGroupById(String productGroupid);

  Future<Either<void, Exception>> buyProductList({required List<String> idList});
  Future<Either<void, Exception>> buyProductGroupList({
    required List<String> idList,
  });
}
