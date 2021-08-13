import 'package:alen/models/pharmacy.dart';
import 'package:alen/models/drugs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';

class PharmacyProvider with ChangeNotifier {
  List<Pharmacies> hospitals = [];
  List<Pharmacies> nearHospital = [];
  List<Drugs> trendingDrugs = [];
  List<Pharmacies> trendingPharmacies = [];
  bool isLoading = false;
  UserLocation currentLocation;

  Future<List<Pharmacies>> fetchNearByHospitals(UserLocation location) async {
    isLoading = true;
    hospitals.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('pharmacy').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Pharmacies hos = Pharmacies(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description']);
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

  Future<List<Drugs>> fetchTrendingDrugs() async {
    isLoading = true;
    trendingDrugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('drugs')
          .where('trending', isEqualTo: true)
          .get();

      if (docs.docs.isNotEmpty) {
        if (trendingDrugs.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();

            var pharId = data['pharmacy_id'];
            var pharmacy = await getPharmacyById(pharId);

            final Drugs drug = Drugs(
                id: docs.docs[i].id,
                name: data['name'],
                quantity: data['quantity'],
                dosage: data['dosage'],
                madein: data['madein'],
                root: data['root'],
                image: data.containsKey('image') ? data['image'] : '',
                trending: data['trending'],
                pharmacies: pharmacy);

            trendingDrugs.add(drug);
          }
        }
      }
      return trendingDrugs;

    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Pharmacies>> fetchTrendingPharmacies() async {
    isLoading = true;
    trendingPharmacies.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('pharmacy')
          .where('trending', isEqualTo: true)
          .get();
      if (docs.docs.isNotEmpty) {
        if (trendingPharmacies.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Pharmacies hos = Pharmacies(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                officehours: data['officehours'],
                description: data['description']);
            trendingPharmacies.add(hos);
          }
        }
      }
      return trendingPharmacies;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<Pharmacies> getPharmacyById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
          await FirebaseFirestore.instance.collection('pharmacy').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Pharmacies pharmacies = Pharmacies(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            description: data['description']);
        return pharmacies;
      }
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
