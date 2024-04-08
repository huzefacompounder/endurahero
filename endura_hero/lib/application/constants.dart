// ignore_for_file: must_be_immutable

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Const {
  /// Color
  static const Color kBackground = Color(0xFF131828);
  static const Color kGreyShade1 = Color(0xFF414753);
  static const Color kWhite = Colors.white;
  static const Color kBlack = Colors.black;
  static const Color kTransparent = Colors.transparent;
  static const Color kRed = Colors.red;
  static const Color kBlueShade1 = Color(0xFF887ff8);
  static const Color kPinkShade1 = Color(0xFFFF8093);

  ///Bold
  static TextStyle bold = GoogleFonts.roboto(
    color: Const.kWhite,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  /// Medium
  static TextStyle medium = GoogleFonts.roboto(
    color: Const.kWhite,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  ///Small
  static TextStyle small = GoogleFonts.roboto(
    color: Const.kWhite,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static ButtonStyle get buttonBorderStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: Const.kGreyShade1,
      elevation: 0,
      fixedSize: Size(double.infinity, 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.style,
    this.txtStyle,
    this.child,
    this.width = double.infinity,
    this.hight = 6,
    required this.onTap,
    required this.title,
    this.backgroundColor = Const.kBlueShade1,
  });
  final Function()? onTap;
  final String title;
  final ButtonStyle? style;
  final TextStyle? txtStyle;
  final Widget? child;
  final Color? backgroundColor;
  final double width;
  final double hight;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: backgroundColor,
            fixedSize: Size(width, hight.h),
          ),
      onPressed: onTap,
      child: child ??
          Center(
            child: Text(
              title,
              style: txtStyle ??
                  Const.medium
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 1.8.h),
            ),
          ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key, this.actionIcon, this.actionOnTap, this.leadingOnTap});
  IconData? actionIcon;
  void Function()? actionOnTap;
  void Function()? leadingOnTap;
  @override
  Size get preferredSize => Size.fromHeight(10.h);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Const.kBlueShade1,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 2.h, top: 2.h),
        decoration: BoxDecoration(
          color: Const.kGreyShade1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: leadingOnTap ??
              () {
                Navigator.pop(context);
              },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Const.kWhite,
          ),
        ),
      ),
      actions: [
        if (actionIcon != null)
          Container(
            width: 0.115.w,
            margin: EdgeInsets.only(right: 2.w, top: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Const.kGreyShade1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: actionOnTap,
              child: Icon(
                actionIcon,
                color: Const.kWhite,
              ),
            ),
          ),
      ],
    );
  }
}

class CustomCachedNetworkImage extends StatelessWidget {
  CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.child,
    this.height = double.infinity,
    this.width = double.infinity,
  });
  String imageUrl;
  Widget? child;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImageBuilder(
        url: imageUrl,
        builder: (img) => Stack(
          children: [
            Container(
              color: Const.kGreyShade1,
              width: width,
              height: height,
              child: Image.file(
                img,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.05),
              ),
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 0.01.w, bottom: 0.005.h),
                child: child,
              ),
            ),
          ],
        ),
        placeHolder: const CustomLoader(),
        errorWidget: const Icon(Icons.error, color: Const.kBackground),
      ),
    );
  }
}
// Show progress indicator

showProgressIndicator() {
  return EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
    status: 'Loading',
    dismissOnTap: false,
  );
}

// Dismiss progress indicator
dismissProgressIndicator() {
  return EasyLoading.dismiss();
}

errorSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Error',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

successSnackBar({String? title, required String message}) {
  Get.log('[$title] $message', isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon:
          const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.obscureText = false,
      this.onTap,
      this.suffixIcon,
      this.suffixOnPressed,
      this.validator});
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function()? suffixOnPressed;
  final int maxLines;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Const.small,
      validator: validator,
      cursorColor: Const.kWhite,
      decoration: InputDecoration(
        filled: true,
        fillColor: Const.kGreyShade1,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Const.kGreyShade1, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Const.kGreyShade1, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Const.kGreyShade1, width: 1),
        ),
        suffixIcon: GestureDetector(
          onTap: suffixOnPressed,
          child: Padding(
              padding: EdgeInsets.only(top: 0.02.h, bottom: 0.02.h),
              child: suffixIcon),
        ),
        hintText: hintText,
        hintStyle: Const.small,
      ),
    );
  }
}

Future<bool> onWillPop() {
  return Future.value(true);
}
