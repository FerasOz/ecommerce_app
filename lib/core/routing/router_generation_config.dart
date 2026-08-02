import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/address/address_screen.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/screens/login_screen.dart';
import 'package:ecommerce_app/features/auth/screens/register_screen.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';
import 'package:ecommerce_app/features/main/main_screen.dart';
import 'package:ecommerce_app/features/product/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static GoRouter createRouter(String initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          name: AppRoutes.loginScreen,
          path: AppRoutes.loginScreen,
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.registerScreen,
          path: AppRoutes.registerScreen,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          name: AppRoutes.mainScreen,
          path: AppRoutes.mainScreen,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          name: AppRoutes.addressScreen,
          path: AppRoutes.addressScreen,
          builder: (context, state) => const AddressScreen(),
        ),
        GoRoute(
          name: AppRoutes.productScreen,
          path: AppRoutes.productScreen,
          builder: (context, state) =>
              ProductScreen(product: state.extra as ProductsModel),
        ),
      ],
    );
  }
}
