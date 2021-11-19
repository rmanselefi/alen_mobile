import 'package:alen/models/EmergencyMS.dart';
import 'package:alen/models/company.dart';
import 'package:alen/models/homeCare.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class EmergencyMSProvider with ChangeNotifier {
  List<EmergencyMS> emergencyMSes = [];
  List<EmergencyMS> nearEmergencyMSes = [];
  bool isLoading = false;
  UserLocation currentLocation;
  static List<EmergencyMS> nearby=[];
  static List<EmergencyMS> trending=[];


  Future<List<EmergencyMS>> fetchNearByEmergencyMS(UserLocation location) async {

    isLoading = true;
    emergencyMSes.clear();
    nearEmergencyMSes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('e_m_s').get();
      if (docs.docs.isNotEmpty) {
        if (emergencyMSes.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final EmergencyMS hos = EmergencyMS(
              type: Type.HomeCare,
              Id: docs.docs[i].id,
              name: data['name'],
              price: data['price'],
              image: data['image'],
              images: data['images'],
              locationName: data['location_name'],
              latitude: data['location'].latitude,
              longitude: data['location'].longitude,
              procedureTime: data['procedure_time'],
              officehours: data['officehours'],
              phone: data['phone'],
              email: data['email'],
              description: data['description'],
              dname: data['dname'],
            );
            int temp = 0;
            if(emergencyMSes.length==0){
              emergencyMSes.add(hos);
            }else{
              emergencyMSes.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                emergencyMSes.add(hos);
              }
            }
          }
        }
        if (nearEmergencyMSes.length == 0) {

          for (var i = 0; i < emergencyMSes.length; i++) {
            if (location != null) {
              var calcDist = Geolocator.distanceBetween(
                  location.latitude,
                  location.longitude,
                  emergencyMSes[i].latitude,
                  emergencyMSes[i].longitude);

              emergencyMSes[i].distance = calcDist;
              nearEmergencyMSes.add(emergencyMSes[i]);
              isLoading = false;
            }
          }
        }
        if (nearEmergencyMSes.length != 0) {
          nearEmergencyMSes.sort((a, b) => a.distance.compareTo(b.distance));
        }
      }
      nearby=nearEmergencyMSes;
      nearby.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return nearEmergencyMSes;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<EmergencyMS>> fetchTrendingEmergencyMS() async {
    isLoading = true;
    emergencyMSes.clear();
    nearEmergencyMSes.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('e_m_s').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (emergencyMSes.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final EmergencyMS diagnosis = EmergencyMS(
              Id: docs.docs[i].id,
              name: data['name'],
              price: data['price'],
              locationName: data['location_name'],
              image: data['image'],
              images: data['images'],
              latitude: data['location'].latitude,
              longitude: data['location'].longitude,
              procedureTime: data['procedure_time'],
              officehours: data['officehours'],
              phone: data['phone'],
              email: data['email'],
              description: data['description'],
              dname: data['dname'],
            );
            int temp = 0;
            if(emergencyMSes.length==0){
              emergencyMSes.add(diagnosis);
            }else{
              emergencyMSes.forEach((element) {
                if(diagnosis.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                emergencyMSes.add(diagnosis);
              }
            }
          }
        }
      }
      trending = emergencyMSes;
      return emergencyMSes;
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

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('e_m_s').doc(id).get();
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

}
