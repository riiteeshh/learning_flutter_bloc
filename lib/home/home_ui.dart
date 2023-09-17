import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app_with_bloc/home/bloc/home_bloc.dart';
import 'package:the_movie_app_with_bloc/home/components/movie_grid_view.dart';
import 'package:the_movie_app_with_bloc/model/data_model.dart';
import 'package:the_movie_app_with_bloc/model/movies_data_model.dart';
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
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is ProfileNavigateState) {
          Navigator.pushNamed(context, RouteManager.profilePage);
        }
      },
      bloc: homeBloc,
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuccessState) {
          final ResponseModel finalData = state.moviesData;
          print('successData ${finalData.data[0]['original_title']}');

          return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.56,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 15.0),
                    itemCount: finalData.data.length,
                    itemBuilder: (context, index) {
                      return MovieGridVew(
                        finalData: finalData.data[index],
                      );
                    }),
              ));
        }
        return Center(
          child: Container(),
        );
        // switch (state.runtimeType) {
        //   case HomeInitial:
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   case SuccessState:
        //     if (state is SuccessState) {
        //       final successState = state.moviesData;
        //       print('successData ${successState.length}');
        //       return Scaffold(
        //         appBar: AppBar(
        //           title: Text('Home'),
        //         ),
        //         body: MovieGridVew(finalData: successState),
        //       );
        //     }

        //   default:
        //     return Container();
        // }
      },
    );
  }
}
