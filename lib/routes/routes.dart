import 'package:flutter/material.dart';
import 'package:the_movie_app_with_bloc/home/home_ui.dart';
import 'package:the_movie_app_with_bloc/profile/profile_ui.dart';

class RouteManager {
  static const String homePage = '/';
  static const String profilePage = '/profilePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (context) => HomeUI());

      case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfileUI());

      default:
        throw const FormatException('Route Not Found !');
    }
  }
}
