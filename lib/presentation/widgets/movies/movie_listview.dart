import 'package:flutter/material.dart';
import 'package:movie_app/config/helpers/human_format.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

class MovieListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieListview> createState() => _MovieListviewState();
}

class _MovieListviewState extends State<MovieListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),
          Expanded(
              child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.45),
                  itemCount: widget.movies.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _Slide(movie: widget.movies[index]);
                  }))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 170,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }
                return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child));
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 170,
          child: Text(
            movie.title,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 170,
          child: Text(
            movie.overview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.star_half_outlined,
              color: Colors.yellow.shade800,
              size: 30,
            ),
            const SizedBox(width: 4),
            Text(
              '${movie.voteAverage.toString().substring(0, 3)}',
              style: TextStyle(
                color: Colors.yellow.shade900,
              ),
            ),
            const Spacer(),
            Text(
              HumanFormats.number(movie.popularity),
              style: const TextStyle(
                color: Colors.black87,
              ),
            )
          ],
        )
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          const Spacer(),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
        ],
      ),
    );
  }
}
