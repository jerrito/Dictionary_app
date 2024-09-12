import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';

class PhoneticModal extends StatelessWidget {
  final String? phonetic;
  final VoidCallback onTap;
  final int index;
  final bool hasAudio;
  const PhoneticModal({
    super.key,
    required this.phonetic,
    required this.onTap,
    required this.hasAudio,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.height(
          context,
          0.01,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
                text: "$index. ",
                style: TextStyle(
                  fontSize: 22,
                  color: context.themeData.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                children: [
                  TextSpan(
                      text: phonetic ?? "",
                      style: TextStyle(
                          color:
                              context.themeData.brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white)),
                  // GestureDetector(
                  //   child:Icon(Icons.add)
                  // )
                ]),
          ),
          Space.width(context, 0.05),
          Offstage(
            offstage: !hasAudio,
            child: GestureDetector(
              onTap: hasAudio ? onTap : null,
              child: Icon(
                Icons.audiotrack_outlined,
                color: context.themeData.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
