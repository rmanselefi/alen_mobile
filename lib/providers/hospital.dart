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
                data['image'],'0',data['service_id']);
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
    FirebaseFirestore fire= FirebaseFirestore.instance;
    isLoading = true;
    hospServices.clear();
    var curr;
    try {
      var docs = await fire
          .collection('hospital')
          .where('id', isEqualTo: Id)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs.first.data();
        var servicesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData =await servicesList[i]['service_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('hospital_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType=document.docs.first.data()['service_id'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          var serviceDocument = await fire
              .collection('hospital_services')
              .where('id', isEqualTo: serviceType)
              .get();
          var service=serviceDocument.docs.first.data();
         print('This is my service: $service');
         print(i);
           final HospServices category= new HospServices(
               service['description'],
               service['id'],
               service['image'] ,
               service['name'] );
           hospServices.add(category);
           return hospServices;
          print("Also here$i");
        }
        print("none here either");
      }
      return hospServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return null;
    }
  }

  Future<List<HospServices>> getAllHospServices() async {
    FirebaseFirestore fire= FirebaseFirestore.instance;
    isLoading = true;
    hospServices.clear();
    var curr;
    try {
      var docs = await fire
          .collection('hospital_services')
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data= docs.docs[i].data();
          // print("This is my id: ${servicesData}");
          final HospServices category= new HospServices(
              data['description'],
              data['id'],
              data['image'] ,
              data['name'] );
          // print("Category name: "+category.name);
          hospServices.add(category);
        }
      }
      hospServices.forEach((element) {
        print("Element name:${element.name}");
      });
      return hospServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return null;
    }
  }

  Future<List<HospServicesTypes>> getAllHospitalServiceTypes() async {
    FirebaseFirestore fire= FirebaseFirestore.instance;
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs = await fire
          .collection('hospital_services_type')
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data= docs.docs[i].data();
          // print("This is my id: ${servicesData}");
          final HospServicesTypes category= new HospServicesTypes(
              data['id'],
              data['description'],
              data['name'],
            data['image'] ,"0",data['service_id']);
          hospServicestypes.add(category);
        }
      }
      hospServicestypes.forEach((element) {
        print("Element name:${element.name}");
      });
      return hospServicestypes;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return null;
    }
  }

  Future<void> appendToArray(String id, HospServicesTypes element) async {
    Map<String, dynamic> data = <String, dynamic>{
      "service_id": element.id,
      "price": 0,
    };
    FirebaseFirestore.instance.collection('hospital').doc(id).update({
      'services': FieldValue.arrayUnion([data]),
    });
  }

  Future<void> clearHospital(String id) async {
    FirebaseFirestore.instance.collection('hospital').doc(id).update({'services': FieldValue.delete()}).whenComplete((){
      print('Field Deleted');
    });
    FirebaseFirestore.instance.collection('hospital')
        .doc(id)
        .set({
      'services': []
    },SetOptions(merge: true)).then((value){
      //Do your stuff.
    });
  }

  Future<int> updateServiceTypePrice(String hospitalId, num price,String id) async{
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
        var servicesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData =await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          if(servicesList[i]['service_id']==id){
            print('Found found found found found found found found found found');
            return 1;
          }
        }
      }
      hospServices.toSet();
      return 0;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return 0;
    }
  }

  Future<List<HospServicesTypes>> getHospServiceTypesByHospitalId(String Id, String hospitalId) async {
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
        var servicesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData =await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('hospital_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType=document.docs.first.data();
          print("ServiceType:$serviceType");
          final HospServicesTypes category= new HospServicesTypes(
              serviceType['id'] ,
              serviceType['description'],
              serviceType['name'],
            serviceType['image'],
              await servicesList[i]['price'],
            serviceType['service_id']
          );
          if(category.serviceId==Id){
            hospServicestypes.add(category);
          }
          hospServicestypes.forEach((element) {
            print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
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

  Future<List<HospServicesTypes>> getMyServiceTypes(String hospitalId) async {
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
        var servicesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData =await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('hospital_services_type')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType=document.docs.first.data();
          print("ServiceType:$serviceType");
          final HospServicesTypes category= new HospServicesTypes(
              serviceType['id'] ,
              serviceType['description'],
              serviceType['name'],
              serviceType['image'],
              await servicesList[i]['price'],
            serviceType['service_id']
          );
          hospServicestypes.add(category);
          hospServicestypes.forEach((element) {
            print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
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
  String serviceId;
  String price;

  HospServicesTypes(this.id, this.description, this.name, this.image,this.price, this.serviceId);
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
