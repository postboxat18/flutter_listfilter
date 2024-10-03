part of 'flutter_list_filter_bloc.dart';

@immutable
sealed class FlutterListFilterEvent {}

class FilterLoadEvent extends FlutterListFilterEvent {
  final Map<dynamic, dynamic> map;
  FilterLoadEvent(this.map);
}
