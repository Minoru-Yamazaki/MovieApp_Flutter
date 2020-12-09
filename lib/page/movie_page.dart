import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controller/movie_search_controller.dart';
import 'package:myapp/core/constants.dart';
import 'package:myapp/page/movie_detail_page.dart';
import 'package:myapp/widgets/centered_message.dart';
import 'package:myapp/widgets/centered_progress.dart';
import 'package:myapp/widgets/movie_card.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() {
    return new _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage>{
  final _controller = MovieController();
  final _scrollController = ScrollController();
  bool isSearchEnabled = false;
  bool isInitState = true;
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _newSearch('');
    _scrollController.addListener(() {});    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: isInitState ? _buildInitImage() : _buildMovieGrid(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: !isSearchEnabled ? Text(appName) : TextField(
        onSubmitted: (text){
          text.isEmpty ? showAlertDialog() : _newSearch(text);                     
        },
        decoration: new InputDecoration(
          hintText: "Buscar filme...",
        ),
      ),
            
      actions: [
        IconButton(
          icon: Icon(isSearchEnabled ? Icons.arrow_back : Icons.search),
          onPressed: _switchSearchBarState,       
        ),
      ],      
    );
  }

  showAlertDialog() {
    AlertDialog alerta = AlertDialog(
      title: Text("Digite um filme!",
        textAlign: TextAlign.center,
        ),
      );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  _newSearch(String nomeFilme) async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetch(nomeFilme);

    setState(() {
      _controller.loading = false;
    });
  }

  _switchSearchBarState(){
    setState(() {
      isSearchEnabled = !isSearchEnabled;
      isSearchEnabled ? isInitState = false : isInitState = true;    
    });     
  } 

  _buildMovieGrid() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    } 

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2.0),
      itemCount: _controller.moviesCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.65,
      ),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => _openDetailPage(movie.id),
    );
  }

  Center _buildInitImage(){
    return Center(
      child: Image(
        image: AssetImage('assets/imagens/TMDB-logo.png'),
      ),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }
}

  
