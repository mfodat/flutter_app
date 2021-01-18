import 'package:flutter/material.dart';

class FilterModalBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: new Wrap(
        children: <Widget>[
          new ListTile(
            // leading: new Icon(Icons.music_note),
              title: new Text(
                'last 30 days',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                print('last 30 days');
                Navigator.pop(context);
              }),
          new ListTile(
            //  leading: new Icon(Icons.videocam),
              title: new Text(
                'last 60 days',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                print('last 60 days');
                Navigator.pop(context);
              }),
          new ListTile(
            //  leading: new Icon(Icons.videocam),
              title: new Text(
                'last 90 days',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                print('last 90 days');
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
