import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app_with_bloc/home/repos/repos.dart';
import 'package:the_movie_app_with_bloc/model/data_model.dart';
import 'package:the_movie_app_with_bloc/model/movies_data_model.dart';
import 'package:the_movie_app_with_bloc/model/response_model.dart';

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
    print('reached HOMEINITIAL');
    final movieResult = await Repos.fetchMovieData();
    print('fetching completed');

    print(movieResult.runtimeType);
    print(movieResult);
    emit(SuccessState(moviesData: movieResult));
  }
}
