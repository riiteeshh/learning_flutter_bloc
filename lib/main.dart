import 'package:flutter/material.dart';
import 'package:the_movie_app_with_bloc/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteManager.generateRoute,
      initialRoute: RouteManager.homePage,
      theme: ThemeData(appBarTheme: const AppBarTheme(centerTitle: true)),
    );
  }
}
