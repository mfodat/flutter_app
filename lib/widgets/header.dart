import 'package:flutter/material.dart';

class Header extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Column(
        children: [ Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                width: 70,
                alignment:Alignment.center ,
                color: Colors.white10,
                child: Text('Ref',textAlign: TextAlign.center,),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white10,
                height: 60,
                width: 140,
                alignment:Alignment.center ,
                child: Text('Name',textAlign: TextAlign.center,),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white10,
                height: 60,
                width: 120,
                alignment:Alignment.center ,
                child: Text('Date',textAlign: TextAlign.center,),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white10,
                height: 60,
                width: 70,
                alignment:Alignment.center ,
                child: Text('Status',textAlign: TextAlign.center,),
              ),
            ),
          ]),
          SizedBox(
            height: 1.0,
          ),
    ]);
  }
}
