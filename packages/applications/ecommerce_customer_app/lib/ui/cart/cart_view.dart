import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_customer_app/config/responsive/breakpoints.dart';
import 'package:ecommerce_customer_app/ui/cart/custom/cart_item_list_view.dart';

import '../../config/texts/localized_texts.dart';
import '../../view_models/auth/auth_cubit.dart';
import '../../view_models/cart/products_in_cart/products_in_cart_cubit.dart';
import 'custom/checkout_container.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    final token = context.read<AuthCubit>().state.loginResult?.accessToken;
    if (token != null) {
      context.read<ProductsInCartCubit>()
        ..setAccessToken(token)
        ..loadProductList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            LocalizedTexts.cart,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          
          Flexible(
            child: Wrap(
              direction: Axis.horizontal,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Breakpoints.mobileBreakpoint,
                  ),
                  child: const Center(
                    child: CartItemListView(),
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size.square(24),
                ),
                const CheckoutContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
