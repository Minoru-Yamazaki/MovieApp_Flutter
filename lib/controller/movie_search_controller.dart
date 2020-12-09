import 'package:dartz/dartz.dart';
import 'package:myapp/errors/movie_error.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/model/movie_response_model.dart';
import 'package:myapp/repository/movie_repository.dart';

class MovieController {
  final _repository = MovieRepository();

  MovieResponseModel movieResponseModel;
  MovieError movieError;
  bool loading = false;

  List<MovieModel> get movies => movieResponseModel?.movies ?? <MovieModel>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel?.totalPages ?? 1;
  int get currentPage => movieResponseModel?.page ?? 1;

  Future<Either<MovieError, MovieResponseModel>> fetch(
      String nomeFilme) async {
    movieError = null;

    final result = await _repository.fetchMovies(nomeFilme);
    result.fold(
      (error) => movieError = error,
      (movie) {
          movieResponseModel = movie;
          movieResponseModel.orderMoviesByDateAsc();
        },
    );

    return result;
  }
}
