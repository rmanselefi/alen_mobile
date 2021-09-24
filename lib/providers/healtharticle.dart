import 'package:alen/models/healtharticle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_location.dart';

class HealthArticleProvider with ChangeNotifier {
  List<HealthArticles> healtharticles = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<HealthArticles>> fetchHealthArticles() async {
    isLoading = true;
    healtharticles.clear();
    var curr;
    try {
      var docs =
          await FirebaseFirestore.instance.collection('healtharticle').get();
      if (docs.docs.isNotEmpty) {
        if (healtharticles.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final HealthArticles hos = HealthArticles(
                Id: docs.docs[i].id,
                link: data['link'],
                image: data['image'],);
            int temp = 0;
            if(healtharticles.length==0){
              healtharticles.add(hos);
            }else{
              healtharticles.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                healtharticles.add(hos);
              }
            }
          }
        }
      }
      return healtharticles;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }
}
