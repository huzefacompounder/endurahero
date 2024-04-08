import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BaseDropDown extends StatelessWidget {
  final String? value;
  final List<String?> options;
  final String hint;
  final void Function(String?)? onChanged;

  const BaseDropDown({
    Key? key,
    this.onChanged,
    this.value,
    required this.options,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String?> finalOptions = [hint, ...options];

    return Container(
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(maxHeight: 6.h),
      height: 6.0.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: DropdownButton(
        borderRadius: BorderRadius.circular(5),
        enableFeedback: true,
        underline: const SizedBox(),
        autofocus: false,
        isExpanded: true,
        isDense: true,
        elevation: 0,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 30,
          color: Colors.white,
        ),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.amber,
        ),
        value: value ?? hint,
        onChanged: onChanged,
        selectedItemBuilder: (context) {
          return finalOptions.map(
            (option) {
              return option == hint
                  ? Text(
                      option!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  : Text(
                      option!,
                    );
            },
          ).toList();
        },
        items: finalOptions.map(
          (option) {
            return DropdownMenuItem(
              value: option,
              child: option == hint
                  ? Text(
                      option!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                  : Text(
                      option!,
                    ),
            );
          },
        ).toList(),
      ),
    );
  }
}
