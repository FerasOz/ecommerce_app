import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styles/app_text_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_dialog.dart';
import 'package:ecommerce_app/core/widgets/primary_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_state.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  final ProductsModel product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(20),
                  SizedBox(
                    width: 341.w,
                    height: 341.h,
                    child: Hero(
                      tag: "product${product.title}",
                      child: CachedNetworkImage(
                        imageUrl: product.image ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    product.title ?? "",
                    style: AppStyles.black16w500Style.copyWith(fontSize: 24.sp),
                  ),
                  const HeightSpace(8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18.sp),
                      const WidthSpace(2),
                      Text(
                        "${product.rating?.rate ?? 0.0}/5",
                        style: AppStyles.black15BoldStyle.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const WidthSpace(2),
                      Text(
                        "(45 Reviews)",
                        style: AppStyles.grey12MediumStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                  Text(
                    product.description ?? "",
                    style: AppStyles.grey12MediumStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const HeightSpace(150),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Divider(),
                  HeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: AppStyles.grey12MediumStyle.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          HeightSpace(4),
                          Text(
                            "\$${product.price ?? 0.0}",
                            style: AppStyles.black16w500Style.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const WidthSpace(16),
                      BlocConsumer<CartCubit, CartState>(
                        builder: (context, state) {
                          return PrimayButtonWidget(
                            width: MediaQuery.of(context).size.width * 0.5,
                            isLoading: state is AddingCartLoadingState,
                            buttonText: "Add To Cart",
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            onPress: () {
                              context.read<CartCubit>().addingToCart(
                                quantity: 1,
                                product: product,
                              );
                              if (state is AddingCartLoadingState) {
                                showAinmatedSnackDialog(
                                  context,
                                  message: "Added to cart",
                                  type: AnimatedSnackBarType.info,
                                );
                              }
                            },
                          );
                        },
                        listener: (BuildContext context, CartState state) {
                          if (state is AddingCartSuccessState) {
                            showAinmatedSnackDialog(
                              context,
                              message: "Added Successfully to cart",
                            );
                          } else if (state is AddingCartErrorState) {
                            showAinmatedSnackDialog(
                              context,
                              message: state.errorMessage,
                              type: AnimatedSnackBarType.error,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
