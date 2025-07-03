import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_learn/core/onboarding/page_view.dart';
import 'package:riverpod_learn/core/themes/theme.dart';
import 'package:riverpod_learn/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:riverpod_learn/features/database/database.dart';
import 'package:riverpod_learn/features/dictionary/presentation/provider/dictionary_provider.dart';
import 'package:riverpod_learn/features/home/presentation/bloc/home_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/initial_page.dart';
import 'package:riverpod_learn/locator.dart';

AppDatabase? database;
// final GetIt.in sl;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  initDependencies();
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final homeBloc = sl<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WordsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DictionaryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:
            DefaultThemeData(context: context).defaultTheme(Brightness.light),
        darkTheme:
            DefaultThemeData(context: context).defaultTheme(Brightness.dark),
        home: homeBloc.checkIfUserExist()
            ? const InitialPage(
                userExist: true,
              )
            : const OnboardingPageViews(),
      ),
    );
  }
}
