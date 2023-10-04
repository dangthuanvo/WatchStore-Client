import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';

import '../../../../../config/responsive/breakpoints.dart';
import '../../../../../config/widgets/loading_widget.dart';
import '../../../../../view_models/products/top_product_list_cubit/top_product_list_cubit.dart';
import '../../../../../view_models/products/top_product_list_cubit/top_product_list_state.dart';
import 'product_item.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  void initState() {
    super.initState();
    context.read<TopProductListCubit>().loadProductList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        return BlocBuilder<TopProductListCubit, TopProductListState>(
          builder: (context, state) {
            return Visibility(
              replacement: const SizedBox(
                height: 100,
                child: Center(child: LoadingWidget()),
              ),
              visible: state.loadingStatus.isFinished,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 280,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: maxWidth >= Breakpoints.tabletMedium ? 0 : 16,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.productList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = state.productList[index];
                  return ProductItem(product: product);
                },
              ),
            );
          },
        );
      },
    );
  }
}
