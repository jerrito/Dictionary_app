import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/widgets/text_field.dart';

class DefaultTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final bool? showSuffixIcon;
  final String? initialValue, hint;
  final void Function()? suffixOnTap;
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const DefaultTextFormField({
    super.key,
    this.suffixIcon,
    this.suffixOnTap,
    this.initialValue,
    this.showSuffixIcon,
    this.focusNode,
    required this.hint,
    required this.onChanged,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => DefaultTextField(
        showSuffixIcon: showSuffixIcon ?? false,
        onChange: onChanged,
        hint: hint,
        focusNode: focusNode!,
        controller: controller,
        suffixOnTap: suffixOnTap,
        errorText: field.errorText,
      ),
    );
  }
}
