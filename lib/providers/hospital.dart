import 'package:alen/models/hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospitals> hospitals = [];
  List<Hospitals> nearHospital = [];
  List<Hospitals> trendingHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<Hospitals>> fetchNearByHospitals(UserLocation location) async {
    isLoading = true;
    hospitals.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('hospital').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Hospitals hos = Hospitals(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description'],
                services: data['services'],
              officehours: data['officehours']
            );
            hospitals.add(hos);
          }
        }
        if (nearHospital.length == 0) {
          for (var i = 0; i < hospitals.length; i++) {
            if (location != null) {
              var calcDist = Geolocator.distanceBetween(
                  location.latitude,
                  location.longitude,
                  hospitals[i].latitude,
                  hospitals[i].longitude);

              hospitals[i].distance = calcDist;
              nearHospital.add(hospitals[i]);
              isLoading = false;
            }
          }
        }
        if (nearHospital.length != 0) {
          nearHospital.sort((a, b) => a.distance.compareTo(b.distance));
        }
      }
      return nearHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }


  Future<List<Hospitals>> fetchTrendingHospitals() async {
    isLoading = true;
    trendingHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('hospital').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (trendingHospital.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Hospitals hos = Hospitals(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description'],
                services: data['services']);
            trendingHospital.add(hos);
          }
        }
      }
      return trendingHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<UserLocation> getCurrentLocation() async {
    try {
      Position curr = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLocation = UserLocation(
        latitude: curr.latitude,
        longitude: curr.longitude,
      );
      print("object $currentLocation");
      return currentLocation;
    } catch (e) {
      print('errorlocation $e');
    }

    return currentLocation;
  }
}
