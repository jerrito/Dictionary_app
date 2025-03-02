import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferences sharedPreferences;
  HomeBloc({required this.sharedPreferences}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final String userKey = "UserKey";
  Future<bool> setUser(String userValue) async {
    final response = await sharedPreferences.setString(userKey, userValue);
    return response;
  }

  bool checkIfUserExist() {
    final response = sharedPreferences.getString(userKey);
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }
}
