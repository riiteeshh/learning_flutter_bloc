import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app_with_bloc/home/bloc/home_bloc.dart';

import 'package:the_movie_app_with_bloc/routes/routes.dart';

class HomeUI extends StatefulWidget {
  HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  HomeBloc homeBloc = HomeBloc();

  // void initstate() {
  //   homeBloc.add(InitialStageEvent());
  //   super.initState();
  // }
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => homeBloc.add(InitialStageEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is ProfileNavigateState) {
            Navigator.pushNamed(context, RouteManager.profilePage);
          }
        },
        bloc: homeBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeInitial:
              return Center(
                child: CircularProgressIndicator(),
              );
            case SuccessState:
              return Scaffold(
                body: ListView.builder(itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      homeBloc.add(ProfileNavigateButtonEvent());
                    },
                    child: const ListTile(
                      title: Text('Checking bloc'),
                    ),
                  );
                }),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
