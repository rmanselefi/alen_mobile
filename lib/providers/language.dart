import 'package:alen/models/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_location.dart';

class LanguageProvider with ChangeNotifier {
  String langOPT = 'en';

  void changeLang(String lang){
    langOPT = lang;
    notifyListeners();
  }
}
