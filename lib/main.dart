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


          ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: "PlayfairDisplay"),
      home: const MyHomePage(title: 'Aid-Organizer-Application  '),
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
                          "Aid-Organizer-Application ",
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
                      Navigator.pop(context);
                    
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
                      Navigator.pop(context);
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
        offset: const Offset(0, -3), 
      ),
    ],
  ),
  child: BottomNavigationBar(
    elevation: 0, 
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
    backgroundColor: Colors.transparent, 
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
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
            alignment: Alignment.centerRight, 
            child: Text(widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 25),
                textDirection: TextDirection.rtl),
          ),
        ),
        body: widgets.elementAt(selectedIndex));
  }
}
