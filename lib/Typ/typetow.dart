import 'package:flutter/material.dart';
import 'package:flutter_application_2/sqldb.dart';
import 'package:flutter_application_2/Typ/type.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_2/firstpage.dart';
import 'package:flutter_application_2/itemspage.dart';
import 'package:flutter_application_2/socundpage.dart';
import '../text_provider.dart'; // استيراد نموذج البيانات
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class TypeScreen2 extends StatefulWidget {
  const TypeScreen2({super.key});

  @override
  State<StatefulWidget> createState() => MyTypeScreen();
}

class MyTypeScreen extends State<TypeScreen2> {
  Sqldb sqldb = Sqldb();

//List<String> _aidTypes = [];

  @override
  void initState() {
    super.initState();
    // _loadAidTypes();
    // _loadfundingentityTypes();
  }
//  void _loadfundingentityTypes() async {
//     List<Map<String, dynamic>> data = await sqldb.readData("SELECT fundingentity FROM  'fundingentitytype'");
//     setState(() {
//       _aidTypes = data.map((row) => row['fundingentity'] as String).toList();
//     });
//   }

// void _loadAidTypes() async {
//     List<Map<String, dynamic>> data = await sqldb.readData("SELECT aidtype FROM  'AidType'");
//     setState(() {
//       _aidTypes = data.map((row) => row['aidtype'] as String).toList();
//     });
//   }

  final String _itemText = 'نص العنصر'; // النص الذي سيتم عرضه وتعديله

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: const Align(
            alignment: Alignment.centerRight, // محاذاة العنوان لليمين
            child: Text("عرض التصنيفات",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl),
          ),
        ),

// floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.teal,
//           tooltip: 'Increment',
//           onPressed: (){
//             Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Socundpage()));

//           },
//           child: const Icon(Icons.add, color: Colors.white, size: 28),

//           ),

        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: Sqldb().readData("SELECT * FROM  'fundingentitytype'"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text('No results found.'));
              } else {
                final items = snapshot.data!;

                return Directionality(
                    textDirection: TextDirection.rtl,
                    child: AnimationLimiter(
      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          int a1 = items[index]['id'];
                          String a2 = items[index]['fundingentity']!;

                          print(items[index]['id']);

                          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child:Card(
                              elevation: 8.0, // ظل العنصر
                              margin: const EdgeInsets.all(
                                  16.0), // تباعد حول العنصر
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12.0), // حواف دائرية
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(24.0), // تباعد داخلي
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(children: [
                                    Expanded(
                                      child: Text(
                                        a2,
                                        style: const TextStyle(
                                          fontSize: 20.0, // حجم النص
                                          fontWeight:
                                              FontWeight.bold, // وزن النص
                                          color: Colors.black87, // لون النص
                                        ),
                                        textAlign:
                                            TextAlign.center, // محاذاة النص
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () => _showEditDialog(a2, a1),
                                    ),
                                  ]),
                                ),
                              )),
              ),
            ),
          );
                        })));
              }
            })
 
//   ListView.builder(itemBuilder: (context,index){
//     String a =_aidTypes[index];
//       // return  Card(child:Text("$a") ,);

// return
//  Card(
//       elevation: 8.0, // ظل العنصر
//       margin: EdgeInsets.all(16.0), // تباعد حول العنصر
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0), // حواف دائرية
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24.0), // تباعد داخلي
//         child:   Directionality(textDirection: TextDirection.rtl, child:   Row(
//           children:[

//             Expanded(child:   Text(
//             a,
//             style: TextStyle(
//               fontSize: 20.0, // حجم النص
//               fontWeight: FontWeight.bold, // وزن النص
//               color: Colors.black87, // لون النص
//             ),
//             textAlign: TextAlign.center, // محاذاة النص
//           ),),

//            IconButton(
//                     icon: Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () => _showEditDialog(index),
//                     ),

//           ]
//         ),
//       ),
//     ));

//   },
//   itemCount: _aidTypes.length,

//   ),

        //   appBar: AppBar(
        //     title: Text('Slidable List Example'),
        //   ),
        //   body: ListView.builder(
        //     // itemCount: 1, // عرض عنصر واحد فقط
        //     itemBuilder: (context, index) {
        //       return Slidable(
        //         key: ValueKey(index),
        //         startActionPane: ActionPane(
        //           motion: ScrollMotion(),
        //           children: [
        //             SlidableAction(
        //               onPressed: (context) {

        //                 showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('تعديل النص'),
        //       content: TextField(
        //         controller: _controller,
        //         decoration: InputDecoration(hintText: 'أدخل النص الجديد'),
        //       ),
        //       actions: <Widget>[
        //         TextButton(
        //           child: Text('إلغاء'),
        //           onPressed: () {
        //             Navigator.of(context).pop(); // إغلاق الحوار
        //           },
        //         ),
        //         TextButton(
        //           child: Text('حفظ'),
        //           onPressed: () {
        //             setState(() {
        //               _itemText = _controller.text; // تحديث النص
        //             });
        //             Navigator.of(context).pop(); // إغلاق الحوار
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
        //                 // إجراء التعديل
        //                 ScaffoldMessenger.of(context).showSnackBar(
        //                   SnackBar(content: Text('تم تعديل العنصر')),
        //                 );
        //               },
        //               backgroundColor: Colors.blue,
        //               foregroundColor: Colors.white,
        //               icon: Icons.edit,
        //               label: 'تعديل',
        //             ),
        //           ],
        //         ),
        //         child: ListTile(
        //           contentPadding: EdgeInsets.all(16),
        //           tileColor: Colors.grey[200],
        //           title: Text(

        //             '$_itemText',
        //             style: TextStyle(fontSize: 18),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        );
  }

  void _showEditDialog(String a1, int a) {
    final TextEditingController controller = TextEditingController(text: a1);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text('تعديل التصنيف'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'أدخل نص التعديل'),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () async {
                    await sqldb.updateUserAndRelatedOrders2(
                        a, controller.text, a1);

                    ///امر غريب
                    //   sqldb.updateItem(a1! , aidType: _controller.text);
                    // await sqldb.updateData('''
                    //  UPDATE fundingentitytype SET fundingentity = "${_controller.text}" WHERE id = ${a}

                    //   ''');
                    setState(() {
                      // _aidTypes[index] = _controller.text;
                      //  String a   = _controller.text;
                      // String a2 = _aidTypes[index];
                      //   sqldb.updateData("UPDATE AidType SET aidtype =  $a  WHERE   aidtype =  $a2 ");
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('تعديل'),
                ),
              ],
            ));
      },
    );
  }
}
