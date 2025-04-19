import 'package:flutter/material.dart';
import 'package:flutter_application_2/GetDataBtweenDate/getAidtype.dart';
import 'package:flutter_application_2/GetDataBtweenDate/getdatabydata.dart';
import 'package:flutter_application_2/GetDataBtweenDate/getfundmony.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/test.dart';
import 'package:flutter_application_2/Typ/type.dart';
import 'package:flutter_application_2/Typ/typetow.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/firstpage.dart';
import 'package:flutter_application_2/itemspage.dart';
import 'package:flutter_application_2/socundpage.dart';
import 'text_provider.dart'; // استيراد نموذج البيانات
import 'package:firebase_core/firebase_core.dart';

   Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized (); 

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    ChangeNotifierProvider(
        create: (context) => TextProvider(), // إنشاء مثيل من TextProvider
        child: const MyApp()),
  );

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:
//
//
// ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: Colors.deepPurple, // اللون الأساسي للتصميم
//     primary: Colors.deepPurple.shade600, // اللون الأساسي للزرار والأشياء الرئيسية
//     onPrimary: Colors.white, // اللون النصي فوق اللون الأساسي
//     secondary: Colors.teal, // اللون الثانوي للعناصر الأخرى
//     onSecondary: Colors.white, // اللون النصي فوق اللون الثانوي
//     background: Colors.white, // خلفية التطبيق
//     onBackground: Colors.black, // اللون النصي فوق الخلفية
//     surface: Colors.deepPurple.shade50, // لون سطح العناصر مثل بطاقات الكارد
//     onSurface: Colors.black, // اللون النصي فوق الأسطح
//     error: Colors.redAccent, // لون الخطأ
//     onError: Colors.white, // اللون النصي فوق لون الخطأ
//   ),
//   useMaterial3: true,
//   fontFamily: "PlayfairDisplay", // تحديد خط النص
//   textTheme: TextTheme(
//     displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade900),
//     displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
//     displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade600),
//     bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
//     bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
//     labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
//     bodySmall: TextStyle(fontSize: 12.0, color: Colors.grey),
//   ),
//   buttonTheme: ButtonThemeData(
//     buttonColor: Colors.deepPurple.shade600, // لون أزرار التطبيق
//     textTheme: ButtonTextTheme.primary, // نص الأزرار بلون الأساس
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.deepPurple.shade700, // لون شريط العنوان
//     foregroundColor: Colors.white, // لون النص على شريط العنوان
//     elevation: 4, // ارتفاع شريط العنوان
//   ),
//   cardTheme: CardTheme(
//     color: Colors.white, // لون بطاقات الكارد
//     shadowColor: Colors.black.withOpacity(0.2), // لون ظل الكارد
//     elevation: 4, // ارتفاع ظل الكارد
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12), // تدوير زوايا الكارد
//     ),
//   ),
//   dividerTheme: DividerThemeData(
//     color: Colors.deepPurple.shade100, // لون الخط الفاصل
//     thickness: 1.5, // سمك الخط الفاصل
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12), // تدوير زوايا الحقول
//       borderSide: BorderSide(color: Colors.teal), // لون حدود الحقول
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12), // تدوير زوايا الحقول عند التركيز
//       borderSide: BorderSide(color: Colors.teal), // لون حدود الحقول عند التركيز
//     ),
//     labelStyle: TextStyle(color: Colors.teal), // لون النص في حقول الإدخال
//   ),
// ),

          ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: "PlayfairDisplay"),
      home: const MyHomePage(title: 'تطبيق البراء  '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 2;
  List<Widget> widgets = const [Socundpage(), Firstpage(), Itemspage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        endDrawer: Drawer(
            child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      color: Colors.teal,
                    ),
                    const Positioned(
                        right: 10,
                        bottom: 10,
                        child: Text(
                          "تطبيق البراء ",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      // Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyWidget()));
                    },
                    title: const Text("الصفحة الرئيسية"),
                    leading: const Icon(
                      Icons.home,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TypeScreen()));
                    },
                    title: const Text(" عرض تصنيفات المساعدات"),
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TypeScreen2()));
                    },
                    title: const Text(" عرض تصنيفات الجهة الممولة"),
                    leading: const Icon(
                      Icons.hotel_class_sharp,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Getdatabydata()));
                    },
                    title: const Text(" عرض تقرير"),
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyGetfundmony()));
                    },
                    title: const Text("عرض تقرير الجهة الممولة"),
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context); // إغلاق الـ Drawer عند النقر
                      // يمكنك تنفيذ إجراء آخر هنا
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyGetAidtype()));
                    },
                    title: const Text("عرض تقرير نوع المساعدة"),
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: Container(
  decoration: BoxDecoration(
    color: Colors.teal,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        spreadRadius: 2,
        offset: const Offset(0, -3), // ظل للأعلى ليعطي تأثير عائم
      ),
    ],
  ),
  child: BottomNavigationBar(
    elevation: 0, // إزالة التأثير الافتراضي لتنسيق أفضل
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.category_rounded, size: 30), // أيقونة التصنيفات
        label: "إضافة تصنيفات ",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle, size: 30), // أيقونة المساعدات
        label: "إضافة ",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map_rounded, size: 30), // أيقونة المواقع أو المناطق
        label: "المناطق",
      ),
    ],
    currentIndex: selectedIndex,
    backgroundColor: Colors.transparent, // ينسجم مع لون الحاوية الخارجية
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70, // لون خافت للعناصر غير المحددة
    selectedFontSize: 14,
    unselectedFontSize: 12,
    type: BottomNavigationBarType.fixed,
    onTap: (value) {
      setState(() {
        selectedIndex = value;
      });
    },
  ),
),


        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: Align(
            alignment: Alignment.centerRight, // محاذاة العنوان لليمين
            child: Text(widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl),
          ),
        ),
        body: widgets.elementAt(selectedIndex));
  }
}
