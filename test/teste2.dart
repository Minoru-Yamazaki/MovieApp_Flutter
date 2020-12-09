import 'package:flutter/material.dart';

void main() => runApp(SearchAppBar());

class SearchAppBar extends StatefulWidget {
  @override
  _SearchAppBarState createState() => new _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  String appTitle = "Movie App";

  bool isSearchEnabled = true;

  _switchSearchBarState(){
    setState(() {
      isSearchEnabled = !isSearchEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new  MaterialApp(
      title: "My App 2019",
      home: Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.grey[800],
            title: !isSearchEnabled ? Text(appTitle) : TextField(
              style: new TextStyle(
                color: Colors.white,

              ),
              decoration: new InputDecoration(
                border: InputBorder.none,
                  prefixIcon: new Icon(Icons.search,color: Colors.white),
                  hintText: "Buscar filme...",
                  hintStyle: new TextStyle(color: Colors.white)
              ),
            ),
            actions: <Widget>[

              IconButton(
                icon: Icon(isSearchEnabled ? Icons.search : Icons.close),
                onPressed: _switchSearchBarState,
              ),

              IconButton(
                onPressed: (){},
                icon: Icon(Icons.filter_list),
              ),

              IconButton(
                onPressed: (){},
                icon:Icon(Icons.more_vert),
              )

            ]

        ),
      ),
    );
  }
}
