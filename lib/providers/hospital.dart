import 'package:alen/models/hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'package:alen/providers/pharmacy.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospitals> hospitals = [];
  List<Hospitals> nearHospital = [];
  List<Hospitals> trendingHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<HLDServices> hospServices = [];
  List<HLDServiceTypes> hospServicestypes = [];

  Future<List<HLDServiceTypes>> getHospServiceTypesByHospitalId(String Id, String hospitalId) async {
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('hospital')
          .where('id', isEqualTo: hospitalId)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('hospital_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();
          print("ServiceType:$serviceType");
          final HLDServiceTypes category = new HLDServiceTypes(
              serviceType['id'],
              serviceType['description'],
              serviceType['additional_detail'],
              serviceType['name'],
              serviceType['image'],
              await servicesList[i]['price'],
              serviceType['service_id']);
          if (category.serviceId == Id) {
            int temp = 0;
            if(hospServicestypes.length==0){
              hospServicestypes.add(category);
            }else{
              hospServicestypes.forEach((element) {
                if(category.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                hospServicestypes.add(category);
              }
            }
          }
          hospServicestypes.forEach((element) {
            print("Name : " +
                element.name +
                '\nImage : ' +
                element.image +
                "\nId : " +
                element.id);
          });
        }
      }
      hospServices.toSet();
      return hospServicestypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }
  static List<Hospitals> nearby=[];
  static List<Hospitals> trending=[];

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
                type: Type.Hospital,
                Id: docs.docs[i].id,
                name: data['name'],
                locationName: data['location_name'],
                phone: data['phone'],
                image: data['image'],
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description'],
                services: data['services'],
              officehours: data['officehours'],
                email: data['email'],
                images: data['images']
            );
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
                services: data['services'],
                locationName: data['location_name'],
                email: data['email'],
                officehours: data['officehours'],
                images: data['images']
            );
            int temp = 0;
            if(trendingHospital.length==0){
              trendingHospital.add(hos);
            }else{
              trendingHospital.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                trendingHospital.add(hos);
              }
            }
          }
        }
      }
      trending= trendingHospital;
      return trendingHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('hospital').doc(id).get();
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

  Future<List<HLDServices>> getAllHospServiceByTypeId(String id) async {
    isLoading = true;
    hospServices.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('hospital')
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
              int temp = 0;
              if(hospServices.length==0){
                hospServices.add(hos);
              }else{
                hospServices.forEach((element) {
                  if(hos.id==element.id)
                  {
                    temp++;
                  }
                });
                if(temp==0){
                  hospServices.add(hos);
                }
              }
            }
          }
        }
        hospServices.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              "\nId : " +
              element.id);
        });
      }

      hospServices.toSet();
      return hospServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<HLDServices>> getHospServicesByHospitalId(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    hospServices.clear();
    try {
      var docs =
      await fire.collection('hospital').where('id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs.first.data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('hospital_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data()['service_id'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          var serviceDocument = await fire
              .collection('hospital_services')
              .where('id', isEqualTo: serviceType)
              .get();

          var service = serviceDocument.docs.first.data();
          print('This is my service: $service');
          print(i);
          final HLDServices category = new HLDServices(service['description'],
              service['id'], service['image'], service['name']);
          int temp = 0;
          if(hospServices.length==0){
            hospServices.add(category);
          }else{
            hospServices.forEach((element) {
              if(category.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              hospServices.add(category);
            }
          }
          return hospServices;
          print("Also here$i");
        }
        print("none here either");
      }
      return hospServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return hospServices;
    }
  }
}
class HLDServices {
  String detail;
  String id;
  String image;
  String name;

  HLDServices(this.detail, this.id, this.image, this.name);
}

class HLDServiceTypes {
  String id;
  String description;
  String name;
  String image;
  String serviceId;
  String price;
  String additionalDiscription;

  HLDServiceTypes(this.id, this.description, this.additionalDiscription, this.name, this.image,
      this.price, this.serviceId);
}