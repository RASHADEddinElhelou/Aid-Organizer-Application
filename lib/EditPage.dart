import 'package:flutter/material.dart';
import 'package:flutter_application_2/detailsPage.dart';
import 'package:flutter_application_2/item.dart';
import 'package:flutter_application_2/sqldb.dart';

class EditPage extends StatefulWidget {
  final String aidType;
  final String date;
  final String area;
  final String fundingentity;
  final String numbers;
  final String nots;
  final int itemId;

  const EditPage({
    super.key,
    required this.aidType,
    required this.date,
    required this.area,
    required this.fundingentity,
    required this.numbers,
    required this.nots,
    required this.itemId,
  });

  @override
  State<StatefulWidget> createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  Sqldb sqldb = Sqldb();

  late Future<List<String>> _dropdownItemsFuture;
  late Future<List<String>> _dropdownItemsFuture2;

  @override
  void initState() {
    super.initState();

    _dropdownItemsFuture = _loadAidTypes();
    _dropdownItemsFuture2 = _loadfundingentityTypes();
    setState(() {});

    ereaChosse = widget.area;
    if (_aidTypes.contains(widget.aidType)) {
      valueChosse = widget.aidType;
    } else {
      print("لا يساوي يا متخلف");

      print(_aidTypes);
    }
    // Initialize the selected value if it exists in the items list

    // This ensures that the initialization happens after the widget has been built

    // setState(() {
    //       _currentaidType = widget.aidType;
//     valueChosse =  widget.aidType;
// setState(() {
//       valueChosse =  widget.aidType;

// });
    // ereaChosse = widget.area;

    // _currentdate = widget.date;

    // WherMony = widget.fundingentity;

    // _currentnumbers = widget.numbers ;
    // _currentnots = widget.nots;

    _controller.text = widget.numbers;

    _controller2.text = widget.nots;

    _dateController.text = widget.date;

    // });
  }

  void _updateData() async {
    // قم بتحديث البيانات هنا

    // بعد تحديث البيانات، أعد فتح الصفحة السابقة
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => Items(receivedText: ereaChosse!),
      ),
    );
  }

  String? _currentaidType; // القيمة الحالية التي ستظهر في القائمة المنسدلة
  String? _currentdate; // القيمة الحالية التي ستظهر في القائمة المنسدلة
  String? _currentarea; // القيمة الحالية التي ستظهر في القائمة المنسدلة
  String?
      _currentfundingentity; // القيمة الحالية التي ستظهر في القائمة المنسدلة
  String? _currentnumbers; // القيمة الحالية التي ستظهر في القائمة المنسدلة
  String? _currentnots; // القيمة الحالية التي ستظهر في القائمة المنسدلة

  String? date;

  int? number;
  String? aidtype;
  String? area;
  String? fundingentity;
  String? nots;
  GlobalKey<FormState> keyform = GlobalKey();

  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format date
        date = _dateController.text;
      });
    }
  }

  String? valueChosse; //نوع المساعدة

  //
  //
  List<String>? listoption1;

  String? _selectedAidType;

  Future<List<String>> _loadAidTypes() async {
    List<Map<String, dynamic>> data =
        await sqldb.readData("SELECT aidtype FROM  'AidType'");
    setState(() {
      _aidTypes = data.map((row) => row['aidtype'] as String).toList();
    });
    return _aidTypes;
  }

  List<String> _aidTypes = ["خيار إفتراضي"];

  List<String> _fundingentityTypes = ["خيار إفتراضي"];

  Future<List<String>> _loadfundingentityTypes() async {
    List<Map<String, dynamic>> data =
        await sqldb.readData("SELECT fundingentity FROM  'fundingentitytype'");
    setState(() {
      _fundingentityTypes =
          data.map((row) => row['fundingentity'] as String).toList();
    });
    return _fundingentityTypes;
  }

  String? ereaChosse;
  List<String> listerea = [
   'الرمال ',
    'الرضوان',
    'الشمالي ',
    'الجنوبي',
    'المشروع',
    'مركزي',
    'جهات أخرى'
  ];

  String? WherMony;

  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    // final texts = Provider.of<TextProvider>(context).texts; // الحصول على النصوص من TextProvider

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: const Align(
            alignment: Alignment.centerRight, // محاذاة العنوان لليمين
            child: Text("تعديل",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl),
          ),
        ),
        body: FutureBuilder<List<String>>(
            future: _dropdownItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // عرض مؤشر تحميل أثناء تحميل البيانات
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // عرض رسالة خطأ إذا حدث خطأ في تحميل البيانات
                return const Center(child: Text('خطأ في تحميل البيانات'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // عرض رسالة إذا كانت القائمة فارغة
                return const Center(child: Text('لا توجد بيانات'));
              }
              final dropdownItems = snapshot.data!;
              if (valueChosse == null && dropdownItems.isNotEmpty) {
                valueChosse = widget.aidType;
                // تأكد من تطابق القيمة المحددة مع القيم الموجودة في القائمة
                if (valueChosse!.isNotEmpty &&
                    !dropdownItems.contains(valueChosse)) {
                  valueChosse = dropdownItems[0];
                }
              }

              return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: keyform,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          // _aidTypes.isEmpty
                          //           ?

                          //            CircularProgressIndicator() :
                          DropdownButtonFormField<String>(
                            onTap: () {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "أدخل نوع المساعدة ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            hint: const Text("أدخل نوع المساعدة "),
                            value: valueChosse,
                            icon: const Icon(Icons.menu_open),
                            items: dropdownItems.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList(),
                            onSaved: (newValue) {
                              setState(() {
                                aidtype = newValue;
                              });
                            },
                            onChanged: (String? newvalue) {
                              setState(() {
                                valueChosse = newvalue!;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "أدخل المنطقة",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            hint: const Text("أدخل المنطقة"),
                            value: ereaChosse,
                            icon: const Icon(Icons.menu),
                            items: listerea.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                    textAlign: TextAlign.right,
                                  ));
                            }).toList(),
                            onSaved: (newValue) {
                              setState(() {
                                area = newValue;
                              });
                            },
                            onChanged: (String? newvalue) {
                              setState(() {
                                ereaChosse = newvalue!;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: " أدخل العدد",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelStyle: const TextStyle(),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right, // محاذاة النص لليمين
                            // textDirection: TextDirection.ltr,
                            onSaved: (val) {
                              setState(() {
                                number = num.parse(val!) as int?;
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //      Text(
                          //   'اختر تاريخ:',
                          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          // ),
                          TextFormField(
                            controller: _dateController,
                            readOnly: true, // Make the field read-only
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'أدخل التاريخ ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: _selectDate,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          FutureBuilder<List<String>>(
                              future: _dropdownItemsFuture2,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text(
                                          'خطأ في تحميل البيانات للقائمة الثانية'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'لا توجد بيانات للقائمة الثانية'));
                                }

                                final dropdownItems2 = snapshot.data!;
                                if (WherMony == null &&
                                    dropdownItems2.isNotEmpty) {
                                  WherMony = widget.fundingentity;
                                  if (WherMony != null &&
                                      !dropdownItems2.contains(WherMony)) {
                                    WherMony = dropdownItems2[0];
                                  }
                                }

                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "أدخل الجهة الممولة ",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                  hint: const Text("أدخل الجهة الممولة "),
                                  value: WherMony,
                                  icon: const Icon(Icons.menu),
                                  items: dropdownItems2.map((valueItem) {
                                    return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem));
                                  }).toList(),
                                  onSaved: (newValue) {
                                    setState(() {
                                      fundingentity = newValue;
                                    });
                                  },
                                  onChanged: (String? newvalue) {
                                    setState(() {
                                      WherMony = newvalue!;
                                    });
                                  },
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _controller2,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: " ملاحظات  ",
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(),
                              ),

                              onSaved: (newValue) {
                                setState(() {
                                  nots = newValue;
                                });
                              },
                              maxLines: 4,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.right, // محاذاة النص لليمين
                              // textDirection: TextDirection.ltr,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    height: 50,
                                    color: Colors.teal,
                                    onPressed: () async {
                                      keyform.currentState!.save();
                                      String a1 = widget.aidType;
                                      String a2 = widget.area;
                                      String a3 = widget.numbers;
                                      String a4 = widget.fundingentity;
                                      String a5 = widget.date;
                                      String a6 = widget.nots;
                                      int a7 = widget.itemId;

// مرجعة
                                      sqldb.updateItem1(
                                          a7,
                                          valueChosse!,
                                          _dateController.text,
                                          ereaChosse!,
                                          WherMony!,
                                          _controller.text,
                                          _controller2.text);

                                      //  Navigator.pop(context);
                                      //   Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                                      //      builder: (context) => DetailsPage(aidType: valueChosse!, date: _dateController.text, area: ereaChosse!, fundingentity: WherMony!, numbers: _controller.text, nots: _controller2.text)),(route) => false,);
                                      //                        //     (Route<dynamic> route) => false, // إزالة جميع المسارات السابقة
//);
                                      _updateData();

                                      // print(t);
                                      // print("$aidtype :::  $date ::: $fundingentity ::: $nots :::  $area ::::  $number");
                                      //       _controller.clear();
                                      //    _controller2.clear();
                                      //  valueChosse = null;
                                      // ereaChosse =null;
                                      //  WherMony = null;
                                      //  _dateController.clear();

                                      //   Navigator.of(context).pop();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'تم بحديث البيانات بنجاح')),
                                      );
                                    },
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0)),

                                    child: const Text(
                                      "  تحديث التقرير",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Itemspage()));
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //          MaterialButton(onPressed: () async{

                          //  List<String>  res =  await sqldb.readData("SELECT * FROM  'AidType'");

                          //       //    listoption1 = res.cast<String>();
                          //        print("$res");

                          //          },child: Text("عرض "),)
                        ],
                      ),
                    ),
                  ));
            }));
  }
}

// Text(widget.aidType),
//  Text('Edit Page - Item ID: $widget.aidType'),
//   Text('Edit Page - Item ID: $widget.date'),
//    Text('Edit Page - Item ID: $widget.area'),
//    Text('Edit Page - Item ID: $widget.fundingentity'),
//    Text('Edit Page - Item ID: $widget.numbers'),
//    Text('Edit Page - Item ID: $widget.nots'),
