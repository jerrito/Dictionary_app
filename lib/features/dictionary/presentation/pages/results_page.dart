import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_widget.dart';
import 'package:riverpod_learn/locator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_learn/main.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key, required this.word});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
  final String word;
}

class _ResultsPageState extends State<ResultsPage> {
  final dictionaryBloc = sl<DictionaryBloc>();
  final player = AudioPlayer();
  bool isLoaded = false, hasAudio = false;
  String? phonetic, audioUrl;

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
      backgroundColor: const Color.fromARGB(185, 56, 56, 117),
      body: CustomScrollView(
        // shrinkWrap: true,
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
            iconTheme: const IconThemeData(color: Colors.white),
            pinned: true,
            backgroundColor: const Color.fromARGB(185, 56, 56, 117),
            expandedHeight: Sizes.height(context, 0.3),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "${widget.word}\n",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(text: phonetic ?? ""),
                          // GestureDetector(
                          //   child:Icon(Icons.add)
                          // )
                        ]),
                  ),
                  Offstage(
                    offstage: !isLoaded,
                    child: GestureDetector(
                      onTap: (audioUrl != null)
                          ? () async {
                              await player.play(
                                UrlSource(
                                  audioUrl ?? "",
                                ),
                              );
                            }
                          : null,
                      child: const Icon(
                        Icons.audiotrack_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.width(context, 0.04)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Sizes.height(
                    context,
                    0.05,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  BlocConsumer(
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
                              Center(
                                  child: Text(
                                state.errorMessage,
                              )),
                              Space.height(context, 0.02),
                              GestureDetector(
                                  onTap: () {
                                    final Map<String, dynamic> params = {
                                      "text": widget.word
                                    };
                                    dictionaryBloc.add(
                                      SearchDictionaryEvent(
                                        params: params,
                                      ),
                                    );
                                  },
                                  child: const Text("Retry"))
                            ],
                          );
                        }
                        if (state is SearchDictionaryLoaded) {
                          final itemCount =
                              state.dictionaryInfo[0].meanings?.length;
                          print(itemCount);
                          return Column(
                            children: List.generate(itemCount ?? 0, (index) {
                              final data = state.dictionaryInfo[0];
                              // final meaningsLength = data.meanings?.length;
                              final meanings = data.meanings?[index];
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
                            }),
                          );
                        }

                        return const SizedBox();
                      },
                      listener: (context, state) async {
                        if (state is SearchDictionaryLoaded) {
                          final data = state.dictionaryInfo[0];
                          isLoaded = true;
                          phonetic = data.phonetic;
                          if (data.phonetics?.isNotEmpty ?? false) {
                            audioUrl = data.phonetics?[0].audio;
                            setState(() {});
                          }
                          await database?.wordDao.insertData(
                            DictionaryResponse(
                              dictionary: DictionaryModel.fromJson(data.toMap()) ,
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
