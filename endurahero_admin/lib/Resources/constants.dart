import 'package:flutter/material.dart';
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
    this.hight = 0,
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
            backgroundColor: Colors.amber,
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

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.actionIcon,
      this.actionOnTap,
      this.leadingOnTap,
      this.leadingIcon,
      this.title});
  String? title;
  IconData? actionIcon;
  IconData? leadingIcon;
  void Function()? actionOnTap;
  void Function()? leadingOnTap;
  @override
  Size get preferredSize => Size.fromHeight(10.h);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '', style: Const.bold.copyWith(color: Colors.amber)),
      centerTitle: true,
      backgroundColor: Const.kBackground,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 2.h, top: 1.h, bottom: 1.h),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: leadingOnTap ??
              () {
                Navigator.pop(context);
              },
          child: Icon(
            leadingIcon,
            color: Const.kWhite,
          ),
        ),
      ),
      actions: [
        if (actionIcon != null)
          Container(
            width: 10.w,
            margin: EdgeInsets.only(right: 2.h, top: 1.h, bottom: 1.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
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
      this.readOnly = false,
      this.validator});
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
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
      readOnly: readOnly,
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
        hintStyle: Const.small.copyWith(color: Colors.amber),
      ),
    );
  }
}

Future<bool> onWillPop() {
  // Get.off(const LoginScreen());
  return Future.value(true);
}
