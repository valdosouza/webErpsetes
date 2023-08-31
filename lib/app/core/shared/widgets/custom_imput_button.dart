import 'package:flutter/material.dart';

import 'package:appweb/app/core/shared/theme.dart';

class CustomInputButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final double? width;
  final int? maxLines;
  final Widget? suffixIcon;
  final Function()? onAction;
  final String? initialValue;
  final bool readOnly;
  final String? hint;
  final TextInputAction inputAction;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? sufixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final int? minLines;

  final Alignment alignment;
  final TextAlign textAlign;
  const CustomInputButton({
    Key? key,
    required this.title,
    required this.enabled,
    this.width = 0,
    this.maxLines,
    this.suffixIcon,
    this.onAction,
    this.initialValue,
    this.readOnly = false,
    this.hint,
    required this.inputAction,
    required this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.sufixIcon,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.minLines,
    this.alignment = Alignment.centerRight,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double newWidth = 0;
    if (width == 0) {
      newWidth = MediaQuery.of(context).size.width;
    } else {
      newWidth = width!;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: newWidth,
                  alignment: alignment,
                  decoration: kBoxDecorationStyle,
                  child: TextFormField(
                    textAlign: textAlign,
                    initialValue: initialValue,
                    readOnly: readOnly,
                    keyboardType: keyboardType,
                    autofocus: false,
                    textInputAction: inputAction,
                    validator: validator,
                    onFieldSubmitted: onFieldSubmitted,
                    onChanged: onChanged,
                    obscureText: obscureText,
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    minLines: minLines,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffix: sufixIcon,
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      hintText: hint ?? "",
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: (onAction != null)
                    ? IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          onAction!();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
