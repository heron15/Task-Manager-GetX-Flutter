import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.textInputType,
    required this.titleText,
    required this.hintText,
    this.showSuffixIcon = false,
    required this.validator,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.obscureText = false,
    this.maxLine = 1,
    this.enabled = true,
  });

  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String titleText;
  final String hintText;
  final bool showSuffixIcon;
  final String? Function(String? value) validator;
  final double topPadding;
  final double bottomPadding;
  final bool obscureText;
  final int maxLine;
  final bool enabled;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding, bottom: widget.bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColor.textColorPrimary,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: TextFormField(
              onTapOutside: (value) {
                FocusScope.of(context).unfocus();
              },
              controller: widget.textEditingController,
              keyboardType: widget.textInputType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColor.themeColor,
              obscureText: _obscureText,
              maxLines: widget.maxLine,
              enabled: widget.enabled,
              decoration: InputDecoration(
                fillColor: AppColor.editTextBg,
                filled: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColor.textColorSecondary.withAlpha(150),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Visibility(
                  visible: widget.showSuffixIcon,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColor.textColorSecondary.withAlpha(150),
                    ),
                  ),
                ),
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
