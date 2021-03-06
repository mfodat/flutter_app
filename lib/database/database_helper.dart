import 'dart:io';
import './policy_orm.dart';
import './user_orm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'branch_orm.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 3;
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null)
       return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,

        onCreate: _onCreate,  onUpgrade: _onUpgrade );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(UserORM.SQL_CREATE_TABLE);
    await db.execute(PolicyORM.SQL_CREATE_TABLE);
    await db.execute(BranchORM.SQL_CREATE_TABLE);
  }
  Future _onUpgrade(Database db,int oldVersion, int newVersion) async {
    await db.execute(UserORM.SQL_DROP_TABLE);
    await db.execute(PolicyORM.SQL_DROP_TABLE);
    await db.execute(BranchORM.SQL_DROP_TABLE);
    await _onCreate(  db,   newVersion);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table,Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table,String columnId,Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, {String where, List<dynamic> whereArgs}) async {
    Database db = await instance.database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> drop(String table) async {
    Database db = await instance.database;
    return await db.execute(table);
  }

}