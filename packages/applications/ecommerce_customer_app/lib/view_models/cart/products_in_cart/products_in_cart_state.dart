import 'package:equatable/equatable.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';

class ProductsInCartState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<Product> productList;
  final String message;
  final String accessToken;

  const ProductsInCartState({
    this.loadingStatus = LoadingStatus.pure,
    this.productList = const [],
    this.message = '',
    this.accessToken = '',
  });

  ProductsInCartState copyWith({
    LoadingStatus? loadingStatus,
    List<Product>? productList,
    String? message,
    String? accessToken,
  }) {
    return ProductsInCartState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      productList: productList ?? this.productList,
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  List<Object> get props => [loadingStatus, productList, message];
}
