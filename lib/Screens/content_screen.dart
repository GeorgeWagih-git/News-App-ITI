import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_states.dart';
import 'package:newproject/constanrs.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeindexbloc,
      child: BlocBuilder<IndexBloc, IndexStates>(
        builder: (context, state) {
          return state is SuccessDataState
              ? ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.response.articles!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  state.response.articles?[index].urlToImage
                                              .toString() ==
                                          "null"
                                      ? 'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'
                                      : state
                                                .response
                                                .articles?[index]
                                                .urlToImage
                                                .toString() ??
                                            'https://cdn.pixabay.com/photo/2015/06/09/16/12/error-803716_1280.png',
                                ),
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
                                      : state.response.articles?[index].title
                                                .toString() ??
                                            'Error in getting data',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.response.articles?[index].description
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
              : state is LoadingDataState
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Text(
                    'Error',
                    style: TextStyle(fontSize: 50, color: Colors.red),
                  ),
                );
        },
      ),
    );
  }
}
