import 'package:go_router/go_router.dart';
import 'package:ecommerce_customer_app/ui/cart/cart_page.dart';
import 'package:ecommerce_customer_app/ui/profile/profile_page.dart';

import '../../ui/auth/login/login_page.dart';
import '../../ui/auth/signup/signup_page.dart';
import '../../ui/product_detail/product_detail_page.dart';
import '../../ui/home/home_page.dart';
import '../page_transition/page_transition.dart';

class AppRouter {
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';
  static const profile = '/profile';
  static const customerCart = '/customer-cart';
  static const productDetail = '/product-detail';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        pageBuilder: (context, state) {
          return PageTransition.fade(
            page: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) {
          return PageTransition.fade(
            page: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: signup,
        pageBuilder: (context, state) {
          return PageTransition.fade(
            page: const SignupPage(),
          );
        },
      ),
      GoRoute(
        path: profile,
        pageBuilder: (context, state) {
          return PageTransition.fade(
            page: const ProfilePage(),
          );
        },
      ),
      GoRoute(
        name: productDetail,
        path: "$productDetail/:id",
        pageBuilder: (context, state) {
          final productId = state.pathParameters['id'];
          return PageTransition.fade(
            page: ProductDetailPage(
                params: ProductDetailPageParams(
              productId: productId,
            )),
          );
        },
      ),
      GoRoute(
        path: customerCart,
        pageBuilder: (context, state) {
          return PageTransition.fade(
            page: const CartPage(),
          );
        },
      )
    ],
  );
}
