import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_domain/data/repositories/products/product_repository_impl.dart';

import '../../../config/status/loading_status.dart';
import 'top_product_list_state.dart';

class TopProductListCubit extends Cubit<TopProductListState> {
  late final _productRepository = ProductRepositoryImpl();

  TopProductListCubit() : super(const TopProductListState());

  void loadProductList() async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
    ));
    final result = await _productRepository.getProductListOnTop();
    result.fold(
      (l) => emit(state.copyWith(
        loadingStatus: LoadingStatus.success,
        productList: l,
      )),
      (r) => emit(state.copyWith(
        loadingStatus: LoadingStatus.error,
        message: r.toString(),
      )),
    );
    emit(state.copyWith(
      loadingStatus: LoadingStatus.finish,
    ));
  }
}
