import "package:flutter/material.dart";

class VideoCellWidget extends StatelessWidget{
  final video;

  VideoCellWidget(this.video);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(video["imageUrl"]),
                  Container(height: 16.0),
                  Text(video["name"],
                      style: TextStyle(fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ]
            )
        ),
        Divider()
      ],
    );
  }
}