// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';

class ProductDetailState extends Equatable {
  final LoadingStatus loadingStatus;
  final String message;
  final Product? product;

  const ProductDetailState({
    this.loadingStatus = LoadingStatus.pure,
    this.message = '',
    this.product,
  });

  ProductDetailState copyWith({
    LoadingStatus? loadingStatus,
    String? message,
    Product? product,
  }) {
    return ProductDetailState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      message: message ?? this.message,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [loadingStatus, message, product];
}
