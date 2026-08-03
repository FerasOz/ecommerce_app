import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styles/app_colors.dart';
import 'package:ecommerce_app/core/styles/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';
import 'package:ecommerce_app/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home/logic/categories_cubit/categories_state.dart';
import 'package:ecommerce_app/features/home/logic/products_cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home/logic/products_cubit/products_state.dart';
import 'package:ecommerce_app/features/home/ui/widgets/category_item_widget.dart';
import 'package:ecommerce_app/features/home/ui/widgets/product_grid_shimmer_widget.dart';
import 'package:ecommerce_app/features/home/ui/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(28),
          SizedBox(
            width: 335.w,
            child: Text("Discover", style: AppStyles.primaryHeadLinesStyle),
          ),
          const HeightSpace(16),
          Row(
            children: [
              CustomTextField(width: 270.w, hintText: "Search For Clothes"),
              const WidthSpace(8),
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          const HeightSpace(16),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesSuccessState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categories
                        .map(
                          (category) => CategoryItemWidget(
                            categoryName: category,
                            isSelected: selectedCategory == category,
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                                if (selectedCategory == "All") {
                                  context.read<ProductsCubit>().fetchProducts();
                                } else {
                                  context
                                      .read<ProductsCubit>()
                                      .fetchCategoryProducts(category);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const HeightSpace(16),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoadingState) {
                return const ProductGridShimmerWidget();
              }

              if (state is ProductsSuccessState) {
                List<ProductsModel> products = state.products;
                return Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      setState(() {
                        selectedCategory = "All";
                      });
                      context.read<ProductsCubit>().fetchProducts();
                    },
                    child: AnimationLimiter(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.sp,
                          crossAxisSpacing: 16.sp,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 200.0,
                              child: FadeInAnimation(
                                child: ProductItemWidget(
                                  title: product.title ?? "",
                                  price: product.price.toString(),
                                  rating: product.rating?.rate ?? 0.0,
                                  image: product.image ?? "",
                                  onTap: () {
                                    context.pushNamed(
                                      AppRoutes.productScreen,
                                      extra: product,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
