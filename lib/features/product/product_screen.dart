import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styles/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/primary_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';
import 'package:flutter/material.dart';
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
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? "",
                      fit: BoxFit.cover,
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
                        "${product.rating ?? 0.0}/5",
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
                      PrimayButtonWidget(
                        width: MediaQuery.of(context).size.width * 0.5,
                        buttonText: "Add To Cart",
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        onPress: () {},
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
