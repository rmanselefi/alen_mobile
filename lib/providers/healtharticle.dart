import 'package:alen/models/healtharticle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_location.dart';

class HealthArticleProvider with ChangeNotifier {
  List<HealthArticles> healtharticles = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<HealthArticles>> fetchNearByHospitals() async {
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
                title: data['title'],
                image: data['image'],
                description: data['description']);
            healtharticles.add(hos);
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
