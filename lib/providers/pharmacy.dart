import 'package:alen/models/importer.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:alen/models/drugs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';

enum Type{
  Hospital,
  Pharmacy,
  Lab,
  Diagnosis,
  Trending,
  HomeCare,
  Company,
  Importer
}
class PharmacyProvider with ChangeNotifier {
  List<Pharmacies> hospitals = [];
  List<Pharmacies> nearHospital = [];
  List<Drugs> trendingDrugs = [];
  List<Pharmacies> trendingPharmacies = [];
  bool isLoading = false;
  UserLocation currentLocation;
  static List<Pharmacies> nearby=[];
  static List<Pharmacies> trending=[];
  static List<Drugs> trendingDRGS=[];

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
              type: Type.Pharmacy,
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                email: data['email'],
                images: data['images'],
                locationName: data['location_name'],
                isPharma: true,
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
      return nearHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Drugs>> fetchTrendingDrugs() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    trendingDrugs.clear();
    var curr;
    try {
      var docs=
      await fire.collection('importer_drug').where('trending', isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];
          String importer = await servicesList[i]['importer_id'];
          ImportersPharmacies impoters = await getImporterById(importer);
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();

          print("Service type:"+serviceType.toString());
            final Drugs drug = Drugs(
                type: Type.Importer,
                id: serviceType['id'],
                name: serviceType['name'],
                quantity: quantity,
                itemId: servicesData,
                dosage: serviceType['dosage'],
                madein: serviceType['madein'],
                root: serviceType['root'],
                image: serviceType.containsKey('image')
                    ? serviceType['image']
                    : '',
                category: serviceType.containsKey('category')
                    ? serviceType['category']['name']
                    : '',
                description: serviceType.containsKey('category')
                    ? serviceType['category']['name']
                    : '',
                category_image: serviceType.containsKey('category')
                    ? serviceType['category']['image']
                    : '',
                price: price ?? "0",
                pharmacies: impoters,
                trending: trending);
          int temp = 0;
          if(trendingDrugs.length==0){
            trendingDrugs.add(drug);
          }else{
            trendingDrugs.forEach((element) {
              if(drug.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              trendingDrugs.add(drug);
            }
          }
        }
      }

      docs =
      await fire.collection('pharmacy_drug').where('trending', isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        print("serviceList length = (${servicesList.length})");
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];
          String pharmacy = await servicesList[i]['pharmacy_id'];
          ImportersPharmacies phar = await getPharmacyById(pharmacy);
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();

          print("Service type:"+serviceType.toString());
          final Drugs drug = Drugs(
              type: Type.Pharmacy,
              id: serviceType['id'],
              itemId: servicesData,
              name: serviceType['name'],
              quantity: quantity,
              dosage: serviceType['dosage'],
              madein: serviceType['madein'],
              root: serviceType['root'],
              image: serviceType.containsKey('image')
                  ? serviceType['image']
                  : '',
              category: serviceType.containsKey('category')
                  ? serviceType['category']['name']
                  : '',
              category_image: serviceType.containsKey('category')
                  ? serviceType['category']['image']
                  : '',
              description: serviceType.containsKey('category')
                  ? serviceType['category']['name']
                  : '',
              price: price ?? "0",
              pharmacies: phar,
              trending: trending);
          int temp = 0;
          if(trendingDrugs.length==0){
            trendingDrugs.add(drug);
          }else{
            trendingDrugs.forEach((element) {
              if(drug.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              trendingDrugs.add(drug);
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      trendingDRGS=trendingDrugs;
      return trendingDrugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return trendingDrugs;
    }
  }

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('pharmacy').doc(id).get();
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
                email: data['email'],
                images: data['images'],
                isPharma: true,
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
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            email: data['email'],
            images: data['images'],
            isPharma: true,
            description: data['description']);
        return pharmacies;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<Importers> getImporterById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
          await FirebaseFirestore.instance.collection('importers').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Importers hos = Importers(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            email: data['email'],
            locationName: data['location_name'],
            images: data['images'],
            officehours: data['officehours'],
            isPharma: false,
            description: data['description']);
        return hos;
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
