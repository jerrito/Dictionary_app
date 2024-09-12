import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DictionaryResponse> response = [];
  @override
  void initState() {
    super.initState();
    wordBloc.add(
      const RetrieveWordEvent(),
    );
  }

  final dictionaryBloc = sl<DictionaryBloc>();
  final wordBloc = sl<WordBloc>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              GestureDetector(
                  onTap: () async {
                    await dictionaryResponse();
                  },
                  child: const Icon(Icons.chevron_left_outlined)),
            ],
          )),
          BlocBuilder(
              bloc: wordBloc,
              builder: (context, state) {
                if (state is RetrieveWordError) {
                  return Text(state.message);
                }
                if (state is RetrieveWordLoaded) {
                  return Column(
                    children: List.generate(state.words?.length ?? 0, (index) {
                      return Text(
                        state.words?[index] ?? "",
                      );
                    }),
                  );
                }
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }

  Future<List<DictionaryResponse>> dictionaryResponse() async {
    response = await dictionaryBloc.readAllDictionary();
    setState(() {});
    return response;
  }
}
