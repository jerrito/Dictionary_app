import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/phonetics.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/pages/test.dart';
import 'package:riverpod_learn/features/dictionary/presentation/provider/dictionary_provider.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_row.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_widget.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/new_result_app_bar.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/word_phonetic.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class NewResultPage extends StatefulWidget {
  const NewResultPage({super.key, required this.word});

  @override
  State<NewResultPage> createState() => _NewResultPageState();
  final String word;
}

class _NewResultPageState extends State<NewResultPage>
    with SingleTickerProviderStateMixin {
  final dictionaryBloc = sl<DictionaryBloc>();
  final dictionaryBloc2 = sl<DictionaryBloc>();
  final wordBloc = sl<WordBloc>();
  final bookmarkBloc = sl<BookmarkBloc>();
  final player = AudioPlayer();
  TabController? controller;
  final scrollController = ScrollController();
  List<Phonetics> phonetics = [];
  late DictionaryProvider dictionaryProvider;

  List<String?> values = [];
  String? selectedValue, audioUrl;
  final Map<String, GlobalKey> partOfSpeechKeys = {};

  void scrollToPartOfSpeech(String partOfSpeech) {
    final key = partOfSpeechKeys[partOfSpeech];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Map<dynamic, dynamic>? response;

  @override
  initState() {
    final Map<String, dynamic> params = {"text": widget.word};

    dictionaryBloc.add(SearchDictionaryEvent(params: params));

    super.initState();
  }

  String? origin;
  List<dynamic> similarWords = [];

  @override
  Widget build(BuildContext context) {
    dictionaryProvider = context.read<DictionaryProvider>();
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: bookmarkBloc,
          listener: (context, state) {},
        ),
        BlocListener(
          bloc: dictionaryBloc2,
          listener: (context, state) {
            if (state is SimilarWordsLoaded) {
              RegExp curlyBraceRegex = RegExp(r'\{[^}]*\}');

              Iterable<Match> matches =
                  curlyBraceRegex.allMatches(state.dictionaryInfo.text ?? "");
              for (Match match in matches) {
                String jsonString = match.group(
                    0)!; // ! operator is used because allMatches will only return a match when it exists.
                try {
                  // Attempt to parse the extracted string as JSON.
                  Map<String, dynamic> jsonData = jsonDecode(jsonString);
                  print('Parsed JSON: $jsonData');
                  origin = jsonData["origin"];
                  similarWords = jsonData["synonyms"] ?? [];
                  setState(() {});
                } catch (e) {
                  print('Invalid JSON: $jsonString. Error: $e');
                }
              }
              // String jsonString = matches.map(toElement).group(0)!;
              // print(state.dictionaryInfo.text);
              // print(curlyBraceRegex.stringMatch());
            }
            if (state is SimilarWordsError) {
              print(state.errorMessage);
            }
          },
        ),
        BlocListener(
            bloc: wordBloc,
            listener: (context, state) async {
              if (state is SaveWordLoaded) {
                await dictionaryBloc.insertData(response!, widget.word);
                dictionaryProvider.getAllData =
                    await dictionaryBloc.readAllDictionary();
              }
            })
      ],
      child: BlocConsumer(
          bloc: dictionaryBloc,
          listener: (context, state) {
            if (state is SearchDictionaryLoaded) {
              controller = TabController(
                length: state.dictionaryInfo[0].meanings!.length,
                vsync: this,
              );
              values = state.dictionaryInfo[0].meanings!
                  .map((e) => e.partOfSpeech)
                  .toList();
              selectedValue = values[0];
              print(state.dictionaryInfo[0].phonetics);
              audioUrl = state.dictionaryInfo[0].phonetics != null &&
                      state.dictionaryInfo[0].phonetics!.isNotEmpty
                  ? (state.dictionaryInfo[0].phonetics?[0].audio)
                  : null;
              final data = state.dictionaryInfo[0];
              phonetics = data.phonetics!;
              response = data.toMap();

              setState(() {});
              final Map<String, dynamic> params = {
                "word": data.word ?? widget.word
              };
              dictionaryBloc2.add(
                SimilarWordsEvent(
                  params: params,
                ),
              );
              wordBloc.add(
                SaveWordEvent(
                  params: params,
                ),
              );
            }
            // v
          },
          builder: (context, state) {
            if (state is SearchDictionaryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SearchDictionaryLoaded) {
              final data = state.dictionaryInfo[0].meanings;
              // final meanings = state.dictionaryInfo[0].meanings;

              return DefaultTabController(
                  length: data!.length,
                  child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: NewResultAppBar(
                          onBookmarkTap: onBookmarkTap,
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size(double.infinity, 140),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes.width(
                                context,
                                0.04,
                              ),
                            ),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: context.themeData.brightness != Brightness.dark
                            //         ? DictionaryColors.blackBackground
                            //         : DictionaryColors.darkShadow,
                            //   ),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child:
                                // TabBar(
                                //   controller: controller,
                                //   isScrollable: true,
                                //   tabs: [
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WordPhonetic(
                                  onSoundTap: (audioUrl != null &&
                                          (audioUrl?.isNotEmpty ?? false))
                                      ? () async {
                                          try {
                                            await player.play(
                                              UrlSource(
                                                audioUrl ?? "",
                                              ),
                                              volume: 1.0,
                                            );
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        }
                                      : null,
                                  hasSound: audioUrl != null,
                                  phonetic: phonetics!.isNotEmpty
                                      ? (phonetics?[0].text)
                                      : null,
                                  word: widget.word,
                                ),
                                Space.height(context, 0.012),
                                // data.takeWhile((e)=> e.partOfSpeech)
                                data.length > 2
                                    ? TabsWidget(
                                        selected: {selectedValue},
                                        onSelectionChanged: (p0) {
                                          selectedValue = p0.first;
                                          if (p0.first != null) {
                                            scrollToPartOfSpeech(p0.first);
                                          }
                                          setState(() {});
                                        },
                                        buttonSegments: data
                                            .map((e) => ButtonSegment(
                                                  value: e.partOfSpeech,
                                                  label: Text(
                                                    e.partOfSpeech ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: e.partOfSpeech ==
                                                                  selectedValue &&
                                                              context.themeData
                                                                      .brightness ==
                                                                  Brightness
                                                                      .dark
                                                          ? DictionaryColors
                                                              .blackBackground
                                                          : e.partOfSpeech !=
                                                                      selectedValue &&
                                                                  context.themeData
                                                                          .brightness !=
                                                                      Brightness
                                                                          .dark
                                                              ? DictionaryColors
                                                                  .blackBackground
                                                              : DictionaryColors
                                                                  .whiteBackground,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        data: selectedValue ?? "",
                                        // isSelected: selectedValue != null,
                                        hasBorder: true,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            // TabsWidget(
                            //   data: "Definition",
                            //   isSelected: controller?.index == 1,
                            //   hasBorder: true,
                            // ),
                            // TabsWidget(
                            //   b
                            //   data: "Definition",
                            //   isSelected: controller?.index == 2,
                            //   hasBorder: true,
                            // ),
                            // TabsWidget(
                            //   data: "Definition",
                            //   hasBorder: false,
                            //   isSelected: controller?.index == 3,
                            // ),
                            // Tab(text: 'Definition'),
                            // Tab(text: 'Parts of Speech'),
                            // Tab(text: 'Origin'),
                            // Tab(text: 'Similar'),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.width(
                              context,
                              0.04,
                            ),
                            vertical: Sizes.height(
                              context,
                              0.022,
                            ),
                          ),
                          child: Column(
                            children: [
                              Column(
                                  spacing: Sizes.height(
                                    context,
                                    0.024,
                                  ),
                                  children: List.generate(
                                      state.dictionaryInfo[0].meanings
                                              ?.length ??
                                          0, (index) {
                                    final data = state.dictionaryInfo[0];
                                    // final meaningsLength = data.meanings?.length;
                                    final meanings = data.meanings?[index];
                                    final partOfSpeech =
                                        meanings?.partOfSpeech ?? "";
                                    if (!partOfSpeechKeys
                                        .containsKey(partOfSpeech)) {
                                      partOfSpeechKeys[partOfSpeech] =
                                          GlobalKey();
                                    }
                                    return DefinitionWidget(
                                      key: partOfSpeechKeys[partOfSpeech],
                                      isNew: true,
                                      image: PartOfSpeechImage.values
                                          .singleWhere((e) =>
                                              e.name == meanings?.partOfSpeech)
                                          .image,
                                      index: "${index + 1}",
                                      partOfSpeech:
                                          meanings?.partOfSpeech ?? "",
                                      definition: List.generate(
                                          meanings!.definitions!.length,
                                          (int index) => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Sizes.height(
                                                        context, 0.01)),
                                                child: Column(
                                                  children: [
                                                    DefinitionRow(
                                                      index: index,
                                                      definition: meanings
                                                          .definitions?[index]
                                                          .definition,
                                                    ),
                                                    ExampleRow(
                                                      isExample: meanings
                                                              .definitions?[
                                                                  index]
                                                              .example !=
                                                          null,
                                                      example: meanings
                                                          .definitions?[index]
                                                          .example,
                                                    )
                                                  ],
                                                ),
                                              )),
                                    );
                                  })),
                              if (origin != null)
                                DefinitionWidget(
                                  isNew: true,
                                  image: PartOfSpeechImage.values
                                      .singleWhere((e) => e.name == "noun")
                                      .image,
                                  index: "1",
                                  partOfSpeech: "Origin",
                                  definition: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Sizes.height(context, 0.01)),
                                      child: Column(
                                        children: [
                                          DefinitionRow(
                                            index: 0,
                                            definition: origin,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              if (similarWords.isNotEmpty)
                                SimilarSection(
                                  similarWords: similarWords
                                      .map((e) => SimilarWord(text: e))
                                      .toList(),
                                )
                            ],
                          ),
                        ),
                      )));
            }
            return const SizedBox.shrink();
          }),
    );
  }

  onBookmarkTap() {
    bookmarkBloc.insertData(
      response,
      widget.word,
      context,
    );
  }
}

enum PartOfSpeechImage {
  noun(image: DictionaryImages.dictionary),
  verb(image: DictionaryImages.dictionary),
  adjective(image: DictionaryImages.dictionary),
  adverb(image: DictionaryImages.dictionary),
  pronoun(image: DictionaryImages.dictionary),
  interjection(image: DictionaryImages.dictionary);

  final String image;
  const PartOfSpeechImage({
    required this.image,
  });
}

class TabContent extends StatelessWidget {
  final List<String> items;

  const TabContent(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: items.map((item) => ListTile(title: Text(item))).toList(),
    );
  }
}

class TabsWidget extends StatelessWidget {
  const TabsWidget({
    super.key,
    required this.data,
    this.onTap,
    this.isSelected,
    required this.hasBorder,
    required this.buttonSegments,
    this.onSelectionChanged,
    required this.selected,
  });
  final String data;
  final VoidCallback? onTap;
  final bool? isSelected;
  final bool hasBorder;
  final List<ButtonSegment> buttonSegments;
  final Set<dynamic> selected;
  final void Function(Set<dynamic>)? onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton(
        showSelectedIcon: false,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return context.themeData.brightness != Brightness.dark
                      ? DictionaryColors.blackBackground
                      : DictionaryColors.whiteBackground;
                }
                return context.themeData.brightness == Brightness.dark
                    ? DictionaryColors.blackBackground
                    : DictionaryColors.whiteBackground;
              },
            ),
            textStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) {
              print(states);
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.themeData.brightness != Brightness.dark
                        ? DictionaryColors.blackBackground
                        : DictionaryColors.whiteBackground);
              }
              return TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.themeData.brightness == Brightness.dark
                      ? DictionaryColors.blackBackground
                      : DictionaryColors.whiteBackground);
            }),
            // padding:
            // WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
            // minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
            // maximumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
            // fixedSize: WidgetStatePropertyAll(Size(100, 50)),
            side: WidgetStatePropertyAll(BorderSide(
                color: context.themeData.brightness != Brightness.dark
                    ? DictionaryColors.blackBackground
                    : DictionaryColors.whiteBackground)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
        emptySelectionAllowed: true,
        segments: buttonSegments,
        onSelectionChanged: onSelectionChanged,
        selected: selected,
        // child: Container(
        //   height: 40,
        //   // width: data.length.toDouble() * 10,
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   decoration: BoxDecoration(
        //       color: isSelected
        //           ? context.themeData.brightness == Brightness.dark
        //               ? DictionaryColors.blackBackground
        //               : DictionaryColors.darkShadow
        //           : null,
        //       border: Border(
        //           right: BorderSide(
        //         color: hasBorder
        //             ? context.themeData.brightness != Brightness.dark
        //                 ? DictionaryColors.blackBackground
        //                 : DictionaryColors.darkShadow
        //             : Colors.transparent,
        //       ))),
        //   child: GestureDetector(
        //     onTap: onTap,
        //     child: Center(
        //       child: Text(
        //         data,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
