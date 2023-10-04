import 'package:go_router/go_router.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_customer_app/config/app/app_router.dart';
import 'package:ecommerce_domain/domain/entities/products/product.dart';

import '../../../../../config/theme/colors/app_colors.dart';

extension ProductItemActions on ProductItem {
  void routeToProductDetailPage(BuildContext context, String productId) {
    context.goNamed(
      AppRouter.productDetail,
      pathParameters: {'id': productId},
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routeToProductDetailPage(context, product.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildProductCoverImage(),
          ),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              return AutoSizeText(
                product.title,
                maxLines: 2,
                presetFontSizes: const [16, 14, 12],
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.vampireBlack,
                ),
              );
            },
          ),
          Text(
            product.description,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.grayX11,
            ),
          ),
          Text(
            "${product.primaryCoins} Coins",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
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
