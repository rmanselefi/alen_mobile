import 'package:alen/models/ads.dart';
import 'package:alen/models/diagnostic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';

class AdsProvider with ChangeNotifier {
  List<Ads> ads = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<Ads>> fetchAllAds() async {
    isLoading = true;
    ads.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('ads').get();
      if (docs.docs.isNotEmpty) {
        if (ads.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Ads hos = Ads(
              id: docs.docs[i].id,
              image: data['image'],
            );
            ads.add(hos);
          }
        }
      }
      return ads;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }
}
