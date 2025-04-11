import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/bookmark/presentation/pages/bookmark.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/dictionary_page.dart';
import 'package:riverpod_learn/features/discover/presentation/pages/discover.dart';
import 'package:riverpod_learn/features/home/presentation/widgets/bottom_nav.dart';
import 'package:riverpod_learn/features/settings/presentation/settings.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/locator.dart';

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
  WordsProvider wordProvider = sl<WordsProvider>();

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
  void initState() {
    currentIndex = widget.currentIndex;
    // pages
    pages = [
      DictionaryPage(
        // key: scaffoldKey,
        controller: homeController,
      ),
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
      if (homeController.position.pixels < Sizes.height(context, 0.14)) {
        if (wordProvider.hasWords != false) {
          wordProvider.hasWords = false;
        }
      }
      if (homeController.position.pixels > Sizes.height(context, 0.27)) {
        if (wordProvider.hasWords != true) {
          wordProvider.hasWords = true;
        }
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

  @override
  Widget build(BuildContext context) {
    wordProvider = context.read<WordsProvider>();
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
                  // print(currentIndex);

                  setState(() {});
                },
                items: NavItems.values
                    .map(
                      (e) => barItem(
                        e.indexGet == currentIndex ? e.selectedImage : e.image,
                        e.label,
                        e.indexGet == currentIndex,
                      ),
                    )
                    .toList(),
                currentIndex: currentIndex,
              ),
      ),
    );
  }

  // navigateToSearchJobs() {
  //   // print("object");
  //   setState(() {
  //     currentIndex = 1;
  //   });
  // }

// nav bar item
  BottomNavigationBarItem barItem(String icon, String label, bool isSelected) =>
      BottomNavigationBarItem(
          icon: MediaQuery.of(context).orientation == Orientation.portrait
              ? isSelected && Theme.of(context).brightness != Brightness.dark
                  ? _NavBarImage(icon, isSelected)
                  : _NavBarSvg(icon, isSelected)
              : SvgPicture.asset(
                  icon,
                  width: Sizes.height(context, 0.068),
                  height: Sizes.height(context, 0.068),
                ),
          label: label);
}

// String navBar(String name) {
//   List<String> names = [
//     "Search",
//     "Bookmark",
//     "Discover",
//     "Settings",
//   ];

//   return names[0];
// }

enum NavItems {
  search(
    image: DictionarySvgs.searchSVG,
    label: "Search",
    indexGet: 0,
    selectedImage: DictionaryImages.searchImage,
  ),
  dashboard(
    image: DictionarySvgs.allBookmarkSVG,
    label: "Bookmark",
    indexGet: 1,
    selectedImage: DictionaryImages.bookmarkImage,
  ),
  saved(
    image: DictionarySvgs.discoverSVG,
    label: "Discover",
    indexGet: 2,
    selectedImage: DictionaryImages.discoverImage,
  ),
  profile(
    image: DictionarySvgs.settingsSVG,
    label: "Settings",
    indexGet: 3,
    selectedImage: DictionaryImages.settingsImage,
  );

  final String image, label, selectedImage;
  final int indexGet;

  const NavItems({
    required this.selectedImage,
    required this.image,
    required this.label,
    required this.indexGet,
  });
}

class _NavBarSvg extends StatelessWidget {
  const _NavBarSvg(this.icon, this.isSelected);
  final String icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: Sizes.height(context, 0.028),
      height: Sizes.height(context, 0.028),
      colorFilter: ColorFilter.mode(
        isSelected && Theme.of(context).brightness != Brightness.dark
            ? DictionaryColors.whiteBackground
            : isSelected && Theme.of(context).brightness == Brightness.dark
                ? DictionaryColors.white
                : Theme.of(context).brightness == Brightness.dark
                    ? DictionaryColors.whiteBackground.withValues(alpha: 0.5)
                    : DictionaryColors.blackBackground,
        BlendMode.srcIn,
      ),
    );
  }
}

class _NavBarImage extends StatelessWidget {
  const _NavBarImage(this.icon, this.isSelected);
  final String icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: Sizes.height(context, 0.028),
      height: Sizes.height(context, 0.028),
      // color: isSelected && Theme.of(context).brightness != Brightness.dark
      //     ? DictionaryColors.whiteBackground
      //     : isSelected && Theme.of(context).brightness == Brightness.dark
      //         ? DictionaryColors.blackBackground
      //         : Theme.of(context).brightness == Brightness.dark
      //             ? DictionaryColors.whiteBackground
      //             : DictionaryColors.blackBackground,
    );
  }
}
