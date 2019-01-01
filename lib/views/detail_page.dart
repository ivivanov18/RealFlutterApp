import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import "./view_cell_widget.dart";

// TODO: Check why first picture is not displayed

class DetailPageWidget extends StatefulWidget {
  final id;

  DetailPageWidget(this.id);

  @override
  _DetailPageWidgetState createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {

  var _isLoading = true;
  var videos;


  _fetchData() async {
    final id = widget.id + 1;
    final url = "https://api.letsbuildthatapp.com/youtube/course_detail?id=$id";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final mapResults = json.decode(response.body);

      setState(() {
        _isLoading = false;
        this.videos = mapResults;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail screen"),
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
                      return VideoCellWidget(video);
                    },
                  )));
  }
}
