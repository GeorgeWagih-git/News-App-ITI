import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/theme_bloc/theme_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvents, bool> {
  bool isLight = true;
  ThemeBloc() : super(true) {
    on<InitTheme>((event, emit) async {
      var shared = await SharedPreferences.getInstance();
      isLight = shared.getBool('theme') ?? true;
      emit(isLight);
    });
    on<ChangeTheme>((event, emit) async {
      var shared = await SharedPreferences.getInstance();
      await shared.setBool('theme', event.isLight);
      emit(event.isLight);
    });
  }
}
