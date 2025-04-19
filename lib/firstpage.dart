import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/FirestoreService%20.dart';
import 'package:flutter_application_2/itemspage.dart';
import 'package:flutter_application_2/socundpage.dart';
import 'package:flutter_application_2/sqldb.dart';
import 'package:flutter_application_2/text_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});
  // Firstpag({super.key});

  @override
  State<Firstpage> createState() => MyHomePageState();
}

class MyHomePageState extends State<Firstpage> {
  Sqldb sqldb = Sqldb();

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

  final _controllero = TextEditingController();
  final _controller1 = TextEditingController();
  final _controller22 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _controller5 = TextEditingController();
  final _controller6 = TextEditingController();
  final _controller7 = TextEditingController();

  FirestoreService firestoreService = FirestoreService();

// void _addUser() {
//   firestoreService.addUser( 'John Doe2', 'john.doe@example.com2');
// }

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

  List<String> _aidTypes = ["خيار إفتراضي"];
  String? _selectedAidType;

  @override
  void initState() {
    super.initState();
    _loadAidTypes();
    _loadfundingentityTypes();
    // _uploadLocalData();
  }

  void _loadAidTypes() async {
    List<Map<String, dynamic>> data =
        await sqldb.readData("SELECT aidtype FROM  'AidType'");
    setState(() {
      _aidTypes = data.map((row) => row['aidtype'] as String).toList();
    });
  }

  List<String> _fundingentityTypes = ["خيار إفتراضي"];

  void _loadfundingentityTypes() async {
    List<Map<String, dynamic>> data =
        await sqldb.readData("SELECT fundingentity FROM  'fundingentitytype'");
    setState(() {
      _fundingentityTypes =
          data.map((row) => row['fundingentity'] as String).toList();
    });
  }

  List<String> listoption = [
    'كيس طحين 25 كيلو',
    'سقيا ماء',
    'ربطة خبز بلدي',
    'فتة حمص',
    'مشروع طاقة شمسية ',
    'تشغيل محطة تحلية',
    'تركيب غاطس مياه',
    'حليب أطفال',
    'ربطة خبز آلي',
    ' مساعدة نقدية 200 شيكل',
    'دست طبيخ ',
    'بامبرز أطفال',
    'تمر و عسل ريقان',
    'طرد غذائي',
    ' طرد صحي',
    'وجبة أرز فردية',
    '  وجبة أرز بالخضار فردية',
    'تركيب غاطس مياه',
    ' بامبرز كبار',
    '  تطوير مشروع طاقة شمسية',
    ' كفالة أيتام 150 ش',
    ' مساعدة نقدية لمركز التحفيظ 100ش',
    ' توزيع جالونات ماء',
    ' وجبة أرز ولحم',
    '  إنشاء محطة طاقة شمسية',
    ' طرد غذائي ريقان ',
    '   كرتونة بيض  ',
    'افتتاح نقطة طبية',
    '  مساعدة نقدية للمعاقين 300 شيكل',
    '  وجبة معجنات',
    '    دست أرز',
    ' أرز 3 كيلو',
    '   كسوة أطفال',
    'رفع الآذان',
    'كرتونة بسكوت 200 حبة',
    'مساعدة نقدية 350 ش',
    'طرد مواد تنظيف لمراكز الإيواء',
    'إنشاء مخبز بلدي',
    'كفالة محفظين 71 دولار',
    'لتر زيت ووقية زعتر',
    'مساعدة نقدية 300 ش',
    'تعزيل شبكات الصرف الصحي',
    'وجبة مفتول فردية',
    'وجبة أرز زوجية',
    'طرد الفيتامينات',
    'كسوة عائلة يتيم',
    'حرامات للأيتام',
  ];

//  void _addText(String text) {
//     setState(() {
//       listoption.add(text);
//     });
//   }

//   Future<void> _openInputPage() async {
//     final String? newText = await Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => Socundpage()),
//     );
//     if (newText != null && newText.isNotEmpty) {
//       _addText(newText);
//     }
//   }

  // void _openDropdownPage() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => DropdownPage(texts: _texts),
  //     ),
  //   );
  // }

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
  List<String> listWherMony = [
    'فاعل خير ',
    'المؤسسات',
    'الهيئة العربية للإعادة إعمار غزة ',
    'جمعية الأعمال الخيرية',
    'جمعية السلام',
    'الرحمة الكويتية',
    'الخير',
    'غزة تستحق الحياة ',
    ' الإدارة العامة للزكاة ',
    ' الإسناد',
    ' الوفاق',
    'البلعاوي',
    'رواد',
    'محبي غزة',
    'مؤسسة سبيلي',
    'الإغاثة',
    'البركة',
  ];

  int selectedIndex = 1;

  final bool _isCecked1 = false;
  bool valuee = false;
  bool valuee2 = false;

  bool valuee3 = false;
  bool valuee4 = false;
  bool valuee5 = false;
  bool valuee6 = false;
  bool valuee7 = false;

  @override
  Widget build(BuildContext context) {
    final texts = Provider.of<TextProvider>(context)
        .texts; // الحصول على النصوص من TextProvider

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: keyform,
                child: AnimationLimiter(
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
                      children: [
                        const SizedBox(height: 15),
                        // _aidTypes.isEmpty
                        //           ?

                        //            CircularProgressIndicator() :
                     DropdownButtonFormField<String>(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال نوع المساعدة';
    }
    return null;
  },
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white, // الخلفية البيضاء
    labelText: 'أدخل نوع المساعدة', // النص الذي يظهر أعلى الحقل
    labelStyle: TextStyle(
      color: Colors.teal, // لون النص الخاص بالتسمية
      fontWeight: FontWeight.bold, // جعل النص عريض
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف بشكل أكبر
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.5)), // حدود الحقل بلون أخضر خفيف
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف عند التحديد
      borderSide: BorderSide(color: Colors.teal, width: 2), // لون الحدود عندما يكون الحقل في التركيز
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)), // حدود خفيفة عندما يكون الحقل غير مفعّل
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // زيادة التباعد داخل الحقل
  ),
  hint: const Text(
    "أدخل نوع المساعدة", // النص الافتراضي
    style: TextStyle(color: Colors.grey), // لون النص الافتراضي
  ),
  value: valueChosse, // القيمة المحددة حاليًا
  icon: const Icon(
    Icons.arrow_drop_down, // أيقونة السحب للأسفل
    color: Colors.teal, // لون الأيقونة
  ),
  isExpanded: true, // تمديد الحقل ليأخذ العرض الكامل
  items: _aidTypes.map((valueItem) {
    return DropdownMenuItem(
      value: valueItem, 
      child: Text(valueItem, style: TextStyle(fontSize: 16)),
    );
  }).toList(),
  onSaved: (newValue) {
    setState(() {
      aidtype = newValue; // حفظ القيمة المحددة
    });
  },
  onChanged: (String? newValue) {
    setState(() {
      valueChosse = newValue!; // تحديث القيمة المحددة
    });
  },
),

                        const SizedBox(
                          height: 20,
                        ),

//  const SizedBox(
//                   height: 20,
//                 ),

                        //      Text(
                        //   'اختر تاريخ:',
                        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        // ),
                       TextFormField(
  validator: (value) {
    if (value!.isEmpty) {
      return 'الرجاء إدخال التاريخ';
    }
    return null; // يمكنك إضافة التحقق الإضافي إذا لزم الأمر
  },
  controller: _dateController,
  readOnly: true, // جعل الحقل للقراءة فقط
  decoration: InputDecoration(
    filled: true, // الخلفية ملونة
    fillColor: Colors.white, // الخلفية بيضاء
    labelText: 'أدخل التاريخ', // نص التسمية
    labelStyle: TextStyle(
      color: Colors.teal, // تغيير لون التسمية
      fontWeight: FontWeight.bold, // جعل النص عريضًا
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف بشكل أكبر
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.5)), // حدود خفيفة بلون أخضر
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف عند التركيز
      borderSide: BorderSide(color: Colors.teal, width: 2), // تحديد الحدود عند التركيز
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف عند التمكين
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)), // حدود خفيفة عندما يكون الحقل غير مفعّل
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد داخل الحقل
    suffixIcon: IconButton(
      icon: const Icon(
        Icons.calendar_today, // أيقونة اختيار التاريخ
        color: Colors.teal, // لون الأيقونة
      ),
      onPressed: _selectDate, // التابع لفتح نافذة اختيار التاريخ
    ),
  ),
  onTap: () {
    // يمكنك إضافة الكود هنا لفتح نافذة التاريخ عند النقر
    _selectDate();
  },
),


                        const SizedBox(
                          height: 20,
                        ),
DropdownButtonFormField<String>(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال الجهة الممولة';
    }
    return null; // يمكنك إضافة التحقق الإضافي إذا لزم الأمر
  },
  decoration: InputDecoration(
    filled: true, // الخلفية ملونة
    fillColor: Colors.white, // اللون الأبيض للخلفية
    labelText: 'أدخل الجهة الممولة', // تسمية الحقل
    labelStyle: TextStyle(
      color: Colors.teal, // لون التسمية
      fontWeight: FontWeight.bold, // جعل النص عريضًا
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.5)), // حدود خفيفة بلون أخضر
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف عند التركيز
      borderSide: BorderSide(color: Colors.teal, width: 2), // حدود أخضر عند التركيز
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // تدوير الحواف عند التمكين
      borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)), // حدود خفيفة عند التمكين
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // التباعد داخل الحقل
  ),
  hint: const Text("أدخل الجهة الممولة"), // النص التوضيحي
  value: WherMony, // قيمة الحقل
  icon: const Icon(
    Icons.arrow_drop_down, // أيقونة القائمة المنسدلة
    color: Colors.teal, // لون الأيقونة
  ),
  items: _fundingentityTypes.map((valueItem) {
    return DropdownMenuItem(
      value: valueItem,
      child: Text(
        valueItem,
        style: TextStyle(
          color: Colors.teal, // لون النص داخل القائمة
        ),
      ),
    );
  }).toList(),
  onSaved: (newValue) {
    setState(() {
      fundingentity = newValue;
    });
  },
  onChanged: (String? newValue) {
    setState(() {
      WherMony = newValue!; // تحديث القيمة
    });
  },
),


// Directionality(textDirection: TextDirection.rtl, child:

                        //  ),
                        // DropdownButtonFormField<String>(
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'الرجاء إدخال المنطقة';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   //         validator: (value) {
                        //   //   if (value!.isEmpty) {
                        //   //     return 'الرجاء إدخال المنطقة';
                        //   //   }
                        //   //   // Add additional email validation logic here
                        //   //   return null;
                        //   // },

                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       labelText: "أدخل المنطقة",
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8.0))),
                        //   hint: const Text("أدخل المنطقة"),
                        //   value: ereaChosse,
                        //   icon: const Icon(Icons.menu),
                        //   items: listerea.map((valueItem) {
                        //     return DropdownMenuItem(
                        //         value: valueItem,
                        //         child: Text(
                        //           valueItem,
                        //           textAlign: TextAlign.right,
                        //         ));
                        //   }).toList(),

                        //   onSaved: (newValue) {
                        //     setState(() {
                        //       area = newValue;
                        //     });
                        //   },

                        //   onChanged: (String? newvalue) {
                        //     setState(() {
                        //       ereaChosse = newvalue!;
                        //     });
                        //   },
                        // ),

                        // const SizedBox(
                        //   height: 15,
                        // ),

                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "اختر المنطقة وأدخل العدد",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[0],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controllero,
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee2,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee2 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[1],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller1,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee2, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee3,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee3 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[2],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller22,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee3, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee4,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee4 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[3],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller3,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee4, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee5,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee5 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[4],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller4,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee5, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee6,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee6 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[5],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller5,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee6, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5.0),
                                          leading: Checkbox(
                                            value: valuee7,
                                            onChanged: (val) {
                                              setState(() {
                                                valuee7 = val ?? false;
                                              });
                                            },
                                          ),
                                          title: Text(
                                            listerea[6],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _controller6,

                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'الرجاء إدخال العدد';
                                          //   }
                                          //   // Add additional validation logic here
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            labelText: "أدخل العدد",
                                            labelStyle: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 8.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .right, // محاذاة النص لليمين
                                          enabled:
                                              valuee7, // تفعيل أو تعطيل الحقل بناءً على قيمة الـ Checkbox
                                          onSaved: (val) {
                                            setState(() {
                                              // number = num.parse(val!) as int?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // TextFormField(
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'الرجاء إدخال العدد';
                        //     }
                        //     // Add additional email validation logic here
                        //     return null;
                        //   },
                        //   controller: _controller,
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     labelText: " أدخل العدد",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //     labelStyle: const TextStyle(),
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   textAlign: TextAlign.right, // محاذاة النص لليمين
                        //   // textDirection: TextDirection.ltr,
                        //   onSaved: (val) {
                        //     setState(() {
                        //       number = num.parse(val!) as int?;
                        //     });
                        //   },
                        // ),

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
                                    _handleSave();
                                    // if (keyform.currentState!.validate()) {
                                    //   keyform.currentState!.save();

                                    // final connectivityResult = await Connectivity().checkConnectivity();
                                    // if (connectivityResult == ConnectivityResult.none) {
                                    //   // No internet, store locally
                                    //   // Here, you can save data locally if needed or show a message
                                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    //       content: Text(
                                    //           'No internet connection. Data will be uploaded when online.')));
                                    //    _storeLocally();
                                    // } else {
                                    //   // Internet is available, upload data to Firestore
                                    //    _uploadData();
                                    // }

// _uploadData();
                                    // if (valuee == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[0]}',${_controllero.text},'$fundingentity', '$date','$nots') ");

                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[0],
                                    //       fundingentity!,
                                    //       _controllero.text,
                                    //       nots!);

                                    //   // addUser( aidtype!,listerea[0],_controllero.text);
                                    // }

                                    // if (valuee2 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[1]}',${_controller1.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[1],
                                    //       fundingentity!,
                                    //       _controller1.text,
                                    //       nots!);
                                    // }
                                    // if (valuee3 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[2]}',${_controller22.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[2],
                                    //       fundingentity!,
                                    //       _controller22.text,
                                    //       nots!);
                                    // }

                                    // if (valuee4 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[3]}',${_controller3.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[3],
                                    //       fundingentity!,
                                    //       _controller3.text,
                                    //       nots!);
                                    // }

                                    // if (valuee5 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[4]}',${_controller4.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[4],
                                    //       fundingentity!,
                                    //       _controller4.text,
                                    //       nots!);
                                    // }

                                    // if (valuee6 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[5]}',${_controller5.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[5],
                                    //       fundingentity!,
                                    //       _controller5.text,
                                    //       nots!);
                                    // }
                                    // if (valuee7 == true) {
                                    //   sqldb.insertData(
                                    //       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[6]}',${_controller6.text},'$fundingentity', '$date','$nots') ");
                                    //   firestoreService.addUser(
                                    //       aidtype!,
                                    //       date!,
                                    //       listerea[6],
                                    //       fundingentity!,
                                    //       _controller6.text,
                                    //       nots!);
                                    // }

                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(
                                    //   const SnackBar(
                                    //       content: Text(
                                    //           'تم إضافة البيانات بنجاح')),
                                    // );
                                  },
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(22.0)),

                                  child: const Text(
                                    "  إضافة التقرير",
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
                ))));
  }

  Future<void> _handleSave() async {
    if (keyform.currentState!.validate()) {
      keyform.currentState!.save();

      List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      print('Connectivity result: $connectivityResult');

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // No internet, store locally

        _storeLocally();
      } else if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        // Internet is available, upload data to Firestore

        _uploadData();
      } else {
        // Handle other cases if needed
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected connectivity result')));
      }
    }
  }

  Future<void> _storeLocally() async {
    // Here, you can implement local storage logic (e.g., using SQLite)
    // This example simply shows a snackbar

    print(valuee);
    if (valuee == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[0]}',${_controllero.text},'$fundingentity', '$date','$nots') ");

      // addUser( aidtype!,listerea[0],_controllero.text);
    }

    if (valuee2 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[1]}',${_controller1.text},'$fundingentity', '$date','$nots') ");
    }
    if (valuee3 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[2]}',${_controller22.text},'$fundingentity', '$date','$nots') ");
      ;
    }

    if (valuee4 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[3]}',${_controller3.text},'$fundingentity', '$date','$nots') ");
    }

    if (valuee5 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[4]}',${_controller4.text},'$fundingentity', '$date','$nots') ");
    }

    if (valuee6 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[5]}',${_controller5.text},'$fundingentity', '$date','$nots') ");
    }
    if (valuee7 == true) {
      sqldb.insertData(
          "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','${listerea[6]}',${_controller6.text},'$fundingentity', '$date','$nots') ");
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('أنت غير متصل بالإنترنت تم تخزين البيانات محلياً')));

    valuee = false;
    valuee2 = false;
    valuee3 = false;
    valuee4 = false;
    valuee5 = false;
    valuee6 = false;
    valuee7 = false;

    _controllero.clear();
    _controller1.clear();
    _controller22.clear();
    _controller3.clear();
    _controller4.clear();
    _controller5.clear();
    _controller6.clear();
    _controller7.clear();

    //                   sqldb.insertData(
    //                       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','$area',$number,'$fundingentity', '$date','$nots') ");
    //                   print(
    //                       "$aidtype :::  $date ::: $fundingentity ::: $nots :::  $area ::::  $number");
    _controller.clear();
    _controller2.clear();
    valueChosse = null;
    ereaChosse = null;
    WherMony = null;
    _dateController.clear();
  }

  Future<void> _uploadData() async {
    try {
      if (valuee == true) {
        firestoreService.addUser(aidtype!, date!, listerea[0], fundingentity!,
            _controllero.text, nots!);

        // addUser( aidtype!,listerea[0],_controllero.text);
      }

      if (valuee2 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[1], fundingentity!,
            _controller1.text, nots!);
      }
      if (valuee3 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[2], fundingentity!,
            _controller22.text, nots!);
      }

      if (valuee4 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[3], fundingentity!,
            _controller3.text, nots!);
      }

      if (valuee5 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[4], fundingentity!,
            _controller4.text, nots!);
      }

      if (valuee6 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[5], fundingentity!,
            _controller5.text, nots!);
      }
      if (valuee7 == true) {
        firestoreService.addUser(aidtype!, date!, listerea[6], fundingentity!,
            _controller6.text, nots!);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('تم رفع البيانات بنجاح ')));
      valuee = false;
      valuee2 = false;
      valuee3 = false;
      valuee4 = false;
      valuee5 = false;
      valuee6 = false;
      valuee7 = false;

      _controllero.clear();
      _controller1.clear();
      _controller22.clear();
      _controller3.clear();
      _controller4.clear();
      _controller5.clear();
      _controller6.clear();
      _controller7.clear();

      //                   sqldb.insertData(
      //                       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','$area',$number,'$fundingentity', '$date','$nots') ");
      //                   print(
      //                       "$aidtype :::  $date ::: $fundingentity ::: $nots :::  $area ::::  $number");
      _controller.clear();
      _controller2.clear();
      valueChosse = null;
      ereaChosse = null;
      WherMony = null;
      _dateController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload data')));
      valuee = false;
      valuee2 = false;
      valuee3 = false;
      valuee4 = false;
      valuee5 = false;
      valuee6 = false;
      valuee7 = false;

      _controllero.clear();
      _controller1.clear();
      _controller22.clear();
      _controller3.clear();
      _controller4.clear();
      _controller5.clear();
      _controller6.clear();
      _controller7.clear();

      //                   sqldb.insertData(
      //                       "INSERT INTO 'Aid' ('aidtype','area','number','fundingentity','date','nots') VALUES ('$aidtype','$area',$number,'$fundingentity', '$date','$nots') ");
      //                   print(
      //                       "$aidtype :::  $date ::: $fundingentity ::: $nots :::  $area ::::  $number");
      _controller.clear();
      _controller2.clear();
      valueChosse = null;
      ereaChosse = null;
      WherMony = null;
      _dateController.clear();
    }
  }

  
}
