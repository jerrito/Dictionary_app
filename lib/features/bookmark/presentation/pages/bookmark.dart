import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:riverpod_learn/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/searched_words.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/show_meaning_modal.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  final bookmarkBloc = sl<BookmarkBloc>();
  final wordBloc = sl<WordBloc>();
  List<DictionaryBookmarkResponse> allBookmark = [];
  late BookmarkProvider bookmarkProvider;
  @override
  initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    getAllBookmark();
  }

  getAllBookmark() async {
    final response = await bookmarkBloc.readAllDictionary();
    if (response != []) {
      bookmarkProvider.dictionaryBookmarkData = response;
    }
  }

  @override
  Widget build(BuildContext context) {
    bookmarkProvider = context.watch<BookmarkProvider>();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: const Color.fromARGB(184, 30, 30, 128),
          title: Text(
            "Bookmarks",
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.width(context, 0.04),
              vertical: Sizes.height(context, 0.02)),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: bookmarkProvider.dictionaryBookmarkData
                .map((e) => SearchedWordsWidget(
                      dateTime: e.dateTime,
                      wordTitle: e.word,
                      onTap: () async {
                        if (!context.mounted) return;
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            scrollControlDisabledMaxHeightRatio:
                                ScrollDragController
                                    .momentumRetainVelocityThresholdFactor,
                            builder: (context) {
                              return ShowMeaningModal(
                                  dictionary:
                                      DictionaryModel.fromJson(e.dictionary));
                            });
                      },
                      wordBloc: wordBloc,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
