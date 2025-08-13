import 'package:newproject/api/json_data.dart';

abstract class IndexStates {}

class InitialIndexState extends IndexStates {}

class ChangeIndexState extends IndexStates {
  int index;
  ChangeIndexState({required this.index});
}

class SuccessDataState extends IndexStates {
  JsonData response;
  SuccessDataState({required this.response});
}

class LoadingDataState extends IndexStates {}

class ErrorDataState extends IndexStates {
  String e;
  ErrorDataState({required this.e});
}
