import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/get_similar_words.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/search_dictionary.dart';
import 'package:riverpod_learn/main.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final SearchDictionary searchDictionary;
  final GetSimilarWords similarWords;
  DictionaryBloc({
    required this.searchDictionary,
    required this.similarWords,
  }) : super(DictionartInitState()) {
    on<SearchDictionaryEvent>(
      (event, emit) async {
        emit(SearchDictionaryLoading());
        final response = await searchDictionary.call(event.params);
        emit(
          response.fold(
            (e) => SearchDictionaryError(
              errorMessage: e,
            ),
            (response) => SearchDictionaryLoaded(
              dictionaryInfo: response,
            ),
          ),
        );
      },
      // transformer: restartable(),
    );
    on<SimilarWordsEvent>(
      (event, emit) async {
        emit(SimilarWordsLoading());
        final response = await similarWords.call(event.params);
        emit(
          response.fold(
            (e) => SimilarWordsError(
              errorMessage: e,
            ),
            (response) => SimilarWordsLoaded(
              dictionaryInfo: response,
            ),
          ),
        );
      },
      // transformer: restartable(),
    );
    on<SearchWordMeaningEvent>(
      (event, emit) async {
        emit(SearchWordMeaningLoading());
        final response = await getResponse(event.params);
        if (response != null) {
          print("ss${response.dateTime}");
          emit(
            SearchWordMeaningLoaded(
              dateTime: response.dateTime,
              dictionaryInfo: DictionaryModel.fromJson(
                response.dictionary,
              ),
            ),
          );
        } else {
          emit(SearchWordMeaningError(errorMessage: "Error"));
        }
      },
    );

    on<InterstatialAdEvent>((event, emit) async {
      emit(InterstatialAdLoading());

      /// Loads an interstitial ad.
      try {
        await InterstitialAd.load(
            adUnitId: interstitialId,
            request: const AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              // Called when an ad is successfully received.
              onAdLoaded: (ad) {
                add(InterstatialAdSuccessEvent(ad: ad));
                // ad.show();
                // emit(AdLoaded(ad: ad));

                // Keep a reference to the ad so you can show it later.
                // _interstitialAd = ad;
              },
              // Called when an ad request failed.
              onAdFailedToLoad: (LoadAdError error) {
                add(InterstatialAdFailedEvent(errorMessage: error.message));
                // debugPrint('InterstitialAd failed to load: $error');
              },
            ));
      } catch (e) {
        emit(InterstatialAdLoadError(errorMessage: e.toString()));
      }
    });

    on<InterstatialAdFailedEvent>((event, emit) {
      emit(InterstatialAdLoadError(errorMessage: event.errorMessage ?? ""));
    });

    on<InterstatialAdSuccessEvent>((event, emit) {
      emit(InterstatialAdLoaded(ad: event.ad));
    });
  }

  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111'
          : "ca-app-pub-6517705244211453/8328545291"
      : kDebugMode
          ? 'ca-app-pub-3940256099942544/2934735716'
          : 'ca-app-pub-6517705244211453/7722040635';

  final interstitialId = Platform.isAndroid
      ? kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712'
          : "ca-app-pub-6517705244211453/6550608932"
      : kDebugMode
          ? 'ca-app-pub-3940256099942544/4411468910'
          : 'ca-app-pub-6517705244211453/1733396526';

  Future<List<DictionaryResponse>> readAllDictionary() async {
    return database!.wordDao.getAll();
  }

  Future<bool> deleteDictionaryData(DictionaryResponse response) async {
    final data = await database?.wordDao.deleteDictionaryResponse(response);
    return true;
  }

  Future<bool> deleteDictionaryList(List<DictionaryResponse> list) async {
    try {
      final data = await database?.wordDao.deleteListDictionaryResponse(list);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> insertData(Map<dynamic, dynamic>? json, String word) async {
    try {
      final readDict = await readAllDictionary();
      final isWordStored = readDict.any((e) => e.word == word);

      if (!isWordStored) {
        await database?.wordDao.insertData(
          DictionaryResponse(
            dateTime: DateTime.now().toIso8601String(),
            word: word,
            dictionary: json,
          ),
        );
      }
    } catch (e) {
      // print(e.toString());
      // emit(state)
    }
  }

  Future<DictionaryResponse?> getResponse(String word) async {
    try {
      final response = await database?.wordDao.getDictionaryResponse(word);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Less than a minute
    if (difference.inSeconds < 60) {
      return 'Just now';
    }

    // Less than an hour
    else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    }

    // Less than a day
    else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    }

    // Less than a month (approximating a month as 30 days)
    else if (difference.inDays < 30) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    }

    // Less than a year
    else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }

    // More than a year
    else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  deleteWords() {}
}
