import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/widgets/text_form_field.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/results_page.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/suggested_word.dart';
import 'package:riverpod_learn/features/word/data/datasources/local_ds.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/locator.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({
    super.key,
  });

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  void initState() {
    super.initState();
  }

  final dictionaryBloc = sl<DictionaryBloc>();
  final wordSuggestBloc = sl<WordBloc>();
  final searchController = TextEditingController();
  WordsProvider? wordsProvider;
  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    final words = context.read<WordsProvider>().words;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: DefaultTextFormField(
          onSubmitted: (p0) {
            print(p0);
            final Map<String, dynamic> params = {
              "text": searchController.text,
            };
            dictionaryBloc.add(SearchDictionaryEvent(params: params));
          },
          focusNode: FocusNode(),
          hint: "Search any word",
          onChanged: (value) {
            print(words);
            final Map<String, dynamic> params = {
              "text": value,
              "decodedWords": words
            };
            wordSuggestBloc.add(
              WordSuggestEvent(
                params: params,
              ),
            );
          },
          validator: (value) {
            return null;
          },
          controller: searchController,
        ),
        leading: IconButton(
            onPressed: () async {
              final list = await WordLocalDatasourceImpl().suggestWords(
                params: {"text": "fak", "context": context},
              );
              print(list);
            },
            icon: const Icon(Icons.add)),
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
            BlocConsumer(
                bloc: wordSuggestBloc,
                listener: (context, state) {
                  if (state is WordSuggestError) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is WordSuggestLoaded) {
                    final items = state.words.length;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: items,
                          itemBuilder: (context, index) {
                            final data = state.words[index];
                            return SuggestedWord(
                                word: data,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultsPage(
                                        word: data,
                                      ),
                                    ),
                                  );
                                });
                          }),
                    );
                  }

                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
