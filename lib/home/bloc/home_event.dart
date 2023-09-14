part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialStageEvent extends HomeEvent {}

class ProfileNavigateButtonEvent extends HomeEvent {}
