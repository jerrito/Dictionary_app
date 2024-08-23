import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/dictionary_page.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/locator.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final wordBloc = sl<WordBloc>();
  WordsProvider? wordsProvider;
  @override
  void initState() {
    super.initState();
    wordBloc.add(InitAppEvent());
  }

  @override
  Widget build(context) {
    wordsProvider=context.read<WordsProvider>();
    return Scaffold(
      body: BlocConsumer(
        bloc: wordBloc,
        listener: (context, state) {
          if (state is DecodedWordsLoaded) {
            final words=state.data;
            wordsProvider?.words=words;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=>
            const  DictionaryPage())
            );

          }
          if (state is InitApppLoaded) {
            final Map<String, dynamic> params = {"context": context};
            wordBloc.add(
              DecodeWordsEvent(
                params: params,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
