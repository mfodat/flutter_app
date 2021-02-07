import 'package:flutter/material.dart';
import 'package:flutter_app/database/login_response_data.dart';
import 'package:flutter_app/database/user_credentails.dart';
import 'package:flutter_app/soap/model/customer_login_client.dart';
// change `flutter_database` to whatever your project name is
import 'database/database_helper.dart';
import 'database/user_orm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods
  UserORM userORM = new UserORM();
  void _insert() async {
    // row to insert
    
    Customer loginResponseData = new Customer(fullName: 'Mohammad Aodat',customerID: '2234');

    Credential userCredentials = Credential(userName:'odat',password: '1111111' );
    userORM.insertUser(loginResponseData, userCredentials);
  }

  void _query() async {
    Credential userCredentials =  await userORM.getUserCredentials();
    print('get User Credentials row userName:' + userCredentials.userName +
        ',  password' + userCredentials.password);

  }

  void _update() async {
    // row to update
    Credential userCredentials = Credential(userName:'odat',password: '1111111d' );
      userORM.updatePassword(userCredentials);

  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    userORM.clearUser();
  }
}