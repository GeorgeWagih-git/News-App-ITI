import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_event.dart';
import 'package:newproject/Blocs/IndexBloc/index_states.dart';
import 'package:newproject/constanrs.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  bool searchDone = false;
  Timer? time;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeindexbloc,
      child: BlocListener<IndexBloc, IndexStates>(
        listener: (context, state) {
          if (state is SearchErrorDataState) {
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
          } else if (state is SearchSuccessDataState && !searchDone) {
            searchDone = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "search is completed",
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
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (value) {
                    if (time?.isActive ?? false) time!.cancel();
                    time = Timer(const Duration(milliseconds: 1000), () {
                      if (value.isNotEmpty) {
                        BlocProvider.of<IndexBloc>(
                          context,
                        ).add(SearchinEverythingDataEvent(query: value));
                      }
                    });
                  },
                ),
              ),
              body: state is SearchSuccessDataState
                  ? ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.response.articles!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  (state.response.articles?[index].urlToImage !=
                                              null &&
                                          state
                                              .response
                                              .articles![index]
                                              .urlToImage!
                                              .isNotEmpty)
                                      ? state
                                            .response
                                            .articles![index]
                                            .urlToImage!
                                      : 'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                        'https://cdn.pixabay.com/photo/2015/06/09/16/12/error-803716_1280.png',
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 100,
                                      ),
                                ),
                              ),

                              SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      state.response.articles?[index].title
                                                  .toString() ==
                                              "null"
                                          ? 'Error in getting data'
                                          : state
                                                    .response
                                                    .articles?[index]
                                                    .title
                                                    .toString() ??
                                                'Error in getting data',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      state
                                                  .response
                                                  .articles?[index]
                                                  .description
                                                  .toString() ==
                                              "null"
                                          ? ''
                                          : state
                                                    .response
                                                    .articles?[index]
                                                    .description
                                                    .toString() ??
                                                '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : state is SearchLoadingDataState
                  ? Center(child: CircularProgressIndicator())
                  : state is SearchErrorDataState
                  ? Center(
                      child: Text(
                        state.e,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'The Result will be here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
