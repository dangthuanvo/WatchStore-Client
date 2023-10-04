// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';

import '../../../config/status/loading_status.dart';

class TopProductListState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<Product> productList;
  final String message;

  const TopProductListState({
    this.loadingStatus = LoadingStatus.pure,
    this.productList = const [],
    this.message = '',
  });

  TopProductListState copyWith({
    LoadingStatus? loadingStatus,
    List<Product>? productList,
    String? message,
  }) {
    return TopProductListState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      productList: productList ?? this.productList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [loadingStatus, productList, message];
}
