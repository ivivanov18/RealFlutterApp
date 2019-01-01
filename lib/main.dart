import 'package:flutter/material.dart';

void main() => runApp(RealWorldApp());

class RealWorldApp extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new RealWorldState();
    }
}

class RealWorldState extends State<RealWorldApp>{

  var _isLoading = true;


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
                print("Reloading...");
                setState((){
                  _isLoading = !_isLoading;
                });
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