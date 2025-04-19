import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firstpage.dart';
import 'package:flutter_application_2/sqldb.dart';
import 'package:provider/provider.dart';
import 'text_provider.dart'; // اس
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Socundpage extends StatefulWidget {
  const Socundpage({super.key});

  @override
  State<Socundpage> createState() => _MyHomePageState();
}

// ignore: non_constant_identifier_names
class _MyHomePageState extends State<Socundpage> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> keyform = GlobalKey();

  final TextEditingController _controllerAid = TextEditingController();
  final TextEditingController _controllerfund = TextEditingController();

  void _submitText() {
    final String itemAid = _controllerAid.text;
    if (itemAid.isNotEmpty) {
      Provider.of<TextProvider>(context, listen: false).addText(itemAid);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Firstpage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Directionality(
  textDirection: TextDirection.rtl,
  child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Form(
      key: keyform,
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
            // صورة في الأعلى مع تأثير
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage('images/clipboard.png'), // استبدل بالمسار الصحيح
                  fit: BoxFit.contain,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 8.0, color: Colors.black.withOpacity(0.5), offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 25),

            // حقل إدخال مسمى المساعدة
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال مسمى المساعدة';
                }
                return null;
              },
              controller: _controllerAid,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "أدخل مسمى المساعدة",
                labelStyle: TextStyle(color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              keyboardType: TextInputType.text,
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 20),

            // زر إضافة التصنيفات
            Center(
              child: MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: Colors.teal,
                onPressed: () {
                  String text = _controllerAid.text;
                  sqldb.insertData(
                    "INSERT INTO 'AidType' ('aidtype') VALUES ('$text') ",
                  );
                  _controllerAid.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إضافة تصنيف المساعدة بنجاح')),
                  );
                },
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "إضافة التصنيفات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // حقل إدخال اسم الجهة الممولة
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال اسم الجهة الممولة';
                }
                return null;
              },
              controller: _controllerfund,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "أدخل اسم الجهة الممولة",
                labelStyle: TextStyle(color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),

            const SizedBox(height: 20),

            // زر إضافة الجهة الممولة
            Center(
              child: MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: Colors.teal,
                onPressed: () {
                  String text = _controllerfund.text;
                  sqldb.insertData(
                    "INSERT INTO 'fundingentitytype' ('fundingentity') VALUES ('$text') ",
                  );
                  _controllerfund.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إضافة اسم الجهة بنجاح')),
                  );
                },
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "إضافة الجهة الممولة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  ),
)

            
            
            );
  }
}
