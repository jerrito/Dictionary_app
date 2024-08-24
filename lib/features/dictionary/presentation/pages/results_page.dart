import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_widget.dart';
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
      body: CustomScrollView(
        // shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(188, 36, 36, 179),
            pinned: true,
            expandedHeight: Sizes.height(context, 0.3),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.word,
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width(
                context,
                0.04,
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                  Sizes.height(
                    context,
                    0.1,
                  ),
                )),
                child: BlocConsumer(
                    bloc: dictionaryBloc,
                    builder: (context, state) {
                      if (state is SearchDictionaryLoading) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                      if (state is SearchDictionaryError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.errorMessage),
                          ],
                        );
                      }
                      if (state is SearchDictionaryLoaded) {
                        final itemCount =
                            state.dictionaryInfo[0].meanings?.length;
                        print(itemCount);
                        return ListView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              final data = state.dictionaryInfo[0];
                              // final meaningsLength = data.meanings?.length;
                              final meanings = data.meanings?[index];
                              //print(meaningsLength);
                              // final meanings = data.meanings?[index];
                              // final definitionsLength = data
                              //     .meanings?[meaningsLength ?? 0]
                              //     .definitions
                              //     ?.length;
                              // // print(definitionsLength);
                              //final definition = meanings?.definitions?[index];
                              return DefinitionWidget(
                                index: "${index + 1}",
                                partOfSpeech: meanings?.partOfSpeech ?? "",
                                definition: List.generate(
                                    meanings!.definitions!.length,
                                    (int index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  Sizes.height(context, 0.005)),
                                          child: Text(
                                            meanings.definitions?[index]
                                                    .definition ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        )),
                              );
                            });
                      }
                      return const SizedBox();
                    },
                    listener: (context, state) {}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
