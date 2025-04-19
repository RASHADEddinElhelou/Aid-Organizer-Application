import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/sqldb.dart';

class FirestoreService {
    Sqldb sqldb = Sqldb();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
// String aidType;
//   final String date;
//   final String area;
//   final String fundingentity;
//   final String numbers;
//   final String nots;
  Future<void> addUser(String aidType, String date, String area,
      String fundingentity, String numbers, String nots,) async {
    await _db.collection('Aid').add({
      'aidType': aidType,
      'date': date,
      'area': area,
      'fundingentity': fundingentity,
      'numbers': numbers,
      'nots': nots,
    });
  }


   Future<List<Map<String, dynamic>>> getItems() async {
    final snapshot = await _db.collection('Aid').get();
       List<Map<String, dynamic>> items =snapshot.docs.map((doc) => doc.data()).toList();
       print(items);
        for (var aid in items) {
        // // تأكد من أن كل مستند يحتوي على معرّف (ID) فريد
        // aid['id'] = snapshot.docs.firstWhere((doc) => doc.data() == aid).id;
      sqldb.insertOrUpdateAid(aid);
     
      //     sqldb.insertData(
      //     "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('${aid['aidType']}','${aid['area']}',${aid['numbers']},'${aid['fundingentity']}', '${aid['date']}','${aid['nots']}') ");
      // ;
  }
         return items;

  }

//قيد المراجعة
    // قراءة جميع الوثائق من مجموعة "Aid"
  //  Stream<List<Map<String, dynamic>>> getAidData() {
  //   return _db.collection('Aid').snapshots().asyncMap((snapshot) async {
  //     // تحويل البيانات إلى قائمة من الخرائط
  //     List<Map<String, dynamic>> aids = snapshot.docs
  //         .map((doc) => doc.data() as Map<String, dynamic>)
  //         .toList();
  //        print(aids);

  // //     // إضافة البيانات إلى قاعدة البيانات المحلية
  // //     for (var aid in aids) {
  // //       // تأكد من أن كل مستند يحتوي على معرّف (ID) فريد
  // //       aid['id'] = snapshot.docs.firstWhere((doc) => doc.data() == aid).id;
  // //         sqldb.insertData(
  // //         "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('${aid['aidtype']}','${aid['area']}',${aid['number']},'${aid['fundingentity']}', '${aid['date']}','${aid['nots']}') ");
  // //     ;
  // //     }
  // //  print(aids);
  //     return aids;
  //   });
  }

 

