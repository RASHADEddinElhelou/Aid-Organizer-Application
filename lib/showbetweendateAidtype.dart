import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/EditPage.dart';
import 'package:flutter_application_2/detailsPage.dart';
import 'package:flutter_application_2/sqldb.dart';

class MyshowbwteendateAidtype extends StatefulWidget {
  // final String receivedText;

  final String endDate;

  final String fundmony;

  final String startDate;

  const MyshowbwteendateAidtype(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.fundmony});

  @override
  State<StatefulWidget> createState() => Myshow();
}

class Myshow extends State<MyshowbwteendateAidtype> {
  Timer? _timer;
  late Future<List<Map<String, dynamic>>> _eventsFuture;
  bool _dataLoaded = false; // متغير لتتبع حالة تحميل البيانات

  Sqldb sqldb = Sqldb();

  @override
  void initState() {
    super.initState();
    _eventsFuture = sqldb.getEventsByCategory2(
        widget.startDate, widget.endDate, widget.fundmony);
    _dataLoaded = true; // تعيين حالة تحميل البيانات إلى صحيح

    // _timer = Timer(const Duration(seconds: 5), () {
    //   if (mounted) {
    //     setState(() {
    //       // تنفيذ التحديث هنا
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _timer?.cancel(); // إلغاء المؤقت عند التخلص من الواجهة
    super.dispose();
  }

  // void _updateData() async {
  //   // قم بتحديث البيانات هنا

  //   // بعد تحديث البيانات، أعد فتح الصفحة السابقة
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Items(receivedText: widget.receivedText),
  //     ),
  //   );
  // }

  // loaddata() async {
  //   Sqldb().queryItems(widget.receivedText);
  // }

  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: Align(
          alignment: Alignment.centerRight, // محاذاة العنوان لليمين
          child: Text(widget.fundmony,
              style: const TextStyle(color: Colors.white, fontSize: 25),
              textDirection: TextDirection.rtl),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Mydelegate(items));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _dataLoaded
          ? FutureBuilder<List<Map<String, dynamic>>>(
              future: _eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No results found.'));
                } else {
                  items = snapshot.data!;
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        String a1 = items[index]['aidtype'];
                        String a2 = items[index]['date']!;
                        String a3 = items[index]['area'];
                        String a4 = items[index]['fundingentity'];
                        String a5 = items[index]['number'].toString();
                        String a6 = items[index]['nots'];
                        int itemId = items[index]
                            ['id']; // Assuming 'id' is the unique identifier

                        return

                            // Dismissible(
                            //   key: Key(itemId
                            //       .toString()), // Unique key for the Dismissible widget
                            //   direction: DismissDirection.horizontal,
                            //   onDismissed: (direction) async {
                            //     if (direction == DismissDirection.startToEnd) {
                            //       // Edit action

                            //       final updatedDetails =
                            //           await Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => EditPage(
                            //             aidType: a1,
                            //             date: a2,
                            //             area: a3,
                            //             fundingentity: a4,
                            //             numbers: a5,
                            //             nots: a6,
                            //             itemId: itemId,

                            //             // Pass the ID to the edit page
                            //           ),
                            //         ),
                            //         // (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
                            //       );

                            //       // تحقق من النتيجة وقم بتحديث التفاصيل
                            //       if (mounted && updatedDetails != null) {
                            //         setState(() {
                            //           items = updatedDetails;
                            //         });
                            //       }

                            //       print(a1);
                            //     } else if (direction == DismissDirection.endToStart) {
                            //       showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return Directionality(
                            //               textDirection: TextDirection.rtl,
                            //               child: AlertDialog(
                            //                 title: const Text('حذف البيانات'),
                            //                 content: const Text(
                            //                     'هل تريد بالتأكيد حذف البيانات'),
                            //                 actions: <Widget>[
                            //                   TextButton(
                            //                     child: const Text('موافق'),
                            //                     onPressed: () async {
                            //                       //  //   _updateData();

                            //                       // Delete action
                            //                       await Sqldb().deleteItem(
                            //                           itemId); // Assuming you have a method to delete item by ID
                            //                       ScaffoldMessenger.of(context)
                            //                           .showSnackBar(
                            //                         const SnackBar(
                            //                           content: Text('تم حذف العنصر '),
                            //                         ),
                            //                       );
                            //                       // Handle the confirm action
                            //                       // ignore: use_build_context_synchronously
                            //                       Navigator.of(context).pop(true);
                            //                     },
                            //                   ),
                            //                   TextButton(
                            //                     child: const Text('إلغاء'),
                            //                     onPressed: () {
                            //                       Navigator.of(context).pop(false);

                            //                       setState(() {
                            //                         //  _updateData();
                            //                       });
                            //                     },
                            //                   ),
                            //                 ],
                            //               ));
                            //         },
                            //       );
                            //     }
                            //   },
                            //   background: Container(
                            //     color: Colors
                            //         .blue, // Color for the edit action (when swiping right)
                            //     child: const Align(
                            //       alignment: Alignment.centerRight,
                            //       child: Padding(
                            //         padding: EdgeInsets.all(16.0),
                            //         child: Icon(Icons.edit, color: Colors.white),
                            //       ),
                            //     ),
                            //   ),
                            //   secondaryBackground: Container(
                            //     color: Colors
                            //         .red, // Color for the delete action (when swiping left)
                            //     child: const Align(
                            //       alignment: Alignment.centerLeft,
                            //       child: Padding(
                            //         padding: EdgeInsets.all(16.0),
                            //         child: Icon(Icons.delete, color: Colors.white),
                            //       ),
                            //     ),
                            //   ),
                            Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              a1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                              a2,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            isThreeLine: true,
                            leading: CircleAvatar(
                              child: Text(
                                a5, // Convert number to string
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.teal),
                              ),
                            ),
                            trailing: Text(a3),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    aidType: a1,
                                    date: a2,
                                    area: a3,
                                    fundingentity: a4,
                                    numbers: a5,
                                    nots: a6,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                        // );
                      },
                    ),
                  );
                }
              },
            )
          : Center(child: Text('لا يوجد نتائج حتى الأن')),
    );
  }
}

class Mydelegate extends SearchDelegate {
  var items;
  var listfiltter = [];
  Mydelegate(this.items);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            String a1 = items[index]['aidtype'];
            String a2 = items[index]['date']!;
            String a3 = items[index]['area'];
            String a4 = items[index]['fundingentity'];
            String a5 = items[index]['number'].toString();
            String a6 = items[index]['nots'];
            int itemId =
                items[index]['id']; // Assuming 'id' is the unique identifier

            return Dismissible(
              key: Key(
                  itemId.toString()), // Unique key for the Dismissible widget
              direction: DismissDirection.horizontal,
              onDismissed: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // Edit action

                  final updatedDetails = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        aidType: a1,
                        date: a2,
                        area: a3,
                        fundingentity: a4,
                        numbers: a5,
                        nots: a6,
                        itemId: itemId,

                        // Pass the ID to the edit page
                      ),
                    ),
                    // (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
                  );

                  //      // تحقق من النتيجة وقم بتحديث التفاصيل
                  // if (mounted && updatedDetails != null) {
                  //   setState(() {
                  //     items = updatedDetails;
                  //   });
                  // }

                  print(a1);
                } else if (direction == DismissDirection.endToStart) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: const Text('حذف البيانات'),
                            content:
                                const Text('هل تريد بالتأكيد حذف البيانات'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('موافق'),
                                onPressed: () async {
                                  //  //   _updateData();

                                  // Delete action
                                  await Sqldb().deleteItem(
                                      itemId); // Assuming you have a method to delete item by ID
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم حذف العنصر '),
                                    ),
                                  );
                                  // Handle the confirm action
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                  child: const Text('إلغاء'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);

                                    // setState(() {
                                    // //  _updateData();
                                    // });},
                                  }),
                            ],
                          ));
                    },
                  );
                }
              },
              background: Container(
                color: Colors
                    .blue, // Color for the edit action (when swiping right)
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors
                    .red, // Color for the delete action (when swiping left)
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    a1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    a2,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text(
                      a5, // Convert number to string
                      style: const TextStyle(fontSize: 18, color: Colors.teal),
                    ),
                  ),
                  trailing: Text(a4),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          aidType: a1,
                          date: a2,
                          area: a3,
                          fundingentity: a4,
                          numbers: a5,
                          nots: a6,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    } else {
      listfiltter =
          items.where((e) => (e['aidtype'] as String).contains(query)).toList();
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: listfiltter.length,
          itemBuilder: (context, index) {
            String a1 = listfiltter[index]['aidtype'];
            String a2 = listfiltter[index]['date']!;
            String a3 = listfiltter[index]['area'];
            String a4 = listfiltter[index]['fundingentity'];
            String a5 = listfiltter[index]['number'].toString();
            String a6 = listfiltter[index]['nots'];
            int itemId = listfiltter[index]
                ['id']; // Assuming 'id' is the unique identifier

            return Dismissible(
              key: Key(
                  itemId.toString()), // Unique key for the Dismissible widget
              direction: DismissDirection.horizontal,
              onDismissed: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // Edit action

                  final updatedDetails = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        aidType: a1,
                        date: a2,
                        area: a3,
                        fundingentity: a4,
                        numbers: a5,
                        nots: a6,
                        itemId: itemId,

                        // Pass the ID to the edit page
                      ),
                    ),
                    // (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
                  );

                  //      // تحقق من النتيجة وقم بتحديث التفاصيل
                  // if (mounted && updatedDetails != null) {
                  //   setState(() {
                  //     items = updatedDetails;
                  //   });
                  // }

                  print(a1);
                } else if (direction == DismissDirection.endToStart) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: const Text('حذف البيانات'),
                            content:
                                const Text('هل تريد بالتأكيد حذف البيانات'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('موافق'),
                                onPressed: () async {
                                  //  //   _updateData();

                                  // Delete action
                                  await Sqldb().deleteItem(
                                      itemId); // Assuming you have a method to delete item by ID
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم حذف العنصر '),
                                    ),
                                  );
                                  // Handle the confirm action
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                  child: const Text('إلغاء'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);

                                    // setState(() {
                                    // //  _updateData();
                                    // });},
                                  }),
                            ],
                          ));
                    },
                  );
                }
              },
              background: Container(
                color: Colors
                    .blue, // Color for the edit action (when swiping right)
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors
                    .red, // Color for the delete action (when swiping left)
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    a1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    a2,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text(
                      a5, // Convert number to string
                      style: const TextStyle(fontSize: 18, color: Colors.teal),
                    ),
                  ),
                  trailing: Text(a4),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          aidType: a1,
                          date: a2,
                          area: a3,
                          fundingentity: a4,
                          numbers: a5,
                          nots: a6,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
