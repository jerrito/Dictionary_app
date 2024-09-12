import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/phonetics.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_row.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_widget.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/drawer.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/phonetic_modal.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/phonetic_modal.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/phonetic_modal.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/locator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key, required this.word});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
  final String word;
}

class _ResultsPageState extends State<ResultsPage>
    with TickerProviderStateMixin {
  final dictionaryBloc = sl<DictionaryBloc>();
  late AnimationController animationController;
  final wordBloc = sl<WordBloc>();
  final player = AudioPlayer();
  final scaffold = GlobalKey<ScaffoldState>();
  bool isLoaded = false, hasAudio = false, hasPhonetics = false;
  String? phonetic, audioUrl;
  List<Phonetics> phonetics = [];
  double maxSlide = 225.0;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> params = {
      "text": widget.word,
    };
    dictionaryBloc.add(SearchDictionaryEvent(params: params));
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    // animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: const Color.fromARGB(185, 56, 56, 117),
      body: GestureDetector(
        onHorizontalDragStart: (details) {
          animationController.isDismissed
              ? animationController.forward()
              : animationController.reverse();
        },
        onHorizontalDragEnd: (details) {
          animationController.isDismissed
              ? animationController.forward()
              : animationController.reverse();
        },
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final slide = animationController.value * maxSlide;
              final scale = 1 - (animationController.value * 0.1);
              return Stack(
                // alignment: Alignment.centerRight,
                children: [
                  const MyDrawer(),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerRight,
                    child: CustomScrollView(
                      // shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.chevron_left_outlined,
                            ),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () async {
                                animationController.isDismissed
                                    ? animationController.forward()
                                    : animationController.reverse();
                                // scaffold.currentState?.openDrawer();
                              },
                              icon: const Icon(
                                Icons.more_vert,
                              ),
                            ),
                          ],
                          iconTheme: const IconThemeData(color: Colors.white),
                          pinned: true,
                          backgroundColor:
                              const Color.fromARGB(185, 56, 56, 117),
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
                                              volume: 1.0,
                                            );
                                          }
                                        : null,
                                    child: const Icon(
                                      Icons.audiotrack_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Offstage(
                                    offstage: !phonetics.isNotEmpty,
                                    child: GestureDetector(
                                      onTap: phonetics.isNotEmpty
                                          ? () async {
                                              await showModalBottomSheet(
                                                  context: context,
                                                  builder: (
                                                    context,
                                                  ) {
                                                    // phonetics[0].
                                                    return SizedBox(
                                                      height: Sizes.height(
                                                          context,
                                                          (phonetics.length
                                                                      .toDouble() *
                                                                  0.6) *
                                                              0.1),
                                                      child: ListView.builder(
                                                          itemCount:
                                                              phonetics.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final data =
                                                                phonetics[
                                                                    index];
                                                            print(data.audio);
                                                            return PhoneticModal(
                                                                index:
                                                                    index + 1,
                                                                phonetic:
                                                                    data.text ??
                                                                        "",
                                                                onTap:
                                                                    () async {
                                                                  await player
                                                                      .play(
                                                                    UrlSource(
                                                                      data.audio ??
                                                                          "",
                                                                    ),
                                                                  );
                                                                },
                                                                hasAudio:
                                                                    data.audio!.isNotEmpty
                                                                        );
                                                          }),
                                                    );
                                                  });
                                            }
                                          : null,
                                      child: const Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes.width(context, 0.04)),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness !=
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  Sizes.height(
                                    context,
                                    0.05,
                                  ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ],
                                        );
                                      }
                                      if (state is SearchDictionaryError) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(
                                              state.errorMessage,
                                            )),
                                            Space.height(context, 0.02),
                                            GestureDetector(
                                                onTap: () {
                                                  final Map<String, dynamic>
                                                      params = {
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
                                        final itemCount = state
                                            .dictionaryInfo[0].meanings?.length;
                                        return Column(
                                          children: List.generate(
                                              itemCount ?? 0, (index) {
                                            final data =
                                                state.dictionaryInfo[0];
                                            // final meaningsLength = data.meanings?.length;
                                            final meanings =
                                                data.meanings?[index];
                                            return DefinitionWidget(
                                              index: "${index + 1}",
                                              partOfSpeech:
                                                  meanings?.partOfSpeech ?? "",
                                              definition: List.generate(
                                                  meanings!.definitions!.length,
                                                  (int index) => Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: Sizes
                                                                    .height(
                                                                        context,
                                                                        0.01)),
                                                        child: Column(
                                                          children: [
                                                            DefinitionRow(
                                                              index: index,
                                                              definition: meanings
                                                                  .definitions?[
                                                                      index]
                                                                  .definition,
                                                            ),
                                                            ExampleRow(
                                                              isExample: meanings
                                                                      .definitions?[
                                                                          index]
                                                                      .example !=
                                                                  null,
                                                              example: meanings
                                                                  .definitions?[
                                                                      index]
                                                                  .example,
                                                            )
                                                          ],
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
                                        phonetic = data.phonetic ??
                                            data.phonetics?[1].text;
                                        if (data.phonetics?.isNotEmpty ??
                                            false) {
                                          hasPhonetics = true;
                                          audioUrl = data.phonetics?[0].audio;
                                          if (data.phonetics!.length > 1) {
                                            phonetics = data.phonetics!;
                                          }
                                          setState(() {});
                                        }
                                        final Map<String, dynamic> params = {
                                          "word": data.word ?? widget.word
                                        };
                                        wordBloc.add(
                                          SaveWordEvent(
                                            params: params,
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
                  ),
                ],
              );
            }),
      ),
    );
  }
}
