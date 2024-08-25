import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? errorText, hint;
  final bool showSuffixIcon;
  final FocusNode focusNode;
  final void Function(String value)? onChange, onSubmitted;
  final void Function()? suffixOnTap;
  final TextEditingController controller;
  const DefaultTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.hint,
    required this.focusNode,
    required this.showSuffixIcon,
    required this.onChange,
    required this.onSubmitted,
    required this.suffixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      maxLines: 1,
      controller: controller,
      onChanged: onChange,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        iconColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.white),
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
