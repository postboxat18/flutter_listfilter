import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'flutter_list_filter_event.dart';

part 'flutter_list_filter_state.dart';

class FlutterListFilterBloc
    extends Bloc<FlutterListFilterEvent, FlutterListFilterState> {
  FlutterListFilterBloc() : super(FlutterListFilterInitial()) {
    on<FilterLoadEvent>(filterLoadEvent);
  }

  FutureOr<void> filterLoadEvent(
      FilterLoadEvent event, Emitter<FlutterListFilterState> emit) {
    emit(FilterLoadState(event.map));
  }
}
