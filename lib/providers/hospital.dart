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
  List<HospServices> hospServices=[];
  List<HospServicesTypes> hospServicestypes=[];

  Future<Hospitals> fetchHospital(String id) async {
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
              officehours: data['officehours'],
              email: data['email'],
              images: data['images']
            );
            if(hos.Id==id){
              return hos;
            }
            hospitals.add(hos);
          }
        }
      }
      return hospitals.elementAt(1);
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<HospServicesTypes>> getAllHospServiceTypes() async {
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('hosp_services_type')
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final HospServicesTypes hos = HospServicesTypes(
                 data['id'],
                data['description'],
                data['name'],
                data['image'],);
            hospServicestypes.add(hos);
          }
          // hospServicestypes.forEach((element) {
          //   print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
          // });
        }

      hospServicestypes.toSet();
      return hospServicestypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }


  Future<List<HospServices>> getAllHospServiceByTypeId(String id) async {
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
          List<dynamic> list= await data['services'];
          print('Printing list ..........');
          print(list);
          print("Done");
          for(var i=0; i<list.length; i++){
            final HospServices hos = HospServices(
              list[i]['id'],
              list[i]['description'],
              list[i]['name'],
              list[i]['image'],
            );
            if(hos.id==id){
              hospServices.add(hos);
            }
          }
        }
        hospServices.forEach((element) {
          print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
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

  Future<List<HospServices>> getHospServicesByHospitalId(String Id) async {
    isLoading = true;
    hospServices.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('hospital')
          .where('id', isEqualTo: Id)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesesList.length; i++) {
          var servicesData = docs.docs[i].data();
          final HospServices category= new HospServices(
              servicesData['service_detail'],
              servicesData['service_type_id'] ,
              servicesData['service_image'] ,
              servicesData['service_name'] );
          hospServices.add(category);
          // print("${hospServices.length}");
          // categories.length==0?
          //     categories.add(category):
          // categories.forEach((element) {
          //   if(element.name==category.name){
          //     print("${category.name} Already here.");
          //   }else{
          //     categories.add(category);
          //   }
          // });
          hospServices.forEach((element) {
            print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
          });
        }
      }
      hospServices.toSet();
      return hospServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
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
class HospServices{
  String detail;
  String id;
  String image;
  String name;

  HospServices(this.detail, this.id, this.image, this.name);
}
class HospServicesTypes{
  String id;
  String description;
  String name;
  String image;

  HospServicesTypes(this.id, this.description, this.name, this.image);
}
class PhaServices{
  String detail;
  String id;
  String image;
  String name;
  String price;

  PhaServices(this.detail, this.id, this.image, this.name, this.price);
}
class PhaServicesTypes{
  String id;
  String description;
  String name;
  String image;

  PhaServicesTypes(this.id, this.description, this.name, this.image);
}
