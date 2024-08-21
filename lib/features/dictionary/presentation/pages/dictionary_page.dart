import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/widgets/text_field.dart';
import 'package:riverpod_learn/core/widgets/text_form_field.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/providers/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width(
            context,
            0.04,
          ),
        ),
        child: Column(
          children: [
            DefaultTextFormField(
              focusNode: FocusNode(),
              hint: "Search any word",
              onChanged: (value) {},
              validator: (value) {
                return null;
              },
              controller: searchController,
            ),
            Space.height(context, 0.2),
            BlocConsumer(
                builder: (context, state) {
                  if (state is SearchDictionaryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchDictionaryError) {
                    return Text(state.errorMessage);
                  }
                  if (state is SearchDictionaryLoaded) {
                    final itemCount = state.dictionaryInfo.length;
                    return ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final data = state.dictionaryInfo[index];
                          final meanings =
                              data.meanings?[data.meanings!.length];
                          return Text(meanings?.partOfSpeech ?? "");
                        });
                  }
                  return const SizedBox();
                },
                listener: (context, state) {})
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, dynamic> params = {"text": "expect"};

          dictionaryProvider.call(params: params);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
