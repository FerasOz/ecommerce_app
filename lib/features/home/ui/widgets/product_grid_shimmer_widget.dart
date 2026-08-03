import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridShimmerWidget extends StatelessWidget {
  const ProductGridShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.sp,
            crossAxisSpacing: 16.sp,
            childAspectRatio: 0.8,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                const HeightSpace(4),
                Container(
                  width: double.infinity,
                  height: 20.h,
                  color: Colors.grey[300],
                ),
                const HeightSpace(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50.w,
                      height: 20.h,
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: 30.w,
                      height: 20.h,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
