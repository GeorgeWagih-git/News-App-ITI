import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_event.dart';
import 'package:newproject/Blocs/IndexBloc/index_states.dart';
import 'package:newproject/Blocs/theme_bloc/theme_bloc.dart';
import 'package:newproject/Blocs/theme_bloc/theme_events.dart';
import 'package:newproject/Screens/content_screen.dart';
import 'package:newproject/Screens/search_screen.dart';
import 'package:newproject/constanrs.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  int currentIndex = 0;
  bool welcome = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeindexbloc..add(GetNewsDataEvent(index: currentIndex)),
      child: BlocListener<IndexBloc, IndexStates>(
        listener: (context, state) {
          if (state is ErrorDataState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.e,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is SuccessDataState && !welcome) {
            welcome = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Welcome Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<IndexBloc, IndexStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  titels[currentIndex],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                  BlocBuilder<ThemeBloc, bool>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<ThemeBloc>(
                            context,
                          ).add(ChangeTheme(isLight: !state));
                        },
                        icon: Icon(Icons.dark_mode),
                      );
                    },
                  ),
                ],
              ),
              body: ContentScreen(index: currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.science),
                    label: 'Science',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports),
                    label: 'Sports',
                  ),
                ],
                currentIndex: currentIndex,
                onTap: (value) {
                  currentIndex = value;
                  BlocProvider.of<IndexBloc>(
                    context,
                  ).add(GetNewsDataEvent(index: value));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
