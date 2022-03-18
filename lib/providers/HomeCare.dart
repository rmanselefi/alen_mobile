import 'package:alen/models/company.dart';
import 'package:alen/models/homeCare.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class HomeCareProvider with ChangeNotifier {
  List<HomeCare> diagnosises = [];
  List<HomeCare> nearHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<HLDServices> diagnosisServices = [];
  List<HLDServiceTypes> labServiceTypes = [];
  static List<HomeCare> nearby=[];
  static List<HomeCare> trending=[];


  Future<HomeCare> fetchHomeCare(String id) async {
    print("ididididididididi $id");
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('home_care').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final HomeCare hos = HomeCare(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            description: data['description'],
            officehours: data['officehours'],
            email: data['email'],
            images: data['images']);
        return hos;
      } else {
        return null;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }


  Future<List<HLDServiceTypes>> getDiagnosticsServiceTypesByDiagnosticsId(String Id, String hospitalId) async {
    isLoading = true;
    labServiceTypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('diagnostics').doc(hospitalId).get();
          // .where('id', isEqualTo: hospitalId)
          // .get();
      // if (docs.docs.isNotEmpty) {
        var data = docs.data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('diagnosis_services_type').doc(servicesData).get();
              // .where('id', isEqualTo: servicesData)
              // .get();
          var serviceType = document.data();
          print("ServiceType:$serviceType");
          final HLDServiceTypes category = new HLDServiceTypes(
              document.id,
              serviceType['description'],
              "",
              serviceType['name'],
              serviceType['image'],
              await servicesList[i]['price'],
              serviceType['service_id']);
          if (category.serviceId == Id) {
            int temp = 0;
            if(labServiceTypes.length==0){
              labServiceTypes.add(category);
            }else{
              labServiceTypes.forEach((element) {
                if(category.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                labServiceTypes.add(category);
              }
            }
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
      diagnosisServices.toSet();
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<HomeCare>> fetchNearByHomeCare(UserLocation location) async {

    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('home_care').get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final HomeCare hos = HomeCare(
              type: Type.HomeCare,
              Id: docs.docs[i].id,
              name: data['name'],
              searchType: SearchType.ServiceProvider,
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
            hos.hospitalsLabsDiagnostics= hos;
            int temp = 0;
            if(diagnosises.length==0){
              diagnosises.add(hos);
            }else{
              diagnosises.forEach((element) {
                if(hos.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                diagnosises.add(hos);
              }
            }
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
      nearby.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return nearHospital;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<HomeCare>> fetchTrendingHomeCare() async {
    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('home_care').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final HomeCare diagnosis = HomeCare(
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
            if(diagnosises.length==0){
              diagnosises.add(diagnosis);
            }else{
              diagnosises.forEach((element) {
                if(diagnosis.Id==element.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                diagnosises.add(diagnosis);
              }
            }
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

  // Future<List<HLDServices>> getAllDiagnosisServiceByTypeId(String id) async {
  //   isLoading = true;
  //   diagnosisServices.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('diagnostics').doc(id).get();
  //         // .where('id', isEqualTo: id)
  //         // .get();
  //     // if (docs.docs.isNotEmpty) {
  //       for (var i = 0; i < docs.docs.length; i++) {
  //         var data = docs.docs[i].data();
  //         List<dynamic> list = await data['services'];
  //         print('Printing list ..........');
  //         print(list);
  //         print("Done");
  //         for (var i = 0; i < list.length; i++) {
  //           final HLDServices hos = HLDServices(
  //             list[i]['id'],
  //             list[i]['description'],
  //             list[i]['name'],
  //             list[i]['image'],
  //           );
  //           if (hos.id == id) {
  //             int temp = 0;
  //             if(diagnosisServices.length==0){
  //               diagnosisServices.add(hos);
  //             }else{
  //               hospServicestypes.forEach((element) {
  //                 if(hos.id==element.id)
  //                 {
  //                   temp++;
  //                 }
  //               });
  //               if(temp==0){
  //                 diagnosisServices.add(hos);
  //               }
  //             }
  //           }
  //         }
  //       }
  //       diagnosisServices.forEach((element) {
  //         print("Name : " +
  //             element.name +
  //             '\nImage : ' +
  //             element.image +
  //             "\nId : " +
  //             element.id);
  //       });
  //
  //     diagnosisServices.toSet();
  //     return diagnosisServices;
  //   } catch (error) {
  //     isLoading = false;
  //     print("Category . . . . . . :$error");
  //     return null;
  //   }
  // }

  Future<List<dynamic>> fetchImages(String id) async {
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('home_care').doc(id).get();
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
      await fire.collection('diagnostics').doc(Id).get();
      // if (docs.docs.isNotEmpty) {
        var data = docs.data();
        var servicesList = data.containsKey('services') ? data['services'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['service_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('diagnosis_services_type').doc(servicesData).get();
              // .where('id', isEqualTo: servicesData)
              // .get();
          var serviceType = document.data()['service_id'];
          var serviceDocument = await fire
              .collection('diagnosis_services').doc(serviceType).get();
              // .where('id', isEqualTo: serviceType)
              // .get();
          var service = serviceDocument.data();
          final HLDServices category = new HLDServices(service['description'],
              document.id, service['image'], service['name']);
          int temp = 0;
          if(diagnosisServices.length==0){
            diagnosisServices.add(category);
          }else{
            diagnosisServices.forEach((element) {
              if(category.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              diagnosisServices.add(category);
            }
          }
          return diagnosisServices;
          print("Also here$i");
        }
        print("none here either");
      return diagnosisServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return diagnosisServices;
    }
  }
  List<HLDServiceTypes> hospServicestypes = [];
  // Future<List<HLDServiceTypes>> getMyCataloguesTypes(String id) async {
  //   isLoading = true;
  //   hospServicestypes.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('home_care_services').doc().get(id);
  //         // .where('home_care_id', isEqualTo: id)
  //         // .get();
  //     if (docs.docs.isNotEmpty) {
  //       for (var i = 0; i < docs.docs.length; i++) {
  //         var data = docs.docs[i].data();
  //         HLDServiceTypes hldServiceTypes =  new HLDServiceTypes(
  //           docs.docs[i].id,
  //           data['description'],
  //           "",
  //           data['name'],
  //           data['image'],
  //           data['name'],
  //           data['home_care_id'],
  //         );
  //         int temp = 0;
  //         if(hospServicestypes.length==0){
  //           hospServicestypes.add(hldServiceTypes);
  //         }else{
  //           hospServicestypes.forEach((element) {
  //             if(hldServiceTypes.id==element.id)
  //             {
  //               temp++;
  //             }
  //           });
  //           if(temp==0){
  //             hospServicestypes.add(hldServiceTypes);
  //           }
  //         }
  //       }
  //       hospServicestypes.forEach((element) {
  //         print("Name : " +
  //             element.name +
  //             '\nImage : ' +
  //             element.image +
  //             '\nCatalogue : ' +
  //             element.price +
  //             '\nHomeCareId : ' +
  //             element.id +
  //             "\nId : " +
  //             element.serviceId);
  //       });
  //     }
  //
  //     hospServicestypes.toSet();
  //     return hospServicestypes;
  //   } catch (error) {
  //     isLoading = false;
  //     print("Category . . . . . . :$error");
  //     return null;
  //   }
  // }
}
