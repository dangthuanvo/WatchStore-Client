// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_customer_app/ui/config/app_bar/web/web_app_bar.dart';

import '../../view_models/products/product_detail_cubit/product_detail_cubit.dart';
import 'product_detail_view.dart';

class ProductDetailPageParams {
  final String? productId;
  ProductDetailPageParams({
    required this.productId,
  });
}

class ProductDetailPage extends StatelessWidget {
  final ProductDetailPageParams params;
  const ProductDetailPage({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WebAppBar(),
          const SizedBox(height: 24),
          BlocProvider(
            create: (context) => ProductDetailCubit(
              getProductDetailUseCase: GetIt.instance(),
            ),
            child: ProductDetailView(
              productId: params.productId,
            ),
          ),
        ],
      ),
    );
  }
}
