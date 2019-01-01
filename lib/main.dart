import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";


void main() => runApp(RealWorldApp());

class RealWorldApp extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new RealWorldState();
    }
}

class RealWorldState extends State<RealWorldApp>{

  var _isLoading = true;

  _fetchData() async{
    print("Attempting to load data...");
    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if(response.statusCode == 200){

      final mapResults = json.decode(response.body);
      final videosJSON = mapResults["videos"];
      videosJSON.forEach((video) {
        print(video["name"]);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Real World App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                setState((){
                  _isLoading = !_isLoading;
                });
                _fetchData();

              },
            )
          ],
        ),
        body: Center(
          child: _isLoading ? CircularProgressIndicator() : Text("Is loaded...")
        )
      )
    );
  }
}