import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/bookmark/presentation/pages/bookmark.dart';
import 'package:riverpod_learn/features/discover/presentation/pages/discover.dart';
import 'package:riverpod_learn/features/home/presentation/pages/home.dart';
import 'package:riverpod_learn/features/home/presentation/widgets/bottom_nav.dart';
import 'package:riverpod_learn/features/settings/presentation/settings.dart';

class HomeBase extends StatefulWidget {
  final int currentIndex;
  const HomeBase({
    super.key,
    required this.currentIndex,
  });

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  ScrollController homeController = ScrollController();
  ScrollController dashboardController = ScrollController();
  ScrollController savedController = ScrollController();
  ScrollController profileController = ScrollController();
  ScrollController controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Scr
  int currentIndex = 0;
  bool isScrolling = false, isDone = false;
  bool? hasPadding = false;
  List<Widget> pages = [];

  @override
  void dispose() {
    // controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      key: scaffoldKey,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 2) {
            scaffoldKey.currentState?.openDrawer();
          }
        },
        // onHorizontalDragStart: (details) =>
        //     scaffoldKey.currentState?.openDrawer(),
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: AnimatedOpacity(
        onEnd: () => setState(() {
          isDone = !isDone;
          if ((isScrolling == false) && (isDone == true)) {
            isDone = false;
          }
        }),
        curve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        opacity: isScrolling ? 0 : 1,
        child: isDone
            ? const SizedBox.shrink()
            : BottomNav(
                //backgroundColor: isScrolling? Colors.transparent : VacanciesColors.baseWhite,
                pages: pages,
                onTap: (index) {
                  currentIndex = index!;

                  setState(() {});
                },
                items: NavItems.values
                    .map(
                      (e) => barItem(
                        (e.selectedImage != null && e.indexGet == currentIndex)
                            ? e.selectedImage!
                            : e.image,
                        navBar( e.label),
                        e.indexGet == currentIndex,
                      ),
                    )
                    .toList(),
                currentIndex: currentIndex,
              ),
      ),
    );
  }

  navigateToSearchJobs() {
    // print("object");
    setState(() {
      currentIndex = 1;
    });
  }

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    // pages
    pages = [
      const Home(),
      const Bookmark(),
      const Discover(),
      const Settings(),
    ];

    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        isScrolling = true;
        setState(() {});
      }
      if ((controller.position.userScrollDirection ==
              ScrollDirection.forward) ||
          (controller.position.userScrollDirection == ScrollDirection.idle)) {
        isScrolling = false;
        setState(() {});
      }
    });

    savedController.addListener(() {
      if (savedController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isScrolling = true;
        setState(() {});
      }
      if ((savedController.position.userScrollDirection ==
              ScrollDirection.forward) ||
          (savedController.position.userScrollDirection ==
              ScrollDirection.idle)) {
        isScrolling = false;
        setState(() {});
      }
    });

    homeController.addListener(() {
      if (homeController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isScrolling = true;
        setState(() {});
      }
      if ((homeController.position.userScrollDirection ==
              ScrollDirection.forward) ||
          (homeController.position.userScrollDirection ==
              ScrollDirection.idle)) {
        isScrolling = false;
        setState(() {});
      }
    });
    dashboardController.addListener(() {
      if (dashboardController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isScrolling = true;
        setState(() {});
      }
      if ((dashboardController.position.userScrollDirection ==
              ScrollDirection.forward) ||
          (dashboardController.position.userScrollDirection ==
              ScrollDirection.idle)) {
        isScrolling = false;
        setState(() {});
      }
    });

    profileController.addListener(() {
      if (profileController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isScrolling = true;
        setState(() {});
      }
      if ((profileController.position.userScrollDirection ==
              ScrollDirection.forward) ||
          (profileController.position.userScrollDirection ==
              ScrollDirection.idle)) {
        isScrolling = false;
        setState(() {});
      }
    });

    super.initState();
  }

// nav bar item
  BottomNavigationBarItem barItem(String icon, String label, bool isSelected) =>
      BottomNavigationBarItem(
          icon: MediaQuery.of(context).orientation == Orientation.portrait
              ? SvgPicture.asset(
                  icon,
                  width: Sizes.height(context, 0.028),
                  height: Sizes.height(context, 0.028),
                )
              : SvgPicture.asset(
                  icon,
                  width: Sizes.height(context, 0.068),
                  height: Sizes.height(context, 0.068),
                  colorFilter: ColorFilter.mode(isSelected && Theme.of(context).brightness==Brightness.dark? DictionaryColors.whiteBackground: DictionaryColors.blackBackground, BlendMode.srcIn,),
                ),
          label: label);
}

String navBar(String name) {
 List<String> names = [
    "Search",
    "Dashboard",
    "Learn"
    "Services" ,
  ];

  return names[0];
}

enum NavItems {
  
  search(
      image: DictionarySvgs.searchSVG,
      label: "Search",
      indexGet: 1,
    ),
  dashboard(
      image: DictionarySvgs.bookmarkSVG,
      label: "Bookmark",
      indexGet: 2,
     ),
  saved(
      image: DictionarySvgs.discoverSVG,
      label: "Discover",
      indexGet: 3,
   ),
  profile(
      image: DictionarySvgs.settingsSVG,
      label: "Settings",
      indexGet: 4,
   );

  final String image, label;
  final int indexGet;
  final String? selectedImage;

  const NavItems(
      {required this.image,
      required this.label,
      required this.indexGet,
      this.selectedImage});
}
