import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styles/app_text_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final Function()? onTap;
  const ProductItemWidget({
    super.key,
    required this.title,
    required this.price,
    this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                height: 150.h,
                fit: BoxFit.contain,
              ),
            ),
            const HeightSpace(4),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.black15BoldStyle.copyWith(fontSize: 12.sp),
            ),
            const HeightSpace(4),
            Text(
              "\$$price",
              style: AppStyles.grey12MediumStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 8.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
