part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

class ProfileNavigateState extends HomeActionState {}

class SuccessState extends HomeState {
  final ResponseModel moviesData;
  SuccessState({
    required this.moviesData,
  });
}
