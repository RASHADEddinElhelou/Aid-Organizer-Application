import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  final List<String> _texts = []; // قائمة لتخزين النصوص

  List<String> get texts => _texts;

  void addText(String text) {
    _texts.add(text);
    notifyListeners(); // إخطار المستمعين بتحديث الحالة
  }
}
