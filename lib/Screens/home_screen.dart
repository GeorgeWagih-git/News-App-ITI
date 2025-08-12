import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_event.dart';
import 'package:newproject/Blocs/IndexBloc/index_states.dart';
import 'package:newproject/Screens/content_screen.dart';
import 'package:newproject/constanrs.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeindexbloc,
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
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode)),
              ],
            ),
            body: ContentScreen(index: currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
    );
  }
}
