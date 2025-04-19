import 'package:flutter/material.dart';
import 'package:flutter_application_2/FirestoreService%20.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool valuee = false;
// FirestoreService firestoreService = FirestoreService();

// void _addUser() {
//   firestoreService.addUser( 'John Doe2', 'john.doe@example.com2');
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      leading: Checkbox(
                        value: valuee,
                        onChanged: (val) {
                          setState(() {
                            valuee = val ?? false;
                          });
                        },
                      ),
                      title: const Text("الرمال"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الرجاء إدخال العدد';
                          }
                          // Add additional validation logic here
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "أدخل العدد",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelStyle: const TextStyle(),
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right, // محاذاة النص لليمين
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
SizedBox(height: 20,),
                 MaterialButton(onPressed: (){
  
// _addUser();

                 },child: Text("adduser"),color: Colors.teal,)

            ],
          ),



        ));
  }
}
