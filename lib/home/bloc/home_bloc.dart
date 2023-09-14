import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialStageEvent>(initialStageEvent);
    on<ProfileNavigateButtonEvent>(profileNavigateButtonEvent);
  }

  FutureOr<void> profileNavigateButtonEvent(
      ProfileNavigateButtonEvent event, Emitter<HomeState> emit) {
    emit(ProfileNavigateState());
  }

  FutureOr<void> initialStageEvent(
      InitialStageEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    await Future.delayed(Duration(seconds: 5));
    print('5 secconds');
    emit(SuccessState());
  }
}
