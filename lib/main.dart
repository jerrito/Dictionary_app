import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_learn/core/onboarding/first_page.dart';
import 'package:riverpod_learn/core/onboarding/page_view.dart';
import 'package:riverpod_learn/core/themes/theme.dart';
import 'package:riverpod_learn/features/database/database.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WordsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: DefaultThemeData.lightTheme,
        darkTheme: DefaultThemeData.darkTheme,
        home: const OnboardingPageViews(),
      ),
    );
  }
}
