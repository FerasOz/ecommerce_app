import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styles/app_assets.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/account/widgets/account_item_widget.dart';
import 'package:ecommerce_app/features/account/widgets/logout_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          const HeightSpace(20),
          AccountItemWidget(
            iconPath: AppAssets.box,
            title: "My Orders",
            onTap: () {},
          ),
          const Divider(thickness: 8, color: Color(0xffE6E6E6)),
          AccountItemWidget(
            iconPath: AppAssets.details,
            title: "My Details",
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.address,
            title: "Address Book",
            onTap: () {
              context.pushNamed(AppRoutes.addressScreen);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.question,
            title: "FAQ",
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.help,
            title: "Help Center",
            onTap: () {},
          ),
          const HeightSpace(16),
          Divider(thickness: 8, color: Color(0xffE6E6E6)),
          const Spacer(),
          LogoutButtonWidget(),
          const HeightSpace(20),
        ],
      ),
    );
  }
}
