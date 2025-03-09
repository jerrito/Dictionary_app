import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchedWordsWidget extends StatefulWidget {
  const SearchedWordsWidget({
    super.key,
    required this.wordTitle,
    this.onTap,
  });
  final String wordTitle;
  final VoidCallback? onTap;

  @override
  State<SearchedWordsWidget> createState() => _SearchedWordsWidgetState();
}

class _SearchedWordsWidgetState extends State<SearchedWordsWidget> {
  final DictionaryBloc dictionaryBloc = sl<DictionaryBloc>();
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
            BlocConsumer(
              bloc: dictionaryBloc,
              listener: (context, state) async {
                if (state is SearchWordMeaningLoaded) {
                  if (state.dictionaryInfo.phonetic != null) {
                    audioUrl = state.dictionaryInfo.phonetic;
                  } else if (state.dictionaryInfo.phonetics?.isNotEmpty ??
                      false) {
                    audioUrl = state.dictionaryInfo.phonetics?[0].audio ??
                        state.dictionaryInfo.phonetics?[1].audio ??
                        "";
                  }

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
            const _LastRow("duration"),
          ],
        ),
      ),
    );
  }
}

class _FirstRow extends StatelessWidget {
  const _FirstRow({
    this.hasAudio,
    required this.wordTitle,
    this.onAudioOnTap,
  });
  final bool? hasAudio;
  final String wordTitle;
  final VoidCallback? onAudioOnTap;

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
        SvgPicture.asset(
          DictionarySvgs.moreHorizontalSVG,
          colorFilter: ColorFilter.mode(
            Theme.of(context).brightness != Brightness.dark
                ? DictionaryColors.blackBackground
                : DictionaryColors.whiteBackground,
            BlendMode.srcIn,
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
