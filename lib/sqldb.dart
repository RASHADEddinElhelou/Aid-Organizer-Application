import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "Baraa.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    //للتعديل على الداتا وبدكاش تفقد البيانات

    print("onUpgrade===================");
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
         CREATE TABLE Aid (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  aidtype TEXT NOT NULL,
  area TEXT NOT NULL,
  number INTEGER NOT NULL,
  fundingentity TEXT NOT NULL,
  date TEXT NOT NULL,
  nots TEXT NOT NULL,
  FOREIGN KEY (aidtype) REFERENCES AidType(aidtype),
  FOREIGN KEY (fundingentity) REFERENCES fundingentitytype(fundingentity)

         
         )
       
     
      ''');

    await db.execute('''
         CREATE TABLE AidType (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  aidtype TEXT NOT NULL
  

         
         )
       
       
     
      ''');

    await db.execute('''
      CREATE TABLE fundingentitytype (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  fundingentity TEXT NOT NULL
  

         
         )
       
     
      ''');

    print("oncreat===================");

    print("CreatDataBase");
  }






  Future<List<Map<String, dynamic>>> getCategoriesWithCounts2(
      String startDate, String endDate) async {
    final d = await db;
    return await d!.rawQuery('''
    SELECT aidtype, COUNT(*) as count
    FROM Aid
    WHERE date BETWEEN ? AND ?
    GROUP BY aidtype
    ORDER BY count DESC
  ''', [startDate, endDate]);
  }

  Future<List<Map<String, dynamic>>> getCategoriesWithCounts(
      String startDate, String endDate) async {
    final d = await db;
    return await d!.rawQuery('''
    SELECT fundingentity, COUNT(*) as count
    FROM Aid
    WHERE date BETWEEN ? AND ?
    GROUP BY fundingentity
    ORDER BY count DESC
  ''', [startDate, endDate]);
  }


Future<void> insertOrUpdateAid(Map<String, dynamic> aid) async {
  final d = await db;

  // تحقق مما إذا كان السجل موجودًا بالفعل بناءً على 'number'
  final existingAid = await d!.query(
    'Aid',
    where: 'id = ?',
    whereArgs: [aid['id']],
  );

  // if (existingAid.isEmpty) {
    // السجل غير موجود، قم بالإدراج
    await d.insert(
      'Aid',
      {
        'aidtype': aid['aidType'],
        'area': aid['area'],
        'number': aid['numbers'],
        'fundingentity': aid['fundingentity'],
        'date': aid['date'],
        'nots': aid['nots'],
      

      
      },
          conflictAlgorithm: ConflictAlgorithm.replace,

    );
  //   // السجل موجود، قم بتحديثه
  //   await d.update(
  //     'Aid',
  //     {
  //       'aidtype': aid['aidType'],
  //       'area': aid['area'],
  //       'fundingentity': aid['fundingentity'],
  //       'date': aid['date'],
  //       'nots': aid['nots'],
  //     },
  //     where: 'id = ?',
  //     whereArgs: [aid['id']],
  //   );
  // }

}




  Future<List<Map<String, dynamic>>> getEventsByCategory2(
      String startDate, String endDate, String category) async {
    final d = await db;
    return await d!.query(
      'Aid',
      where: 'date BETWEEN ? AND ? AND aidtype = ?',
      whereArgs: [startDate, endDate, category],
      orderBy: 'date ASC', // فرز النتائج حسب التاريخ من الأصغر إلى الأكبر
    );
  }

  Future<List<Map<String, dynamic>>> getEventsByCategory(
      String startDate, String endDate, String category) async {
    final d = await db;
    return await d!.query(
      'Aid',
      where: 'date BETWEEN ? AND ? AND fundingentity = ?',
      whereArgs: [startDate, endDate, category],
      orderBy: 'date ASC', // فرز النتائج حسب التاريخ من الأصغر إلى الأكبر
    );
  }

  Future<List<Map<String, dynamic>>> getEventsBetweenDatesAndCategory(
      String startDate, String endDate, String category) async {
    final d = await db;
    return await d!.query(
      'Aid',
      where: 'date BETWEEN ? AND ? AND fundingentity = ?',
      whereArgs: [startDate, endDate, category],
    );
  }

  Future<int> getTotalAmountBetweenDates(
      String startDate, String endDate) async {
    final d = await db;
    final result = await d!.rawQuery(
      'SELECT SUM(number) AS total FROM Aid WHERE date BETWEEN ? AND ?',
      [startDate, endDate],
    );
    return result.first['total'] as int? ?? 0;
  }

  Future<int> getTotalAmount() async {
    final d = await db;
    final result = await d!.rawQuery('SELECT SUM(number) AS total FROM Aid');
    return result.first['total'] as int? ?? 0;
  }

  Future<List<Map<String, dynamic>>> getEventsBetweenDates(
      String startDate, String endDate) async {
    final d = await db;
    return await d!.query(
      'Aid',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
    );
  }

  //  readData(String sql) async{
  //  Database? mydb = await db ;
  //  List<Map> response = await mydb!.rawQuery(sql);
  //  return response ;

  //  }

  Future<void> updateUserAndRelatedOrders(
      int userId, String newUserName, String oldname) async {
    Database? d = await db;

    // تحديث بيانات المستخدم
    await d!.update(
      'AidType',
      {'aidtype': newUserName},
      where: '${'id'} = ?',
      whereArgs: [userId],
    );

    // تحديث الطلبات المرتبطة بهذا المستخدم
    await d.update(
      'Aid',
      {'aidtype': newUserName}, // قم بتحديث ما تحتاجه بناءً على التعديلات
      where: '${'aidtype'} = ?',
      whereArgs: [oldname],
    );
  }

  Future<void> updateUserAndRelatedOrders2(
      int userId, String newUserName, String oldname) async {
    Database? d = await db;

    // تحديث بيانات المستخدم
    await d!.update(
      'fundingentitytype',
      {'fundingentity': newUserName},
      where: '${'id'} = ?',
      whereArgs: [userId],
    );

    // تحديث الطلبات المرتبطة بهذا المستخدم
    await d.update(
      'Aid',
      {'fundingentity': newUserName}, // قم بتحديث ما تحتاجه بناءً على التعديلات
      where: '${'fundingentity'} = ?',
      whereArgs: [oldname],
    );
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    final Database? d = await db;

    try {
      // تنفيذ الاستعلام واسترجاع البيانات
      List<Map<String, dynamic>> response = await d!.rawQuery(sql);

      // التأكد من أن البيانات تم تحويلها إلى النوع المناسب
      return response;
    } catch (e) {
      print('Error executing query: $e');
      return [];
    }
  }

//      CREATE TABLE AidKid (
//   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//   aidtype TEXT NOT NULL

//          )

//           CREATE TABLE fundingentity (
//   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// fundingentity TEXT NOT NULL

//          )

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deletData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<void> deleteItem(int id) async {
    final d = await db;
    await d?.delete(
      'Aid',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
//  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//   aidtype TEXT NOT NULL,
//   area TEXT NOT NULL,
//   number INTEGER NOT NULL,
//   fundingentity TEXT NOT NULL,
//   date TEXT NOT NULL,
//   nots

  Future<int?> updateItem1(int id, String aidType, String date, String area,
      String fundingentity, String number, String nots) async {
    final d = await db;
    return await d!.update(
      'Aid',
      {
        'aidtype': aidType,
        'area': area,
        'number': number,
        'fundingentity': fundingentity,
        'date': date,
        'nots': nots,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateItem(
    int id, {
    required String aidType,
    // required String date,
    // required String area,
    // required String fundingentity,
    // required int number,
    // required String nots,
  }) async {
    final d = await db; // تأكد من وجود هذه الدالة لفتح قاعدة البيانات
    await d?.update(
      'AidType', // اسم الجدول
      {
        'aidtype': aidType,
        // 'date': date,
        // 'area': area,
        // 'fundingentity': fundingentity,
        // 'number': number,
        // 'nots': nots,
      },
      where: 'id = ?', // الشرط لتحديد السجل المراد تحديثه
      whereArgs: [id], // قيم المعلمات
    );
  }

  Future<List<Map<String, dynamic>>> queryItems(String searchText) async {
    final d = await db;
    return await d!.query(
      'Aid',
      where: 'area LIKE ?',
      whereArgs: ['%$searchText%'],
      orderBy: 'date ASC', // فرز النتائج حسب التاريخ من الأصغر إلى الأكبر
    );
  }
}
