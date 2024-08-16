import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/movies/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/movies/domain/entities/dictionary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/features/movies/presentation/providers/provider.dart';



void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer(builder: (context, ref, child) {
        final AsyncValue<List<Dictionary>> dictValues = ref.watch(dictionaryProvider);
        return switch (dictValues) {
          AsyncData(:final value) => value[0],
          AsyncError()=>const Text("data"),
        };
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await get();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
