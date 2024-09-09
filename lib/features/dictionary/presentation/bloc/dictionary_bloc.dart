import 'package:flutter_bloc/flutter_bloc.dart';
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
        print(response);
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
  }
  Future<List<DictionaryResponse>> readAllDictionary()async{
    return database!.wordDao.getAll();
  }
  Future<void> insertData(Map<String,dynamic> json,String word) async {
   final readDict= await readAllDictionary();
   final isWordStored=readDict.any((e)=>
    e.word ==word
   );

   
   if(!isWordStored){
    await database?.wordDao.insertData(
      DictionaryResponse(
        word:word,
        dictionary: DictionaryModel.fromJson(json),
      ),
    );
   }
  }
}
