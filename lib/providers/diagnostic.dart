import 'package:alen/models/diagnostic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';

class DiagnosticProvider with ChangeNotifier {
  List<Diagnostics> hospitals = [];
  List<Diagnostics> nearHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<Diagnostics>> fetchNearByDiagnostic(UserLocation location) async {

    isLoading = true;
    hospitals.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('diagnostics').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Diagnostics hos = Diagnostics(
                Id: docs.docs[i].id,
                name: data['name'],
                price: data['price'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                procedureTime: data['procedure_time'],
                dname: data['dname'],
                workingHours: data['whours']);
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
