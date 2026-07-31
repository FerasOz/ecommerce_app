import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void showAinmatedSnackDialog(
  BuildContext context, {
  String? message,
  // required Color backgroundColor,
  AnimatedSnackBarType? type,
  // Duration duration = const Duration(seconds: 2),
}) {
  AnimatedSnackBar.material(
    message ?? "",
    type: type ?? AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
    // duration: duration,
  ).show(context);

  // final overlay = Overlay.of(context);
  // final overlayEntry = OverlayEntry(
  //   builder: (context) => Positioned(
  //     top: MediaQuery.of(context).size.height * 0.1,
  //     left: MediaQuery.of(context).size.width * 0.1,
  //     right: MediaQuery.of(context).size.width * 0.1,
  //     child: Material(
  //       color: Colors.transparent,
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         decoration: BoxDecoration(
  //           color: backgroundColor,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Text(message, style: const TextStyle(color: Colors.white)),
  //       ),
  //     ),
  //   ),
  // );

  // overlay?.insert(overlayEntry);

  // Future.delayed(duration, () {
  //   overlayEntry.remove();
  // });
}
