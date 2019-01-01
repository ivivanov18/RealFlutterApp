import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import "./views/view_cell_widget.dart";
import './views/detail_page.dart';

void main() => runApp(RealWorldApp());

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldState();
  }
}

class RealWorldState extends State<RealWorldApp> {
  var _isLoading = true;
  var videos;

  _fetchData() async {
    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final mapResults = json.decode(response.body);
      final videosJSON = mapResults["videos"];

      videosJSON.forEach((video) {
        print(video["name"]);
      });

      setState(() {
        _isLoading = false;
        this.videos = videosJSON;
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
                  onPressed: () {
                    _fetchData();
                  },
                )
              ],
            ),
            body: Center(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: this.videos != null ? this.videos.length : 0,
                        itemBuilder: (context, i) {
                          final video = this.videos[i];
                          return FlatButton(
                            child: VideoCellWidget(video),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPageWidget(i)));
                            },
                          );
                        },
                      ))));
  }
}

