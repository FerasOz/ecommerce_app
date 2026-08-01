import 'package:ecommerce_app/core/styles/app_colors.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/account/account_screen.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/home/home_screen.dart';
import 'package:ecommerce_app/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home/logic/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(sl())..fetchCategories(),
        ),
        BlocProvider(create: (context) => ProductsCubit(sl())..fetchProducts()),
      ],
      child: HomeScreen(),
    ),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 1,
        selectedItemColor: AppColors.primaryColor,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.sp),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30.sp),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30.sp),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
