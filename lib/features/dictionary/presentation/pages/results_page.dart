import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final dictionaryBloc=sl<DictionaryBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:EdgeInsets.symmetric(
          horizontal:Sizes.width(context, 0.04)
        ),
        child:CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                      BlocConsumer(
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
                    final itemCount = state.dictionaryInfo[0].meanings?.length;
                    return CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverList.builder(
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              final meanings =
                                  state.dictionaryInfo[0].meanings?[0];
                              final meaningsLength =
                                  state.dictionaryInfo[0].meanings?.length;
                              print(meaningsLength);
                              // final meanings = data.meanings?[index];
                              // final definitionsLength =
                              //     data.meanings?[index].definitions![index];
                              // // print(definitionsLength);
                              // final definition = meanings?.definitions?[index];
                              return Text(
                                  meanings?.definitions?[index].definition ??
                                      "");
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
                listener: (context, state) {})
          
                      ],
                    )

      )
    );
  }
}