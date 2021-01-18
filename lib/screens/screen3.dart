import 'dart:math';

import 'package:flutter/material.dart';
import '../models/member_history_response.dart';
import '../providers/tele_medicine.dart';
import '../util/exception_handler.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

class Screen3 extends StatelessWidget {
  //static const routeName = '/teleMedicine-prev-history';
  final int index ;
  Screen3(this.index);
  @override
  Widget build(BuildContext context) {
    //final index = ModalRoute.of(context).settings.arguments as int;
    final MemberHistory memberHistory = Provider.of<TeleMedicine>(
      context,
      listen: false,
    ).memberHistoryList[index];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Reference Number'),
                  initialValue: memberHistory.referenceNumber,
                  enabled: false,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Member Name'),
                  initialValue: memberHistory.memberName,
                  enabled: false,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Status'),
                  initialValue: memberHistory.status,
                  enabled: false,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Question'),
                  initialValue: memberHistory.question,
                  enabled: false,
                  maxLines: 5,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
