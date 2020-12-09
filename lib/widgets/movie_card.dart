import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final Function onTap;

  const MovieCard({
    Key key,
    this.posterPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return posterPath != null ? GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    )
    : GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/imagens/noImageFound.png'
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );   
  }
}
