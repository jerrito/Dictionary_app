import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';

class DefaultTextField extends StatelessWidget {
  final String? errorText, hint;
  final bool showSuffixIcon;
  final FocusNode focusNode;
  final void Function(String value)? onChange;
  final void Function()? suffixOnTap;
  final TextEditingController controller;
  const DefaultTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.hint,
    required this.focusNode,
    this.onChange,
    required this.showSuffixIcon,
    required this.suffixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      maxLength: 350,
      controller: controller,
      onChanged: onChange,
      focusNode: focusNode,
      onTapOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.height(context, 0.01))
        ),
        hintText: hint,
        suffixIcon: showSuffixIcon
            ? GestureDetector(
                onTap: suffixOnTap, child: const Icon(Icons.clear))
            : const SizedBox(),
        errorText: errorText,
      ),
    );
  }
}
