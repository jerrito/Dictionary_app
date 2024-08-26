import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_learn/features/database/database.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/dictionary_page.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/initial_page.dart';
import 'package:riverpod_learn/locator.dart';

AppDatabase? database;
void main() async {
  // await dotenv.load(fileName: ".env");
  await initDependencies();
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
        darkTheme: ThemeData(
          fontFamily: "BarlowCondensed",
          primaryColor: Colors.white,
          brightness: Brightness.dark,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        theme: ThemeData(
          fontFamily: "BarlowCondensed",
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const InitialPage(),
      ),
    );
  }
}
