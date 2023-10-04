import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';

import '../../../view_models/cart/products_in_cart/products_in_cart_cubit.dart';
import '../../../view_models/cart/products_in_cart/products_in_cart_state.dart';
import 'cell/product_item_in_cart_cell.dart';

extension CartItemListViewAction on CartItemListView {
  void productsInCartModifyingListener(
      BuildContext context, ProductsInCartState state) {
    switch (state.loadingStatus) {
      case LoadingStatus.loading:
        EasyLoading.show();
      default:
        EasyLoading.dismiss();
    }
  }
}

class CartItemListView extends StatelessWidget {
  const CartItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsInCartCubit, ProductsInCartState>(
      listener: productsInCartModifyingListener,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${state.productList.length} khóa học trong Giỏ hàng",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                final product = state.productList[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: ProductItemInCartCell(
                    product: product,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
