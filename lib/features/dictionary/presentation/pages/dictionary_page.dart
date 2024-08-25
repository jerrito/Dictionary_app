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
  bool isSearchEmpty = false;
  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    final words = context.read<WordsProvider>().words;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(184, 30, 30, 128),
        title: DefaultTextFormField(
          onSubmitted: (p0) {
            if (p0?.isNotEmpty ?? false) {
              final Map<String, dynamic> params = {
                "text": searchController.text,
              };
              dictionaryBloc.add(SearchDictionaryEvent(params: params));
            }
          },
          focusNode: FocusNode(),
          hint: "Search any word",
          onChanged: (value) {
            // print(value.);
            final Map<String, dynamic> params = {
              "text": value,
              "decodedWords": words
            };
            wordSuggestBloc.add(
              WordSuggestEvent(
                params: params,
              ),
            );
             if (value?.isNotEmpty ?? false) {
              isSearchEmpty = true;
              setState(() {});
            } else {
              isSearchEmpty = false;
              setState(() {});
            }
          },
          validator: (value) {
            if (value?.isNotEmpty ?? false) {
              isSearchEmpty = true;
              print("dd");
              setState(() {});
            } else {
              isSearchEmpty = false;
              setState(() {});
            }
            return null;
          },
          showSuffixIcon: isSearchEmpty,
          controller: searchController,
          suffixOnTap: () {
            searchController.clear();
          },
        ),
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
