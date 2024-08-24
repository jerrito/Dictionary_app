import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key, required this.word});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
  final String word;
}

class _ResultsPageState extends State<ResultsPage> {
  final dictionaryBloc = sl<DictionaryBloc>();
  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> params = {
      "text": widget.word,
    };
    dictionaryBloc.add(SearchDictionaryEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context, 0.04)),
          child: BlocConsumer(
              bloc: dictionaryBloc,
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
                  print(itemCount);
                  return CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList.builder(
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            final data = state.dictionaryInfo[index];
                            // final meaningsLength = data.meanings?.length;
                            final meanings = data.meanings?[index];
                            //print(meaningsLength);
                            // final meanings = data.meanings?[index];
                            // final definitionsLength = data
                            //     .meanings?[meaningsLength ?? 0]
                            //     .definitions
                            //     ?.length;
                            // // print(definitionsLength);
                            final definition = meanings?.definitions?[index];
                            return Text(definition?.definition ?? "");
                          })
                    ],
                  );

                  // Expanded(
                  //   child: ListView.builder(
                  //       itemCount: itemCount,
                  //       itemBuilder: (context, index) {
                  //         final data = state.dictionaryInfo[index];
                  //         final meaningsLength = data.meanings?.length;
                  //         print(meaningsLength);
                  //         final meanings = data.meanings?[meaningsLength!];
                  //         final definitionsLength = data
                  //             .meanings?[meaningsLength!].definitions?.length;
                  //         print(definitionsLength);
                  //         final definition =
                  //             meanings?.definitions?[definitionsLength!];
                  //         return Text("");
                  //       }),
                  // );
                }
                return const SizedBox();
              },
              listener: (context, state) {})),
    ));
  }
}
