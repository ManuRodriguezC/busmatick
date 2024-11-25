import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/presentation/providers/providers.dart';
import 'package:movie_app/presentation/widgets/witgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoding = ref.watch(initialLoadingProvider);
    if (initialLoding) return const FullScreenLoader();
    
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final sliceShowMovies = ref.watch(moviesSiliceShowProvider);

    if (sliceShowMovies.isEmpty) {
      return const CircularProgressIndicator();
    }

    return SingleChildScrollView(
      child: Column(children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: sliceShowMovies),
        MovieListview(
          movies: nowPlayingMovies,
          title: "En Cartelera",
          subtitle: "Recientes",
          loadNextPage: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
        )
      ]),
    );
  }
}
