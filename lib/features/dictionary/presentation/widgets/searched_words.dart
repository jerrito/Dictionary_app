import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:riverpod_learn/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchedWordsWidget extends StatefulWidget {
  const SearchedWordsWidget({
    super.key,
    required this.wordTitle,
    this.onTap,
    required this.wordBloc,
    required this.dateTime,
  });
  final String wordTitle, dateTime;
  final VoidCallback? onTap;
  final WordBloc wordBloc;

  @override
  State<SearchedWordsWidget> createState() => _SearchedWordsWidgetState();
}

class _SearchedWordsWidgetState extends State<SearchedWordsWidget> {
  final DictionaryBloc dictionaryBloc = sl<DictionaryBloc>();
  final WordBloc wordsBloc = sl<WordBloc>();
  final bookmarkBloc = sl<BookmarkBloc>();
  late BookmarkProvider bookmarkProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeaning();
  }

  getMeaning() async {
    dictionaryBloc.add(SearchWordMeaningEvent(params: widget.wordTitle));
  }

  final player = AudioPlayer();
  String? audioUrl;
  @override
  Widget build(BuildContext context) {
    // print("sss");
    bookmarkProvider = context.watch<BookmarkProvider>();

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.height(context, 0.016),
            vertical: Sizes.height(context, 0.01)),
        decoration: ShapeDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? DictionaryColors.primaryBase
                : DictionaryColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Sizes.height(
                    context,
                    0.012,
                  ),
                ),
                side: BorderSide(
                  width: 0.5,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? DictionaryColors.primary100
                      : DictionaryColors.primary400,
                )),
            shadows: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromRGBO(206, 206, 206, 0.1)
                    : const Color.fromRGBO(0, 0, 0, 0.1),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 0.6,
                // blurStyle: BlurStyle.inner,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.height(context, 0.012),
          children: [
            _FirstRow(
                moreOptionsOnTap: (details) => showPopMenu(
                      context,
                      details,
                      widget.wordTitle,
                      {},
                    ),
                hasAudio: audioUrl == null,
                wordTitle: widget.wordTitle,
                onAudioOnTap:
                    (audioUrl != null && (audioUrl?.isNotEmpty ?? false))
                        ? () async {
                            try {
                              await player.play(
                                UrlSource(
                                  audioUrl ?? "",
                                ),
                                volume: 1.0,
                              );
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          }
                        : null),
            BlocListener(
              bloc: wordsBloc,
              listener: (context, state) async {
                if (state is DeleteWordLoaded) {
                  final response =
                      await dictionaryBloc.getResponse(widget.wordTitle);
                  await dictionaryBloc.deleteDictionaryData(response!);
                  widget.wordBloc.add(const RetrieveWordEvent());
                }
              },
              child: BlocConsumer(
                bloc: dictionaryBloc,
                listener: (context, state) async {
                  if (state is SearchWordMeaningLoaded) {
                    bookmarkProvider.time = state.dateTime ??
                        state.dictionaryInfo.dateTime ??
                        DateTime.now().toIso8601String();
                    // print("mm ${state.dictionaryInfo.dateTime}");
                    // print(bookmarkProvider.dictionaryBookmarkData[0].dateTime);
                    if (state.dictionaryInfo.phonetic != null) {
                      audioUrl = state.dictionaryInfo.phonetic;
                    } else if (state.dictionaryInfo.phonetics?.isNotEmpty ??
                        false) {
                      audioUrl = state.dictionaryInfo.phonetics?[0].audio ??
                          state.dictionaryInfo.phonetics?[1].audio ??
                          "";
                    }

                    // state.dictionaryInfo["date"]

                    setState(() {});
                  }
                },
                builder: (context, state) {
                  if (state is SearchWordMeaningLoading) {
                    return const Skeletonizer(
                      enabled: true,
                      effect: ShimmerEffect(
                          baseColor: DictionaryColors.primary100,
                          highlightColor: DictionaryColors.primary200),
                      child: Text("datassjafhahasjjss"),
                    );
                  }
                  if (state is SearchWordMeaningLoaded) {
                    final String definition = state.dictionaryInfo.meanings?[0]
                            .definitions?[0].definition ??
                        "";
                    return SizedBox(
                      width: Sizes.width(context, 0.5),
                      child: Text(
                        (definition.length > 45)
                            ? definition.substring(0, 44)
                            : definition,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
            ),
            _LastRow(dictionaryBloc.getRelativeTime(DateTime.parse(
              bookmarkProvider.time ?? dateTime,
            )))
          ],
        ),
      ),
    );
  }

  String dateTime = DateTime.now().toIso8601String();

  deleteWord(String word) {
    final params = {"word": word};
    wordsBloc.add(DeleteWordEvent(params: params));
  }

  bookmarkWord(String word, Map<dynamic, dynamic> json) {
    bookmarkBloc.insertData(
      json,
      word,
      context,
    );
  }

  showPopMenu(BuildContext context, TapDownDetails details, String word,
      Map<dynamic, dynamic> json) {
    final offset = details.globalPosition;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        Sizes.width(context, 1) - offset.dx,
        Sizes.height(context, 1) - offset.dy,
      ),
      items: popUps(context, word, json),
    );
  }

  List<PopupMenuEntry<dynamic>> popUps(
          BuildContext context, String word, Map<dynamic, dynamic> json) =>
      [
        PopupMenuItem(
          onTap: () => deleteWord(word),
          child: const PopRows(
            isDeleteWord: true,
          ),
        ),
        PopupMenuItem(
          onTap: () => bookmarkWord(word, json),
          child: const PopRows(
            isDeleteWord: false,
          ),
        ),
      ];
}

class PopRows extends StatelessWidget {
  const PopRows({
    super.key,
    required this.isDeleteWord,
  });
  final bool isDeleteWord;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isDeleteWord ? Icons.delete_forever : Icons.bookmark_outline,
        ),
        Space.width(context, 0.016),
        Text(
          isDeleteWord ? "Delete word" : "Bookmark word",
        )
      ],
    );
  }
}

class _FirstRow extends StatelessWidget {
  const _FirstRow({
    this.hasAudio,
    required this.wordTitle,
    this.onAudioOnTap,
    this.moreOptionsOnTap,
  });
  final bool? hasAudio;
  final String wordTitle;
  final VoidCallback? onAudioOnTap;
  final void Function(TapDownDetails)? moreOptionsOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: Sizes.width(context, 0.015),
          children: [
            Text(
              wordTitle,
            ),
            GestureDetector(
              onTap: onAudioOnTap,
              child: SvgPicture.asset(
                DictionarySvgs.volumeSVG,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness != Brightness.dark
                      ? DictionaryColors.blackBackground
                      : DictionaryColors.whiteBackground,
                  BlendMode.srcIn,
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTapDown: moreOptionsOnTap,
          child: SvgPicture.asset(
            DictionarySvgs.moreHorizontalSVG,
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness != Brightness.dark
                  ? DictionaryColors.blackBackground
                  : DictionaryColors.whiteBackground,
              BlendMode.srcIn,
            ),
          ),
        )
      ],
    );
  }
}

class _LastRow extends StatelessWidget {
  const _LastRow(
    this.duration,
  );
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: Sizes.width(context, 0.01),
          children: [
            SvgPicture.asset(DictionarySvgs.timeSVG),
            Text(
              duration,
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_sharp)
      ],
    );
  }
}
