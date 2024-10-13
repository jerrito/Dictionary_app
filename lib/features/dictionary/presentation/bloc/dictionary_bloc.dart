import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/search_dictionary.dart';
import 'package:riverpod_learn/main.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final SearchDictionary searchDictionary;
  DictionaryBloc({required this.searchDictionary})
      : super(DictionartInitState()) {
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

    on<LoadAdEvent>((event, emit) async {
      emit(AdLoading());

      /// Loads an interstitial ad.
      try {
        await InterstitialAd.load(
            adUnitId: adUnitId,
            request: const AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              // Called when an ad is successfully received.
              onAdLoaded: (ad) {
                add(AdSuccessEvent(ad: ad));
                // ad.show();
                // emit(AdLoaded(ad: ad));

                // Keep a reference to the ad so you can show it later.
                // _interstitialAd = ad;
              },
              // Called when an ad request failed.
              onAdFailedToLoad: (LoadAdError error) {
                print("sa");
                add(AdFailedEvent(errorMessage: error.message));
                // debugPrint('InterstitialAd failed to load: $error');
              },
            ));
      } catch (e) {
        emit(AdLoadError(errorMessage: e.toString()));
      }
    });

    on<AdFailedEvent>((event, emit) {
      emit(AdLoadError(errorMessage: event.errorMessage ?? ""));
    });

    on<AdSuccessEvent>((event, emit) {
      emit(AdLoaded(ad: event.ad));
    });
  }

  InterstitialAd? _interstitialAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  Future<List<DictionaryResponse>> readAllDictionary() async {
    return database!.wordDao.getAll();
  }

  Future<bool> deleteDictionaryData(DictionaryResponse response) async {
    final data = await database?.wordDao.deleteDictionaryResponse(response);
    return true;
  }

  Future<bool> deleteDictionaryList(List<DictionaryResponse> list) async {
    final data = await database?.wordDao.deleteListDictionaryResponse(list);
    return true;
  }

  Future<void> insertData(Map<String, dynamic> json, String word) async {
    final readDict = await readAllDictionary();
    final isWordStored = readDict.any((e) => e.word == word);

    if (!isWordStored) {
      await database?.wordDao.insertData(
        DictionaryResponse(
          word: word,
          dictionary: DictionaryModel.fromJson(json),
        ),
      );
    }
  }
}
