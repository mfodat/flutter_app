import 'package:flutter_app/database/user_credentails.dart';

import 'database_helper.dart';
import 'login_response_data.dart';

class UserORM {
  static const String COLUMN_ADDRESS = "address";
  static const String COLUMN_BIRTHDATE = "birthDate";
  static const String COLUMN_BIRTHYEAR = "birthYear";
  static const String COLUMN_CUSTOMERID = "customerID";
  static const String COLUMN_EMAIL = "EMail";
  static const String COLUMN_FAX = "fax";
  static const String COLUMN_FULLNAME = "fullName";
  static const String COLUMN_IQMA = "iqamahID";
  static const String COLUMN_MED_CUSTOMERID = "medCustomerID";
  static const String COLUMN_MOBILE = "mobile";
  static const String COLUMN_NATIONALITY = "nationality";
  static const String COLUMN_PASSCHANGE = "passChange";
  static const String COLUMN_PASSWORD = "Password";
  static const String COLUMN_PHONE = "phone";
  static const String COLUMN_PO_BOX = "pobox";
  static const String COLUMN_PREFERED_LANG = "preferredLanguage";
  static const String COLUMN_PREFRED_CONTACT = "preferredContact";
  static const String COLUMN_TEL_NUMBER = "telNumber1";
  static const String COLUMN_TEXT_TYPE = "TEXT";
  static const String COLUMN_USERNAME = "Username";
  static const String COMMA_SEP = ", ";
  static const String SQL_CREATE_TABLE =
      '''CREATE TABLE User (fullName TEXT,customerID TEXT,   Username TEXT, Password TEXT,address TEXT, birthDate TEXT, birthYear TEXT,
       EMail TEXT, fax TEXT, 
       iqamahID TEXT, medCustomerID TEXT, mobile TEXT, nationality TEXT,
        passChange TEXT, phone TEXT, pobox TEXT, preferredContact TEXT,
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
      LoginResponseData loginResponseData, UserCredentials userCredentials ) {
    Map<String, dynamic> contentValues = {
      COLUMN_FULLNAME: loginResponseData.fullName,
      COLUMN_CUSTOMERID: loginResponseData.customerID,
     COLUMN_ADDRESS: loginResponseData.address,
      COLUMN_BIRTHDATE: loginResponseData.birthDate,
      COLUMN_BIRTHYEAR: loginResponseData.birthYear,

      COLUMN_EMAIL: loginResponseData.email,
      COLUMN_FAX: loginResponseData.fax,

      COLUMN_IQMA: loginResponseData.iqamahID,
      COLUMN_MED_CUSTOMERID: loginResponseData.medCustomerID,
      COLUMN_MOBILE: loginResponseData.mobile,
      COLUMN_NATIONALITY: loginResponseData.nationality,
      COLUMN_PASSCHANGE: loginResponseData.passChange,
      COLUMN_PHONE: loginResponseData.phone,
      COLUMN_PO_BOX: loginResponseData.pobox,
      COLUMN_PREFRED_CONTACT: loginResponseData.preferredContact,
      COLUMN_PREFERED_LANG: loginResponseData.preferredLanguage,
      COLUMN_TEL_NUMBER: loginResponseData.telNumber1,
      COLUMN_USERNAME: userCredentials.userName,
      COLUMN_PASSWORD: userCredentials.password
    };

    return contentValues;
  }

  void insertUser(
      LoginResponseData loginResponseData,  UserCredentials userCredentials) async {
    Map<String, dynamic> row =
        toUserMap(loginResponseData, userCredentials);
    final id = await DatabaseHelper.instance.insert(UserORM.TABLE_NAME, row);

    print('inserted row id: $id');
  }

  Future<UserCredentials> getUserCredentials() async {
    UserCredentials userCredentials = new UserCredentials();
    List<Map<String, dynamic>> rows =
        await DatabaseHelper.instance.queryAllRows(UserORM.TABLE_NAME);
    Map<String, dynamic> row = rows.first;
    userCredentials.userName  = row[COLUMN_USERNAME];
    userCredentials.password  = row[COLUMN_PASSWORD];
    print('get User Credentials row userName:' + userCredentials.userName + ',  password' + userCredentials.password);
    return userCredentials;
  }

  void clearUser() async {
    await DatabaseHelper.instance.delete(UserORM.TABLE_NAME);
  }

  void updatePassword(UserCredentials userCredentials ) async {
    Map<String, dynamic> contentValues = {
      COLUMN_PASSWORD: userCredentials.password,
      COLUMN_USERNAME:userCredentials.userName
    };
    await DatabaseHelper.instance.update(UserORM.TABLE_NAME, COLUMN_USERNAME, contentValues);
  }
}
