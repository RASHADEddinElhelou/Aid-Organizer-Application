import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/FirestoreService%20.dart';
import 'package:flutter_application_2/item.dart';
import 'package:flutter_application_2/sqldb.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
class Itemspage extends StatefulWidget {
  const Itemspage({super.key});
  

    @override
  State<StatefulWidget> createState() => Mypage();
  }
  
class Mypage extends State<Itemspage>{
  Sqldb sqldb = Sqldb();

    FirestoreService firestoreService = FirestoreService();

@override
  void initState() {
   
    super.initState();
         
 _uploadLocalData();
 // firestoreService.getItems();


  }

  
void dispose() {
  super .dispose();

}

  Future<void> _uploadLocalData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      List<Map<String, dynamic>> localdata =
          await sqldb.readData('SELECT * FROM  ''Aid'' ');
      for (var data in localdata) {
        try {
          firestoreService.addUser(data['aidtype'], data['date'], data['area'],
              data['fundingentity'], data['numbers'].toString(), data['nots']);

          await sqldb.deleteItem(data['id']);
        } catch (e) {
          print('Failed to upload local data: $e');
        }
       // print(localdata);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    List<String> listerea = [
      'الرمال ',
      'الرضوان',
      'الشمالي ',
      'الجنوبي',
      'المشروع',
      'مركزي',
      'جهات أخرى'
    ];

    return Directionality(
        textDirection: TextDirection.rtl,
        
        child : AnimationLimiter(child: 
         GridView.builder(
          
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0,
          ),
          itemCount: listerea.length,
          itemBuilder: (context, index) {
                                        final String item = listerea[index];

             return AnimationConfiguration.staggeredList(
            position: index,
            duration:  Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
         
             
                
          
            
             child:   Card(
  elevation: 2, // تأثير الظل
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  margin: const EdgeInsets.all(8.0), // تباعد بين البطاقات
  child: InkWell(
    borderRadius: BorderRadius.circular(20), 
    onTap: () {        
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Items(receivedText: item),
        ),
      );
    },
    child: Stack(
      children: [
        // صورة خلفية
        ClipRRect(
          borderRadius: BorderRadius.circular(20), // مطابقة حواف الكارد
          child: Image.asset(
            // 'assets/images/${item.toLowerCase()}.jpg',
            // // تحميل الصورة حسب اسم المكان
             'images/map.png',
            fit: BoxFit.contain, // تغطية المساحة بالكامل
            width: double.infinity,
            height: 170, // تحديد ارتفاع الصورة
          ),
        ),

        // تراكب لون شفاف لتحسين وضوح النص
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.3), // طبقة شفافة
          ),
        ),

        // نص في الوسط
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110),
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22, // خط أكبر
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 5, color: Colors.black), // ظل خفيف للنص
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)



)));

           


          },
        )),);
  }
  

}
