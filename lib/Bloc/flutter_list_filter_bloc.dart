import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
