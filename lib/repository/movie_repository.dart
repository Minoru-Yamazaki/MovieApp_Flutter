import 'package:dartz/dartz.dart';
import 'package:myapp/core/api.dart';
import 'package:myapp/errors/movie_error.dart';
import 'package:myapp/model/movie_detail_model.dart';
import 'package:myapp/model/movie_response_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieRepository {
 
  Future<Either<MovieError, MovieResponseModel>> fetchMovies(
      String nomeFilme) async {
      TMDB tmdb = TMDB(ApiKeys(keyV3, keyV4),
      logConfig: ConfigLogger.showAll(),
      );
    
    try {
      var map;
      nomeFilme == ''? map = await tmdb.v3.movies.getNowPlaying() :  map = await tmdb.v3.search.queryMovies(nomeFilme);
      final model = MovieResponseModel.fromMap(map);
      return Right(model);
    
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    TMDB tmdb = TMDB(ApiKeys(keyV3, keyV4));
    try {
      final map = await tmdb.v3.movies.getDetails(id, language: 'pt-BR'); //search.queryMovies('teste')
      final model = MovieDetailModel.fromMap(map);
      return Right(model);
    
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

}