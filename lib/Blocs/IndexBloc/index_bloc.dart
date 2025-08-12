import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Blocs/IndexBloc/index_event.dart';
import 'package:newproject/Blocs/IndexBloc/index_states.dart';
import 'package:newproject/api/dio_api.dart';
import 'package:newproject/api/json_data.dart';
import 'package:newproject/constanrs.dart';

class IndexBloc extends Bloc<IndexEvent, IndexStates> {
  IndexBloc() : super(InitialIndexState()) {
    on<ChangeIndexEvent>((event, emit) {
      emit(ChangeIndexState(index: event.index));
      add(GetNewsDataEvent(index: event.index));
    });
    on<GetNewsDataEvent>((event, emit) async {
      emit(LoadingDataState());
      Response response = await DioHelper.getCategoryData(
        category: categorytitels[1],
      );
      if (event.index == 0) {
        response = await DioHelper.getEveryThingData();
      } else {
        response = await DioHelper.getCategoryData(
          category: categorytitels[event.index - 1],
        );
      }
      print(response.data);
      var responseObj = JsonData.fromJson(response.data);
      response.statusCode == 200
          ? emit(SuccessDataState(response: responseObj))
          : emit(ErrorDataState());
    });
  }
}
