import 'package:flutter_app/database/policy.dart';
import 'package:flutter_app/database/user_credentails.dart';

import 'database_helper.dart';
import 'login_response_data.dart';

class PolicyORM {
  static const String COLUMN_DESC =  "Description";
  static const String COLUMN_EXPIRYDATE = "ExpireDate";
  static const String COLUMN_GLOB =  "Glob";
  static const String COLUMN_LOB =  "Lob";
  static const String COLUMN_POLICYNO =  "PolicyNo";
  static const String COLUMN_PREMIUM =  "Premium";
  static const String COLUMN_PRODUCT =  "Product";
  static const String COLUMN_STATUS =  "Status";
  static const String COLUMN_TEXT_TYPE = "TEXT";
  static const String COMMA_SEP = ", ";
  static const String  SQL_CREATE_TABLE = "CREATE TABLE Policies (ExpireDate TEXT,  Description TEXT,  Glob TEXT,  Lob TEXT,  PolicyNo TEXT,  Premium TEXT,  Product TEXT,  Status TEXT)";
  static const String   SQL_DROP_TABLE = "DROP TABLE IF EXISTS Policies";
  static const String TABLE_NAME = "Policies";
  static const String TAG = "PolicyORM";

  Map<String, dynamic> toPolicyMap(  Policy policy ) {
    Map<String, dynamic> contentValues = {
      COLUMN_EXPIRYDATE:  policy.ExpireDate,
      COLUMN_DESC:  policy.Description,
      COLUMN_GLOB:  policy.Glob,
      COLUMN_LOB:  policy.Lob,
      COLUMN_POLICYNO:  policy.PolicyNo,
      COLUMN_PREMIUM:  policy.Premium,
      COLUMN_PRODUCT:  policy.Product,
      COLUMN_STATUS:  policy.Status
    };

    return contentValues;
  }

  void insertPolicies(List<Policy> polices) async {
    polices.forEach((policy) async {
      Map<String, dynamic> row = toPolicyMap( policy);
      final id = await DatabaseHelper.instance.insert(PolicyORM.TABLE_NAME, row);
      print('inserted row id: $id');
    });
  }


  Future<List<Policy>> getPolicies() async {
    Policy policy ;
    List<Policy>  policies= <Policy>[];
    List<Map<String, dynamic>> rows =
        await DatabaseHelper.instance.queryAllRows(PolicyORM.TABLE_NAME);
    rows.forEach((row) {
      policy = cursorToPost(row);
      policies.add(policy);
      print('get Policies row policy:'+ policy.toString());
    });
    return policies;
  }
    Policy cursorToPost(Map<String, dynamic> row) {
    Policy policy = new Policy();
     policy.ExpireDate=row[COLUMN_EXPIRYDATE];
    policy.Description=row[COLUMN_DESC];
      policy.Glob=row[COLUMN_GLOB];
      policy.Lob=row[COLUMN_LOB];
      policy.PolicyNo=row[COLUMN_POLICYNO];
      policy.Premium=row[COLUMN_PREMIUM];
      policy.Product=row[COLUMN_PRODUCT];
      policy.Status=row[COLUMN_STATUS];
    return policy;
  }
  void clearPolicies() async {
    await DatabaseHelper.instance.delete(PolicyORM.TABLE_NAME);
  }

}
