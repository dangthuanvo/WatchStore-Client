import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_domain/domain/use_cases/general/get_product_detail_use_case.dart';

import '../../../config/status/loading_status.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase _getProductDetailUseCase;

  ProductDetailCubit({
    required final GetProductDetailUseCase getProductDetailUseCase,
  })  : _getProductDetailUseCase = getProductDetailUseCase,
        super(const ProductDetailState());

  Future<void> loadProduct(String id) async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
    ));
    final result =
        await _getProductDetailUseCase.call(GetProductDetailParams(id: id));

    result.fold(
      (l) => emit(state.copyWith(
        loadingStatus: LoadingStatus.success,
        product: l,
      )),
      (r) => emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          message: r.toString(),
        ),
      ),
    );
    emit(
      state.copyWith(loadingStatus: LoadingStatus.finish),
    );
  }
}
