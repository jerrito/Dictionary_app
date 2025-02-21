import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final List<Widget> pages;
  final int currentIndex;
  final Color? backgroundColor;
  final TextStyle? selectedLabelStyle,unselectedLabelStyle;
  final void Function(int? currentIndex)? onTap;
  final List<BottomNavigationBarItem> items;
  const BottomNav(
      {super.key,
      required this.pages,
      required this.currentIndex,
      required this.items,
      this.onTap, this.backgroundColor,
      this.selectedLabelStyle,
      this.unselectedLabelStyle,
      });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle:selectedLabelStyle ,
      unselectedLabelStyle: unselectedLabelStyle,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        onTap: onTap,
        items: items);
  }
}
