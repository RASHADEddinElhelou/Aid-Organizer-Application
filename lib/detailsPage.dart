import 'package:flutter/material.dart';
import 'package:flutter_application_2/item.dart';

class DetailsPage extends StatelessWidget {
  final String aidType;
  final String date;
  final String area;
  final String fundingentity;
  final String numbers;
  final String nots;

  const DetailsPage(
      {super.key,
      required this.aidType,
      required this.date,
      required this.area,
      required this.fundingentity,
      required this.numbers,
      required this.nots});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: const Align(
          alignment: Alignment.centerRight, // محاذاة العنوان لليمين
          child: Text("التفاصيل",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textDirection: TextDirection.rtl),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoText('نوع المساعدة:', aidType),
              const SizedBox(height: 10),
              _buildInfoText('التاريخ:', date),
              const SizedBox(height: 10),
              _buildInfoText('المنطقة:', area),
              const SizedBox(height: 10),
              _buildInfoText('الجهة الممولة:', fundingentity),
              const SizedBox(height: 10),
              _buildInfoText('العدد:', numbers),
              const SizedBox(height: 10),
              _buildInfoText('الملاحظات:', nots),
              const SizedBox(
                height: 30,
              ),
              //  ElevatedButton(
              //             //    onPressed: _fetchEvents,
              //             style: ElevatedButton.styleFrom(
              //                 minimumSize: Size(double.infinity, 40),
              //                 backgroundColor:
              //                     Colors.teal // يحدد العرض ليأخذ المساحة الكاملة
              //                 ),
              //             onPressed: (){

              //          //   Navigator.push(context, MaterialPageRoute(builder: (context) => Items(receivedText: area)));

              //             },

              //  for(int i =0; i<= _events.length;i++){
              //     print(   _events);

              //  }

              //   child: Text(
              //     ' تم',
              //     style: TextStyle(color: Colors.white, fontSize: 17),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$label $value',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
