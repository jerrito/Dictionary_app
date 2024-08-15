import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/movies/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/movies/domain/entities/dictionary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  int _counter = 0;

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Builder(builder: (context) {
        return FutureBuilder(
            future: get(),
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await get();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Dictionary>> get() async {
    final response = await http.get(
      const URL().getUri(
        endpoint: "good",
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      return List<DictionaryModel>.from(
          decodedResponse.map((e) => DictionaryModel.fromJson(e)));
    } else {
      throw Exception("Error getting data");
    }
  }
}
