import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styles/app_text_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_dialog.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/core/widgets/primary_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (dialogContext) => showLogOutDialog(dialogContext),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(Icons.logout, color: Colors.redAccent, size: 25.sp),
            const WidthSpace(8),
            Text(
              "Logout",
              style: AppStyles.black15BoldStyle.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialog showLogOutDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      child: SizedBox(
        height: 400.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeightSpace(20),
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.redAccent,
                size: 52.sp,
              ),
              const HeightSpace(22),
              Text("LogOut", style: AppStyles.primaryHeadLinesStyle),
              const HeightSpace(8),
              Text(
                "Are you sure you want to logout?",
                style: AppStyles.grey12MediumStyle,
              ),
              const HeightSpace(12),
              PrimayButtonWidget(
                buttonColor: Colors.redAccent,
                buttonText: "Yes, logout",
                onPress: () {
                  sl<StorageHelper>().removeToken();
                  context.pushReplacementNamed(AppRoutes.loginScreen);
                  showAinmatedSnackDialog(
                    context,
                    message: "Logged out successfully",
                  );
                },
              ),
              const HeightSpace(8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  fixedSize: Size(331.w, 56.h),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "No, cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
