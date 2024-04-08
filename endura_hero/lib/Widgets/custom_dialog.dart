import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDialog extends StatelessWidget {
  final String? title;
  final List<Widget>? children;
  final EdgeInsets? contentPadding;
  final double? height;
  final bool? isShowClosebutton;

  const CustomDialog({Key? key, this.children, this.title, this.contentPadding, this.height, this.isShowClosebutton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 56.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  isShowClosebutton!
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: MaterialButton(
                            minWidth: 24,
                            height: 24,
                            elevation: 0,
                            onPressed: () {
                              Get.back();
                            },
                            color: Colors.red,
                            textColor: Colors.black,
                            padding: const EdgeInsets.all(2),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: height ?? MediaQuery.of(context).size.height * 0.62,
              ),
              padding: contentPadding ?? const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
