import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';
import 'package:ecommerce_customer_app/config/texts/localized_texts.dart';

import 'products_in_cart_state.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/get_product_list_in_cart_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/add_product_to_cart_use_case.dart';
import 'package:ecommerce_domain/domain/use_cases/customer/cart/remove_product_from_cart_use_case.dart';

class ProductsInCartCubit extends Cubit<ProductsInCartState> {
  final GetProductListInCartUseCase _getProductListInCartUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;

  ProductsInCartCubit({
    required final GetProductListInCartUseCase getProductListInCartUseCase,
    required final AddProductToCartUseCase addProductToCartUseCase,
    required final RemoveProductFromCartUseCase removeProductFromCartUseCase,
  })  : _getProductListInCartUseCase = getProductListInCartUseCase,
        _addProductToCartUseCase = addProductToCartUseCase,
        _removeProductFromCartUseCase = removeProductFromCartUseCase,
        super(const ProductsInCartState());

  void setAccessToken(String token) {
    emit(state.copyWith(accessToken: token));
  }

  Future<void> loadProductList() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _getProductListInCartUseCase
        .call(GetProductListInCartParams(accessToken: state.accessToken));
    result.fold((l) {
      emit(state.copyWith(
        productList: l,
        loadingStatus: LoadingStatus.success,
      ));
    }, (r) {
      emit(state.copyWith(
        message: r.toString(),
        loadingStatus: LoadingStatus.error,
      ));
    });

    emit(state.copyWith(loadingStatus: LoadingStatus.finish));
  }

  Future<void> addProductByIdToCart(String id) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _addProductToCartUseCase.call(
      AddProductToCartParams(productId: id, accessToken: state.accessToken),
    );
    result.fold(
      (l) {
        emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          message: LocalizedTexts.addToCartSuccess,
        ));

        _reloadProductList();
      },
      (r) => emit(state.copyWith(
        loadingStatus: LoadingStatus.error,
        message: r.toString(),
      )),
    );

    emit(state.copyWith(loadingStatus: LoadingStatus.finish));
  }

  Future<void> removeProductByIdFromCart(String id) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _removeProductFromCartUseCase.call(
      RemoveProductFromCartParams(productId: id, accessToken: state.accessToken),
    );
    result.fold(
      (l) {
        emit(state.copyWith(
          loadingStatus: LoadingStatus.success,
          message: LocalizedTexts.addToCartSuccess,
        ));

        _reloadProductList();
      },
      (r) => emit(state.copyWith(
        loadingStatus: LoadingStatus.error,
        message: r.toString(),
      )),
    );

    emit(state.copyWith(loadingStatus: LoadingStatus.finish));
  }

  void _reloadProductList() {
    EasyDebounce.debounce(
      '_reload_product_after_modifying',
      const Duration(milliseconds: 1500),
      () {
        loadProductList();
      },
    );
  }
}
