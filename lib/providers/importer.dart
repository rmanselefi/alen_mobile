import 'dart:io';

import 'package:alen/models/drugs.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'auth.dart';

class ImporterProvider with ChangeNotifier {
  List<Importers> importers = [];
  List<Drugs> importerDrugs=[];
  List<Category> categoriesList =[];
  List<Importers> nearImporter = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<Importers> hospitals = [];
  List<Importers> nearHospital = [];
  List<Drugs> trendingDrugs = [];
  List<Drugs> drugsList = [];
  List<Importers> trendingPharmacies = [];
  static List<Importers> nearby=[];
  static List<Importers> trending=[];



  Future<Importers> getImporterById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('importers').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Importers importers = Importers(
            name: data['name'],
            Id: docs.id,
            phone: data['phone'],
            image: data['image'],
            isPharma: false,
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            description: data['description']);
        return importers;
      }
      return null;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  // Future<Importers> fetchImporters(String id) async {
  //   isLoading = true;
  //   importers.clear();
  //   nearImporter.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance.collection('importers').doc(id).get();
  //       if (importers.length == 0) {
  //         for (var i = 0; i < docs.docs.length; i++) {
  //           var data = docs.docs[i].data();
  //           final Importers hos = Importers(
  //             type: Type.Importer,
  //               Id: docs.docs[i].id,
  //               name: data['name'],
  //               phone: data['phone'],
  //               image: data['image'],
  //               latitude: data['location'].latitude,
  //               longitude: data['location'].longitude,
  //               email: data['email'],
  //               isPharma: false,
  //               locationName: data['location_name'],
  //               images: data['images'],
  //               officehours: data['officehours'],
  //               description: data['description']);
  //           return hos;
  //
  //         }
  //       }
  //   } catch (error) {
  //     isLoading = false;
  //     print("mjkhjjhbjhvjhvhjvjhgv $error");
  //     return null;
  //   }
  // }

  Future<List<Category>> getDrugsCategoryByImporterId(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    categoriesList.clear();
    var curr;
    try {
      var docs =
      await fire.collection('importer_drug').where('importer_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('all_drugs').doc(servicesData).get();
          var serviceType = document.data()['category'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          final Category category = new Category(
            serviceType['name'],
            serviceType['image'],
            serviceType['id'],
          );
          int temp = 0;
          if(categoriesList.length==0){
            categoriesList.add(category);
          }else{
            categoriesList.forEach((element) {
              if(category.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              categoriesList.add(category);
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      return categoriesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return categoriesList;
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

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('importers').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        List<dynamic> images = data['images'];
        return images;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Importers>> fetchNearByImporters(UserLocation location) async {
    isLoading = true;
    hospitals.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('importers').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Importers hos = Importers(
                type: Type.Importer,
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                locationName: data['location_name'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                email: data['email'],
                images: data['images'],
                isPharma: false,
                officehours: data['officehours'],
                description: data['description']);
            int temp = 0;
            if(hospitals.length==0){
              hospitals.add(hos);
            }else{
              hospitals.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                hospitals.add(hos);
              }
            }
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
      nearby=nearHospital;
      nearby.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return nearHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Importers>> fetchTrendingImporters() async {
    isLoading = true;
    trendingPharmacies.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('importers')
          .where('trending', isEqualTo: true)
          .get();
      if (docs.docs.isNotEmpty) {
        if (trendingPharmacies.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Importers hos = Importers(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                locationName: data['location_name'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                email: data['email'],
                images: data['images'],
                isPharma: false,
                officehours: data['officehours'],
                description: data['description']);
            int temp = 0;
            if(trendingPharmacies.length==0){
              trendingPharmacies.add(hos);
            }else{
              trendingPharmacies.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                trendingPharmacies.add(hos);
              }
            }
          }
        }
      }
      trending = trendingPharmacies;
      return trendingPharmacies;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<Importers> getPharmacyById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('importers').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Importers importer = Importers(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            email: data['email'],
            images: data['images'],
            isPharma: false,
            officehours: data['officehours'],
            description: data['description']);
        return importer;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }


}
