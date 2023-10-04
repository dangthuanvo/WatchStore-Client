import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_customer_app/config/app/app_router.dart';
import 'package:ecommerce_customer_app/config/status/loading_status.dart';
import 'package:ecommerce_customer_app/config/texts/localized_texts.dart';
import 'package:ecommerce_customer_app/config/widgets/loading_widget.dart';
import 'package:ecommerce_customer_app/ui/config/buttons/common_elevated_button.dart';
import 'package:ecommerce_customer_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_customer_app/view_models/cart/products_in_cart/products_in_cart_cubit.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';

import '../../config/theme/colors/app_colors.dart';
import '../../view_models/products/product_detail_cubit/product_detail_state.dart';
import '../../view_models/products/product_detail_cubit/product_detail_cubit.dart';

extension ProductDetailViewActions on ProductDetailView {
  void addToCart(BuildContext context, String productId) {
    final token = context.read<AuthCubit>().state.loginResult?.accessToken;
    if (token != null) {
      context.read<ProductsInCartCubit>()
        ..setAccessToken(token)
        ..addProductByIdToCart(productId);
    } else {
      context.go(AppRouter.login);
    }
  }

  void buyNow(BuildContext context, Product product) {
    final isAuthoried = context.read<AuthCubit>().state.isAuthoried;
    if (isAuthoried) {}
    {
      context.go(AppRouter.login);
    }
  }
}

class ProductDetailView extends StatefulWidget {
  final String? productId;
  const ProductDetailView({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      context.read<ProductDetailCubit>().loadProduct(widget.productId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return Visibility(
          visible: state.loadingStatus != LoadingStatus.loading,
          replacement: const LoadingWidget(),
          child: Builder(builder: (context) {
            final product = state.product;
            if (product == null) {
              return const Placeholder();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Flexible(
                    child: _ProductTitle(
                      product: product,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Flexible(
                    child: SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 48,
                            child: CommonElevatedButton(
                              outlined: true,
                              title: LocalizedTexts.addToCart,
                              onPressed: () =>
                                  widget.addToCart(context, product.id),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 48,
                            child: CommonElevatedButton(
                              title: LocalizedTexts.buyNow,
                              onPressed: () => widget.buyNow(context, product),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _ProductTitle extends StatelessWidget {
  final Product product;

  const _ProductTitle({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildProductCoverImage(),
          ),
          const SizedBox(height: 16),
          AutoSizeText(
            product.title,
            maxLines: 10,
            presetFontSizes: const [16, 14, 12],
            overflow: TextOverflow.clip,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.vampireBlack,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            maxLines: 10,
            style: const TextStyle(
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.grayX11,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${product.primaryCoins} Coins",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppColors.vampireBlack,
            ),
          ),
        ],
      ),
    );
  }

  Image _buildProductCoverImage() {
    return Image.network(
      product.coverImage,
      fit: BoxFit.cover,
    );
  }
}
