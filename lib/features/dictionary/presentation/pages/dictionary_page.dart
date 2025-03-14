import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/core/widgets/text_form_field.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/results_page.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/default_page.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/suggested_word.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/locator.dart';

class DictionaryPage extends StatefulWidget {
  final ScrollController controller;
  const DictionaryPage({
    super.key,
    required this.controller,
  });

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  void initState() {
    super.initState();
    wordSuggestBloc.add(const RetrieveWordEvent());
  }

  final dictionaryBloc = sl<DictionaryBloc>();
  final wordSuggestBloc = sl<WordBloc>();
  final searchController = TextEditingController();
  WordsProvider? wordsProvider;
  bool isSearchEmpty = false;
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    final words = context.read<WordsProvider>().words;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: const Color.fromARGB(184, 30, 30, 128),
          title: Text(
            "Search",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          )),
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
              onSubmitted: (p0) async {
                print(p0);
                if (p0?.isNotEmpty ?? false) {
                  await SystemChannels.textInput.invokeMethod("TextInput.hide");
                  if (!context.mounted) return;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        word: p0!.toLowerCase(),
                      ),
                    ),
                  );
                }
              },
              focusNode: focusNode,
              hint: "Search any word",
              onChanged: (value) {
                final Map<String, dynamic> params = {
                  "text": value?.toLowerCase(),
                  "decodedWords": words
                };
                print(params);
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
              showSuffixIcon: isSearchEmpty,
              controller: searchController,
              suffixOnTap: () {
                searchController.clear();
                wordSuggestBloc.add(const RetrieveWordEvent());
                focusNode.unfocus();
                isSearchEmpty = false;
                setState(() {});
              },
            ),
            Space.height(context, 0.032),
            // Text("Result"),
            BlocConsumer(
                bloc: wordSuggestBloc,
                listener: (context, state) {
                  if (state is WordSuggestError) {}
                },
                builder: (context, state) {
                  print(state);
                  if (state is WordSuggestLoaded) {
                    final items = state.words.length;
                    return Expanded(
                      child: ListView.builder(
                          controller: widget.controller,
                          itemCount: items,
                          itemBuilder: (context, index) {
                            final data = state.words[index];
                            return SuggestedWord(
                                word: data,
                                onTap: () async {
                                  await SystemChannels.textInput
                                      .invokeMethod("TextInput.hide");
                                  if (!context.mounted) return;
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
                  if (state is RetrieveWordError) {
                    return Text(state.message);
                  }

                  if (state is RetrieveWordLoaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        controller: widget.controller,
                        child: DefaultSearchPage(
                          dictionaryOnTap: () {
                            focusNode.requestFocus();
                            final Map<String, dynamic> params = {
                              "text": "a",
                              "decodedWords": words
                            };
                            wordSuggestBloc.add(
                              WordSuggestEvent(
                                params: params,
                              ),
                            );
                          },
                          // controller: widget.controller,
                          dictionaryBloc: dictionaryBloc,
                          words: state.words ?? [],
                        ),
                      ),
                    );
                  }

                  return DefaultSearchPage(
                    dictionaryOnTap: () {
                      focusNode.requestFocus();
                      final Map<String, dynamic> params = {
                        "text": "a",
                        "decodedWords": words
                      };
                      wordSuggestBloc.add(
                        WordSuggestEvent(
                          params: params,
                        ),
                      );
                    },
                    // controller: widget.controller,
                    dictionaryBloc: dictionaryBloc,
                    words: const [],
                  );
                })
          ],
        ),
      ),
    );
  }
}
