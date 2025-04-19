import 'package:flutter/material.dart';
import 'package:flutter_application_2/EditPage.dart';
import 'package:flutter_application_2/detailsPage.dart';
import 'package:flutter_application_2/sqldb.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class Getdatabydata extends StatefulWidget {
  const Getdatabydata({super.key});

  @override
  State<StatefulWidget> createState() => MyGetdatabydata();
}

class MyGetdatabydata extends State<Getdatabydata> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;

  final TextEditingController _dateController1 = TextEditingController();
  final TextEditingController _dateController2 = TextEditingController();
  String? date1;
  String? date2;


      bool _dataLoaded = false; // متغير لتتبع حالة تحميل البيانات

  Future<void> _selectDate1() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        _selectedDate1 = picked;
        _dateController1.text =
            "${picked.toLocal()}".split(' ')[0]; // Format date
        date1 = _dateController1.text;
      });
    }
  }

  Future<void> _selectDate2() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
        _dateController2.text =
            "${picked.toLocal()}".split(' ')[0]; // Format date
        date2 = _dateController2.text;
      });
    }
  }

  List<Map<String, dynamic>> _events = [];
  final Sqldb _db = Sqldb();
  int _sum = 0;

  Future<void> _fetchEvents() async {
    final startDate = _dateController1.text;
    final endDate = _dateController2.text;
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      final events = await _db.getEventsBetweenDates(startDate, endDate);
      final sum = await _db.getTotalAmountBetweenDates(startDate, endDate);
            _dataLoaded = true; // تعيين حالة تحميل البيانات إلى صحيح

      setState(() {
        _events = events;

        _sum = sum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: const Align(
            alignment: Alignment.centerRight, // محاذاة العنوان لليمين
            child: Text("عرض تقرير",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl),
          ),
        ),
        body: 
        SingleChildScrollView(child: 
        
        Padding(
        padding: const EdgeInsets.all(15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: <Widget>[
              Text(
                'اختر التواريخ:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الرجاء إدخال التاريخ';
                          }
                          return null;
                        },
                        controller: _dateController1,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'التاريخ الأول',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: _selectDate1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الرجاء إدخال التاريخ';
                          }
                          return null;
                        },
                        controller: _dateController2,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'التاريخ الثاني',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: _selectDate2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

                    const SizedBox(height: 12),
                    ElevatedButton(
                      //    onPressed: _fetchEvents,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          backgroundColor:
                              Colors.teal // يحدد العرض ليأخذ المساحة الكاملة
                          ),
                      onPressed: _fetchEvents,

                      //  for(int i =0; i<= _events.length;i++){
                      //     print(   _events);

                      //  }

                      child: const Text(
                        'عرض الأحداث',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),

                    //  MaterialButton(onPressed: () { print("$date1 :::::::::: $date2"); },)

                    // ignore: avoid_print
                    // if(date1!.isNotEmpty && date2!.isNotEmpty) {    },

                    SizedBox(
                      height: 400,
                      child:
                      
                       _dataLoaded
                ? 
                      AnimationLimiter(
      child:  ListView(
                        children: _events.map((event) {
                          print(event['number'].toString());
                         return AnimationConfiguration.staggeredList(
            position: event['id'],
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child:  Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                event['aidtype'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Text(
                                event['date'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              isThreeLine: true,
                              leading: CircleAvatar(
                                child: Text(
                                  event['number']
                                      .toString(), // Convert number to string
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.teal),
                                ),
                              ),
                              trailing: Text(
                                  "${event['fundingentity']} \n ${event['area']}"),

                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => DetailsPage(
                              //         aidType: a1,
                              //         date: a2,
                              //         area: a3,
                              //         fundingentity: a4,
                              //         numbers: a5,
                              //         nots: a6,
                              //       ),
                              //     ),
                              //   );
                              // },
                            ),
                          ),
              ),
            ),
          );

                          //  ListTile(
                          //   title: Text(event['aidtype'] ?? 'لا وصف'),
                          //   subtitle: Text(event['date'] ?? 'لا تاريخ'),
                          // );
                        }).toList(),
                      )):Center(child: Text('لا يوجد نتائج حتى الأن')) ,

//         FutureBuilder<List<Map<String, dynamic>>>(
//     future: Sqldb().readData("SELECT * FROM  'Aid'"),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//         return const Center(child: Text('No results found.'));
//       } else {
//         final items = snapshot.data!;
//       return Directionality(
//         textDirection: TextDirection.rtl,
//         child: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             String a1 = items[index]['aidtype'];
//             String a2 = items[index]['date']!;
//             String a3 = items[index]['area'];
//             String a4 = items[index]['fundingentity'];
//             String a5 = items[index]['number'].toString();
//             String a6 = items[index]['nots'];
//             int itemId = items[index]['id']; // Assuming 'id' is the unique identifier

//             return Dismissible(
//               key: Key(itemId.toString()), // Unique key for the Dismissible widget
//               direction: DismissDirection.horizontal,
//               onDismissed: (direction) async {
//                 if (direction == DismissDirection.startToEnd) {
//                   // Edit action
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditPage(
//                         aidType: a1,
//                         date: a2,
//                         area: a3,
//                         fundingentity: a4,
//                         numbers: a5,
//                         nots: a6,
//                         itemId: itemId,

//                         // Pass the ID to the edit page
//                       ),
//                     ),
//                   );

//                print(a1);

//                 } else if (direction == DismissDirection.endToStart) {
//                   // Delete action
//                   await Sqldb().deleteItem(itemId); // Assuming you have a method to delete item by ID
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('تم حذف العنصر '),
//                     ),
//                   );
//                 }
//               },
//               background: Container(
//                 color: Colors.blue, // Color for the edit action (when swiping right)
//                 child: const Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Icon(Icons.edit, color: Colors.white),
//                   ),
//                 ),
//               ),
//               secondaryBackground: Container(

//                 color: Colors.red, // Color for the delete action (when swiping left)
//                 child: const Align(

//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Icon(Icons.delete, color: Colors.white),
//                   ),
//                 ),
//               ),
//               child: Card(
//                 elevation: 5,
//                 margin: const EdgeInsets.all(10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     a1,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   subtitle: Text(
//                     a2,
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                   isThreeLine: true,
//                   leading: CircleAvatar(
//                     child: Text(
//                       a5, // Convert number to string
//                       style: const TextStyle(fontSize: 18, color: Colors.teal),
//                     ),
//                   ),
//                   trailing: Text(a4),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailsPage(
//                           aidType: a1,
//                           date: a2,
//                           area: a3,
//                           fundingentity: a4,
//                           numbers: a5,
//                           nots: a6,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//   },
// ),)
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // خلفية خفيفة
                        borderRadius: BorderRadius.circular(8), // حواف دائرية
                        border: Border.all(
                            color: Colors.teal, width: 1), // حدود ملونة
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.teal,
                            size: 24,
                          ),
                          const SizedBox(
                              width: 8), // المسافة بين الأيقونة والنص
                          const Expanded(
                            child: Text(
                              'عدد المستفيدين مباشر:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // المسافة بين النص والرقم
                          Text(
                            '$_sum ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // خلفية خفيفة
                        borderRadius: BorderRadius.circular(8), // حواف دائرية
                        border: Border.all(
                            color: Colors.teal, width: 1), // حدود ملونة
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.teal,
                            size: 24,
                          ),
                          const SizedBox(
                              width: 8), // المسافة بين الأيقونة والنص
                          const Expanded(
                            child: Text(
                              'عدد غير مباشر:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // المسافة بين النص والرقم
                          Text(
                            '${_sum * 5} ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],)
                ))))));
  }
}
