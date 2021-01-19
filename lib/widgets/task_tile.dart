import 'package:flutter/material.dart';
import '../providers/tele_medicine.dart';
import '../screens/consultation_details_screen.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final String reference;
  final String name;
  final String date;
  final String status;
  final int index;
  TaskTile({this.reference, this.name, this.status, this.date,this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConsultationDetailsScreen(index),
            ),
          );
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: 70,
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text(
                reference,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[350],
              height: 60,
              width: 140,
              alignment: Alignment.center,
              child: Text(
                name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[300],
              height: 60,
              width: 120,
              alignment: Alignment.center,
              child: Text(
                date,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[350],
              height: 60,
              width: 70,
              alignment: Alignment.center,
              child: Text(
                status,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 1.0,
      ),
    ]);
  }
}
