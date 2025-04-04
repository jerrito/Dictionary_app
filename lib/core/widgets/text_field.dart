import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DefaultTextField extends StatelessWidget {
  final String? errorText, hint;
  final bool showSuffixIcon;
  final FocusNode focusNode;
  final void Function(String value)? onChange, onSubmitted;
  final void Function()? suffixOnTap, prefixOnTap;
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
    this.prefixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? DictionaryColors.primary50
                : DictionaryColors.primary300));
    return SizedBox(
      height: Sizes.height(
        context,
        0.055,
      ),
      child: TextField(
        cursorColor: DictionaryColors.success300,
        style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? DictionaryColors.primaryBase
                : DictionaryColors.whiteBackground),
        maxLines: 1,
        controller: controller,
        onChanged: onChange,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Theme.of(context).brightness != Brightness.light
                  ? DictionaryColors.primary50
                  : DictionaryColors.primary300),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? DictionaryColors.primary50
              : DictionaryColors.primary300,
          enabledBorder: border,
          border: border,
          focusedBorder: border,
          // suffixIconColor: Colors.white,

          hintText: hint,
          suffixIcon: showSuffixIcon
              ? GestureDetector(
                  onTap: suffixOnTap,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: CircleAvatar(
                        radius: Sizes.height(
                          context,
                          0.012,
                        ),
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? DictionaryColors.whiteBackground
                                : DictionaryColors.blackBackground,
                        child: Icon(
                          size: Sizes.height(context, 0.02),
                          Icons.clear,
                          color: Theme.of(context).brightness != Brightness.dark
                              ? DictionaryColors.whiteBackground
                              : DictionaryColors.blackBackground,
                        )),
                  ))
              : const SizedBox.shrink(),

          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
            child: GestureDetector(
              onTap: prefixOnTap,
              child: SvgPicture.asset(
                DictionarySvgs.searchSVG,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? DictionaryColors.primary50
                      : DictionaryColors.primary400,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          errorText: errorText,
        ),
      ),
    );
  }
}
