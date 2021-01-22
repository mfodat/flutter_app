import './branch.dart';
import 'branch.dart';
import 'database_helper.dart';


class BranchORM {
  static const String  COLUMN_ADDRESS = "address";
  static const String  COLUMN_ADDRESS_ARABIC = "address_ar";
  static const String  COLUMN_AREA = "area";
  static const String  COLUMN_AREA_ARABIC = "area_ar";
  static const String  COLUMN_CITY = "city";
  static const String  COLUMN_CITY_ARABIC = "city_ar";
  static const String  COLUMN_EMAIL = "email";
  static const String  COLUMN_FAX = "fax";
  static const String  COLUMN_LATITUDE = "Latitude";
  static const String  COLUMN_LONGITUDE = "Longitude";
  static const String  COLUMN_NAME = "name";
  static const String  COLUMN_NAME_ARABIC = "name_ar";
  static const String  COLUMN_TELEPHONE = "mobilenumber";
  static const String  COLUMN_TEXT_TYPE = "TEXT";
  static const String  COLUMN_TYPE = "type";
  static const String  COLUMN_WORKING_HOURS = "workhours";
  static const String  COLUMN_WORKING_HOURS_ARABIC = "workhours_ar";
  static const String  COMMA_SEP = ", ";
  static const String SQL_CREATE_TABLE = "CREATE TABLE Branch (address TEXT, address_ar TEXT, area TEXT, area_ar TEXT, city TEXT, city_ar TEXT, type TEXT, email TEXT, fax TEXT, Latitude TEXT, Longitude TEXT, mobilenumber TEXT, name TEXT, name_ar TEXT, workhours TEXT, workhours_ar TEXT)";
  static const String SQL_DROP_TABLE = "DROP TABLE IF EXISTS Branch";
  static const String  TABLE_NAME = "Branch";
  static const String  TAG = "BranchORM";


  Map<String, dynamic> toBranchMap(Branch branch ) {
    Map<String, dynamic> contentValues = {
      COLUMN_ADDRESS:  branch.address,
      COLUMN_ADDRESS_ARABIC:  branch.address_ar,
      COLUMN_AREA:  branch.area,
      COLUMN_AREA_ARABIC:  branch.area_ar,
      COLUMN_CITY:  branch.city,
      COLUMN_CITY_ARABIC:  branch.city_ar,
      COLUMN_FAX:  branch.fax,
      COLUMN_LATITUDE:  branch.latitude,
      COLUMN_LONGITUDE:  branch.longitude,
      COLUMN_TELEPHONE:  branch.mobilenumber,
      COLUMN_NAME:  branch.name,
      COLUMN_NAME_ARABIC:  branch.name_ar,
      COLUMN_WORKING_HOURS:  branch.workhours,
      COLUMN_WORKING_HOURS_ARABIC:  branch.workhours_ar,
      COLUMN_TYPE:  branch.type,
      COLUMN_EMAIL:  branch.email
    };

    return contentValues;
  }

  void insertBranches(List<Branch> branches) async {
    branches.forEach(( branch) async {
      Map<String, dynamic> row = toBranchMap( branch);
      final id = await DatabaseHelper.instance.insert(BranchORM.TABLE_NAME, row);
      print('inserted row id: $id');
    });
  }


  Future<List<Branch>> getBranches() async {
    Branch branch ;
    List<Branch>  branches= <Branch>[];
    List<Map<String, dynamic>> rows =
        await DatabaseHelper.instance.queryAllRows(BranchORM.TABLE_NAME);
    rows.forEach((row) {
      branch = cursorToPost(row);
      branches.add(branch);
      print('get  Branches row Branch:'+ branch.toString());
    });
    return branches;
  }
    Branch cursorToPost(Map<String, dynamic> row) {
    Branch branches = new Branch();
    branches.address=row[COLUMN_ADDRESS];
    branches.address_ar=row[COLUMN_ADDRESS_ARABIC];
    branches.area=row[COLUMN_AREA];
    branches.area_ar=row[COLUMN_AREA_ARABIC];
    branches.city=row[COLUMN_CITY];
    branches.city_ar=row[COLUMN_CITY_ARABIC];
    branches.type=row[COLUMN_TYPE];
    branches.email=row[COLUMN_EMAIL];
    branches.fax=row[COLUMN_FAX];
    branches.latitude=row[COLUMN_LATITUDE];
    branches.longitude=row[COLUMN_LONGITUDE];
    branches.mobilenumber=row[COLUMN_TELEPHONE];
    branches.name=row[COLUMN_NAME];
    branches.name_ar=row[COLUMN_NAME_ARABIC];
    branches.workhours=row[COLUMN_WORKING_HOURS];
    branches.workhours_ar=row[COLUMN_WORKING_HOURS_ARABIC];

    return branches;
  }
  void clearPolicies() async {
    await DatabaseHelper.instance.delete(BranchORM.TABLE_NAME);
  }

}
