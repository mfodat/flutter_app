import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class ScreenHolder extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final Widget body;
  final FloatingActionButton floatingActionButton;

  const ScreenHolder(
      {Key key,
        @required this.scaffoldKey,
        @required this.title,
        @required this.body,
        this.floatingActionButton})
      : super(key: key);

  @override
  ScreenHolderState createState() => ScreenHolderState();
}

class ScreenHolderState extends State<ScreenHolder> {
  @override
  void initState() {
    super.initState();
  }

  bool isTimerRunning = false;

  startTimeout([int milliseconds]) {
    isTimerRunning = true;
    var timer = new Timer.periodic(new Duration(seconds: 2), (time) {
      isTimerRunning = false;
      time.cancel();
    });
  }

  void _showToast(BuildContext context) {
    /*FlutterToast.showToast(
      msg: "Press back again to exit",
      toastLength: Toast.LENGTH_SHORT,
    );*/
  }

  Future<bool> _willPopCallback() async {

    int stackCount = 0;//Navigator.of(context).getNavigationHistory().length;
    if (stackCount == 1) {
      if (!isTimerRunning) {
        startTimeout();
        _showToast(context);
        return false;
      } else
        return true;
    } else {
      isTimerRunning = false;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: widget.body,
          floatingActionButton: widget
              .floatingActionButton // This trailing comma makes auto-formatting nicer for build methods.
      ),
      onWillPop: _willPopCallback,
    );
  }
}