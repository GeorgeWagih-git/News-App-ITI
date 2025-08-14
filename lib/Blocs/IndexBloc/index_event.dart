abstract class IndexEvent {}

class ChangeIndexEvent extends IndexEvent {
  int index;
  ChangeIndexEvent({required this.index});
}

class GetNewsDataEvent extends IndexEvent {
  int index;
  GetNewsDataEvent({required this.index});
}

class GetALLDataEvent extends IndexEvent {}

class SearchinEverythingDataEvent extends IndexEvent {
  String query;

  SearchinEverythingDataEvent({required this.query});
}
