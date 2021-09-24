import 'package:alen/models/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_location.dart';

class AdsProvider with ChangeNotifier {
  List<Ads> smallAds = [];
  List<Ads> mainAds = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<Ads>> fetchSmallAds() async {
    isLoading = true;
    smallAds.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('ads').where('is_main_ad', isEqualTo: false).get();
      if (docs.docs.isNotEmpty) {
        if (smallAds.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Ads hos = Ads(
                Id: docs.docs[i].id,
                title: data['title'],
                image: data['image'],
                description: data['description'],
              size: Size.Small
            );
            int temp2 = 0;
            if(smallAds.length==0){
              smallAds.add(hos);
            }else{
              smallAds.forEach((element) {
                if(hos.title==element.title)
                {
                  temp2++;
                }
              });
              if(temp2==0){
                smallAds.add(hos);
              }
            }
          }
        }
      }
      return smallAds;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Ads>> fetchMainAds() async {
    isLoading = true;
    mainAds.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('ads').where('is_main_ad', isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (mainAds.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Ads hos = Ads(
                Id: docs.docs[i].id,
                title: data['title'],
                image: data['image'],
                description: data['description'],
                size: Size.Main
            );
            int temp2 = 0;
            if(mainAds.length==0){
              mainAds.add(hos);
            }else{
              mainAds.forEach((element) {
                if(hos.title==element.title)
                {
                  temp2++;
                }
              });
              if(temp2==0){
                mainAds.add(hos);
              }
            }
          }
        }
      }
      return mainAds;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }
}
