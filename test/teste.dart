
import 'package:myapp/core/api.dart';
import 'package:tmdb_api/tmdb_api.dart';

main(List<String> args) async {
  // //api with out console logs
  // TMDB tmdb = TMDB(ApiKeys(keyV3, keyV4));
  // print(await tmdb.v3.movies.getPouplar());

  // //api with showing all console logs
  // TMDB tmdbWithLogs = TMDB(
  //   ApiKeys(keyV3, keyV4),
  //   logConfig: ConfigLogger.showAll(),
  // );
  // print(await tmdbWithLogs.v3.movies.getPouplar());

  //api with showing all console logs
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(keyV3, keyV4),
    logConfig: ConfigLogger(
      //must be true than only all other logs will be shown
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  print(await tmdbWithCustomLogs.v3.movies.getDetails(103, language: 'pt-BR'));
}