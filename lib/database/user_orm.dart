import 'package:flutter_app/database/user_credentails.dart';
import 'package:flutter_app/soap/model/customer_login_client.dart';

import 'database_helper.dart';
import 'login_response_data.dart';

class UserORM {
  static const String COLUMN_ADDRESS = "address";
  static const String COLUMN_BIRTHDATE = "birthDate";
  static const String COLUMN_BIRTHYEAR = "birthYear";
  static const String COLUMN_CUSTOMERID = "customerID";
  static const String COLUMN_EMAIL = "EMail";

  static const String COLUMN_FULLNAME = "fullName";
  static const String COLUMN_IQMA = "iqamahID";
  static const String COLUMN_MED_CUSTOMERID = "medCustomerID";
  static const String COLUMN_MOBILE = "mobile";
  static const String COLUMN_NATIONALITY = "nationality";
  static const String COLUMN_PASSCHANGE = "passChange";
  static const String COLUMN_PASSWORD = "Password";
  static const String COLUMN_PHONE = "phone";
  static const String COLUMN_PO_BOX = "zipCode";
  static const String COLUMN_PREFERED_LANG = "preferredLanguage";
  static const String COLUMN_PREFRED_CONTACT = "preferredContact";
  static const String COLUMN_TEL_NUMBER = "telNumber1";
  static const String COLUMN_TEXT_TYPE = "TEXT";
  static const String COLUMN_USERNAME = "Username";
  static const String COMMA_SEP = ", ";
  static const String SQL_CREATE_TABLE =
      '''CREATE TABLE User (fullName TEXT,customerID TEXT,   Username TEXT, Password TEXT,address TEXT, birthDate TEXT, birthYear TEXT,
       EMail TEXT,  
       iqamahID TEXT, medCustomerID TEXT, mobile TEXT, nationality TEXT,
        passChange TEXT, phone TEXT, zipCode TEXT, preferredContact TEXT,
         preferredLanguage TEXT,
          telNumber1 TEXT)''';
  static const String SQL_DROP_TABLE = "DROP TABLE IF EXISTS User";
  static const String TABLE_NAME = "User";
  static const String TAG = "UserORM";

  //   static void insertUser(Context context: loginResponseData loginResponseData, String str, String str2) {
  //   SQLiteDatabase writableDatabase = new DatabaseWrapper(context).getWritableDatabase();
  //   long insert = writableDatabase.insert(TABLE_NAME, "null", postToContentValues(loginResponseData, str, str2));
  //   Log.i(TAG, "Inserted new Post with ID: " + insert);
  //   writableDatabase.close();
  // }

  // Map<String, dynamic> row = {
  //   DatabaseHelper.columnName : 'Bob',
  //   DatabaseHelper.columnAge  : 23
  // };
  Map<String, dynamic> toUserMap(
      Customer loginResponseData, Credential userCredentials ) {
    Map<String, dynamic> contentValues = {
      COLUMN_FULLNAME: loginResponseData.fullName,
      COLUMN_CUSTOMERID: loginResponseData.customerID,
     COLUMN_ADDRESS: loginResponseData.address,
      COLUMN_BIRTHDATE: loginResponseData.birthDate,
      COLUMN_BIRTHYEAR: loginResponseData.birthYear,

      COLUMN_EMAIL: loginResponseData.eMail,


      COLUMN_IQMA: loginResponseData.iqamahID,
      COLUMN_MED_CUSTOMERID: loginResponseData.medCustomerID,
      COLUMN_MOBILE: loginResponseData.mobile,
      COLUMN_NATIONALITY: loginResponseData.nationality,
      COLUMN_PASSCHANGE: loginResponseData.passChange,
      COLUMN_PHONE: loginResponseData.phone,
      COLUMN_PO_BOX: loginResponseData.zipCode,
      COLUMN_PREFRED_CONTACT: loginResponseData.preferredContact,
      COLUMN_PREFERED_LANG: loginResponseData.preferredLanguage,
      COLUMN_TEL_NUMBER: loginResponseData.telNumber1,
      COLUMN_USERNAME: userCredentials.userName,
      COLUMN_PASSWORD: userCredentials.password
    };

    return contentValues;
  }

  void insertUser(
      Customer loginResponseData,  Credential userCredentials) async {
    Map<String, dynamic> row =
        toUserMap(loginResponseData, userCredentials);
    final id = await DatabaseHelper.instance.insert(UserORM.TABLE_NAME, row);

    print('inserted row id: $id');
  }

  Future<Credential> getUserCredentials() async {

    List<Map<String, dynamic>> rows =
        await DatabaseHelper.instance.queryAllRows(UserORM.TABLE_NAME);
    Map<String, dynamic> row = rows.first;
    Credential userCredentials = new Credential(password:row[COLUMN_PASSWORD],userName: row[COLUMN_USERNAME] );
    print('get User Credentials row userName:' + userCredentials.userName + ',  password' + userCredentials.password);
    return userCredentials;
  }

  Future<Customer> getUser() async {

    List<Map<String, dynamic>> rows =
    await DatabaseHelper.instance.queryAllRows(UserORM.TABLE_NAME);
    Map<String, dynamic> row = rows.first;

    Customer customer = Customer(
      fullName: row[COLUMN_FULLNAME],
      birthYear:  row[COLUMN_BIRTHYEAR],
      eMail:  row[COLUMN_EMAIL],
      nationality: row[COLUMN_NATIONALITY],
      zipCode: row[COLUMN_PO_BOX],
      iqamahID: row[COLUMN_IQMA],
      medCustomerID:row[COLUMN_MED_CUSTOMERID],
      mobile:row[COLUMN_MOBILE],
      passChange: row[COLUMN_PASSCHANGE],
      preferredContact: row[COLUMN_PREFRED_CONTACT],
      preferredLanguage: row[COLUMN_PREFERED_LANG],
      // resultCode:row[COLUMN_],
      // resultDescription: row[COLUMN_],
      phone: row[COLUMN_PHONE],
      telNumber1: row[COLUMN_TEL_NUMBER],
    );

    print('get User  fullName:' + customer.fullName + ',  iqamahID' + customer.iqamahID);
    return customer;
  }

  void clearUser() async {
    await DatabaseHelper.instance.delete(UserORM.TABLE_NAME);
  }

  void updatePassword(Credential userCredentials ) async {
    Map<String, dynamic> contentValues = {
      COLUMN_PASSWORD: userCredentials.password,
      COLUMN_USERNAME:userCredentials.userName
    };
    await DatabaseHelper.instance.update(UserORM.TABLE_NAME, COLUMN_USERNAME, contentValues);
  }
}
