import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_app_with_bloc/home/bloc/home_bloc.dart';
import 'package:the_movie_app_with_bloc/home/components/movie_grid_view.dart';
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SuccessState) {
          final finalData = state.moviesData;
          //  print('successData ${successState[0].originalTitle}');

          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.56,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 15.0),
                itemCount: finalData?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             OverViewPage(moviedata: widget.finalData[index])

                      //             ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            color: Colors.transparent,
                            elevation: 5,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w185${finalData?[index].posterPath}',
                                  fit: BoxFit.fill,
                                  // errorBuilder: (context, error, stackTrace) {
                                  //   return const LoadingPage(); // shows loading gif if any type of error arises while loading image
                                  // },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            child: Text(
                              finalData![index].originalTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 13,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  '${finalData?[index].voteAverage}/10 IMDb',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
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
