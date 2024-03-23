part of 'flutter_list_filter_bloc.dart';

@immutable
sealed class FlutterListFilterState {}

final class FlutterListFilterInitial extends FlutterListFilterState {}
class FilterLoadState extends FlutterListFilterState {
  final  Map<dynamic,dynamic> map;

  FilterLoadState(this.map);
}
