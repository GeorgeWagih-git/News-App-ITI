abstract class IndexEvent {}

class ChangeIndexEvent extends IndexEvent {
  int index;
  ChangeIndexEvent({required this.index});
}

class GetNewsDataEvent extends IndexEvent {
  int index;
  GetNewsDataEvent({required this.index});
}
