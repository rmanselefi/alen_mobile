import 'package:alen/models/diagnostic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class DiagnosticProvider with ChangeNotifier {
  List<Diagnostics> diagnosises = [];
  List<Diagnostics> nearHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<HLDServices> diagnosisServices = [];
  List<HLDServiceTypes> labServiceTypes = [];
  static List<Diagnostics> nearby=[];
  static List<Diagnostics> trending=[];


  Future<List<HLDServiceTypes>> getDiagnosticsServiceTypesByDiagnosticsId(String Id, String hospitalId) async {
    isLoading = true;
    labServiceTypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('diagnostics')
          .where('id', isEqualTo: hospitalId)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('diagnosis_services_type')
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
      diagnosisServices.toSet();
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<Diagnostics>> fetchNearByDiagnostic(UserLocation location) async {

    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('diagnostics').get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Diagnostics hos = Diagnostics(
                Id: docs.docs[i].id,
                name: data['name'],
                price: data['price'],
                image: data['image'],
                images: data['images'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                procedureTime: data['procedure_time'],
              officehours: data['whours'],
              phone: data['phone'],
                email: data['email'],
                description: data['description'],
                dname: data['dname'],
            );
            diagnosises.add(hos);
          }
        }
        if (nearHospital.length == 0) {

          for (var i = 0; i < diagnosises.length; i++) {
            if (location != null) {
              var calcDist = Geolocator.distanceBetween(
                  location.latitude,
                  location.longitude,
                  diagnosises[i].latitude,
                  diagnosises[i].longitude);

              diagnosises[i].distance = calcDist;
              nearHospital.add(diagnosises[i]);
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

  Future<List<Diagnostics>> fetchTrendingDiagnostic() async {
    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('diagnostics').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Diagnostics diagnosis = Diagnostics(
              Id: docs.docs[i].id,
              name: data['name'],
              price: data['price'],
              image: data['image'],
              images: data['images'],
              latitude: data['location'].latitude,
              longitude: data['location'].longitude,
              procedureTime: data['procedure_time'],
              officehours: data['whours'],
              phone: data['phone'],
              email: data['email'],
              description: data['description'],
              dname: data['dname'],
            );
            diagnosises.add(diagnosis);
          }
        }
      }
      trending = diagnosises;
      return diagnosises;
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

  Future<List<HLDServices>> getAllDiagnosisServiceByTypeId(String id) async {
    isLoading = true;
    diagnosisServices.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('diagnostics')
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
              diagnosisServices.add(hos);
            }
          }
        }
        diagnosisServices.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              "\nId : " +
              element.id);
        });
      }

      diagnosisServices.toSet();
      return diagnosisServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('diagnostics').doc(id).get();
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

  Future<List<HLDServices>> getDiagnosisServicesByHospitalId(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    diagnosisServices.clear();
    try {
      var docs =
      await fire.collection('diagnostics').where('id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs.first.data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('diagnosis_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data()['service_id'];
          var serviceDocument = await fire
              .collection('diagnosis_services')
              .where('id', isEqualTo: serviceType)
              .get();
          var service = serviceDocument.docs.first.data();
          final HLDServices category = new HLDServices(service['description'],
              service['id'], service['image'], service['name']);
          diagnosisServices.add(category);
          return diagnosisServices;
          print("Also here$i");
        }
        print("none here either");
      }
      return diagnosisServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return diagnosisServices;
    }
  }
}
