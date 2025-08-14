import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/theme_bloc/theme_bloc.dart';
import 'package:newproject/Blocs/theme_bloc/theme_events.dart';
import 'package:newproject/Screens/home_screen.dart';
import 'package:newproject/api/dio_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(InitTheme())),
      ],
      child: MyApp(),
    ),
  );
}

void getDataFromShared() {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          theme: state == true
              ? ThemeData(
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.orange,
                  ),
                )
              : ThemeData.dark(),
        );
      },
    );
  }
}
