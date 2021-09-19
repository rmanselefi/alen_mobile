import 'package:alen/models/laboratory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class LaboratoryProvider with ChangeNotifier {
  List<Laboratories> laboratories = [];
  List<Laboratories> nearHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<HLDServices> labServices = [];
  List<HLDServiceTypes> labServiceTypes = [];
  static List<Laboratories> nearby=[];
  static List<Laboratories> trending=[];


  Future<List<HLDServiceTypes>> getLabServiceTypesByLabId(String Id, String hospitalId) async {
    isLoading = true;
    labServiceTypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('laboratory')
          .where('id', isEqualTo: hospitalId)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('laboratory_service_types')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();
          print("ServiceType:$serviceType");
          final HLDServiceTypes category = new HLDServiceTypes(
              serviceType['id'],
              serviceType['description'],
              serviceType['name'],
              serviceType['image'],
              await servicesList[i]['price'],
              serviceType['service_id']);
          if (category.serviceId == Id) {
            labServiceTypes.add(category);
          }
          labServiceTypes.forEach((element) {
            print("Name : " +
                element.name +
                '\nImage : ' +
                element.image +
                "\nId : " +
                element.id);
          });
        }
      }
      labServices.toSet();
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<Laboratories>> fetchNearByLaboratories(UserLocation location) async {

    isLoading = true;
    laboratories.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('laboratory').get();
      if (docs.docs.isNotEmpty) {
        if (laboratories.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Laboratories hos = Laboratories(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description']);
            laboratories.add(hos);
          }
        }
        if (nearHospital.length == 0) {

          for (var i = 0; i < laboratories.length; i++) {
            if (location != null) {
              var calcDist = Geolocator.distanceBetween(
                  location.latitude,
                  location.longitude,
                  laboratories[i].latitude,
                  laboratories[i].longitude);

              laboratories[i].distance = calcDist;
              nearHospital.add(laboratories[i]);
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

  Future<List<Laboratories>> fetchTrendingLaboratories() async {
    isLoading = true;
    laboratories.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('laboratory').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (laboratories.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Laboratories lab = Laboratories(
                Id: docs.docs[i].id,
                name: data['name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description']);
            laboratories.add(lab);
          }
        }
      }
      trending = laboratories;
      return laboratories;
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

  Future<List<HLDServices>> getAllLabServiceByTypeId(String id) async {
    isLoading = true;
    labServices.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('laboratory')
          .where('id', isEqualTo: id)
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          List<dynamic> list = await data['services'];
          print('Printing list ..........');
          print(list);
          print("Done");
          for (var i = 0; i < list.length; i++) {
            final HLDServices hos = HLDServices(
              list[i]['id'],
              list[i]['description'],
              list[i]['name'],
              list[i]['image'],
            );
            if (hos.id == id) {
              labServices.add(hos);
            }
          }
        }
        labServices.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              "\nId : " +
              element.id);
        });
      }

      labServices.toSet();
      return labServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    nearHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('laboratory').doc(id).get();
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

  Future<List<HLDServices>> getLabServicesByHospitalId(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    labServices.clear();
    try {
      var docs =
      await fire.collection('laboratory').where('id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs.first.data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('laboratory_service_types')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data()['service_id'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          var serviceDocument = await fire
              .collection('laboratory_services')
              .where('id', isEqualTo: serviceType)
              .get();
          var service = serviceDocument.docs.first.data();
          print('This is my service: $service');
          print(i);
          final HLDServices category = new HLDServices(service['description'],
              service['id'], service['image'], service['name']);
          labServices.add(category);
          return labServices;
          print("Also here$i");
        }
        print("none here either");
      }
      return labServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return labServices;
    }
  }
}
