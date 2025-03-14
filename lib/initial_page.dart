import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/home/presentation/bloc/home_bloc.dart';
import 'package:riverpod_learn/features/home/presentation/pages/home_base.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/provider/words.dart';
import 'package:riverpod_learn/locator.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({
    super.key,
    this.userExist,
  });
  final bool? userExist;

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final wordBloc = sl<WordBloc>();
  final homeBloc = sl<HomeBloc>();
  WordsProvider? wordsProvider;
  @override
  void initState() {
    super.initState();
    wordBloc.add(InitAppEvent());
    checkUserExist();
  }

  checkUserExist() {
    widget.userExist ?? false ? null : homeBloc.setUser("userValue");
  }

  @override
  Widget build(context) {
    wordsProvider = context.read<WordsProvider>();
    return Scaffold(
      body: BlocConsumer(
        bloc: wordBloc,
        listener: (context, state) {
          if (state is DecodedWordsLoaded) {
            final words = state.data;
            wordsProvider?.words = words;
            // wordsProvider?.words?.keys.elementAt(index);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeBase(
                      currentIndex: 0,
                    )));
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
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 8,
              color: DictionaryColors.success300,
            ),
          );
        },
      ),
    );
  }
}
