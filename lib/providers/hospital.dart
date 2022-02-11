import 'package:alen/models/hospital.dart';
import 'package:alen/providers/drug.dart';
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
  static List<HLDServiceTypes> allHospitalSelectedServiceTypes = [];
  FirebaseFirestore fire = FirebaseFirestore.instance;

  Future<List<HLDServiceTypes>> getHospServiceTypesByHospitalId(String Id, String hospitalId) async {
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs =
      await fire.collection('seleted_hospital_services').where('hospital_id', isEqualTo: hospitalId).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['service_id'];
        print("ServiceTypeId:$servicesData");
        // var document = await FirebaseFirestore.instance
        //     .collection('laboratory_services').doc(servicesData).get();
        //     // .where('id', isEqualTo: servicesData)
        // .get();
        // var serviceType = document.data();
        print("ServiceType:${servicesList[i]}");
        final HLDServiceTypes category = new HLDServiceTypes(
          servicesList[i]['service_type_id'],
          servicesList[i]['description'],
          servicesList[i]['service_name'],
          servicesList[i]['image'],
          servicesList[i]['price'],
          servicesList[i]['additional_detail']??"",
          servicesList[i]['service_id'],
          serviceDetail: servicesList[i]['serviceDetail'],
          serviceName: servicesList[i]['serviceName'],
          serviceImage: servicesList[i]['serviceImage'],
          selectedItemId: servicesList[i].id,
        );
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
      hospServicestypes.toSet();
      return hospServicestypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<HLDServiceTypes>> getAllSelectedHospServiceTypes() async {
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs =
      await fire.collection('seleted_hospital_services').where("hospital_id", isNull: false).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['service_id'];
        print("ServiceTypeId:$servicesData");
        // var document = await FirebaseFirestore.instance
        //     .collection('laboratory_services').doc(servicesData).get();
        //     // .where('id', isEqualTo: servicesData)
        // .get();
        // var serviceType = document.data();
        print("ServiceType:${servicesList[i]}");
        final HLDServiceTypes category = new HLDServiceTypes(
          servicesList[i]['service_type_id'],
          servicesList[i]['description'],
          servicesList[i]['service_name'],
          servicesList[i]['image'],
          servicesList[i]['price'],
          servicesList[i]['additional_detail']??"",
          servicesList[i]['service_id'],
          serviceDetail: servicesList[i]['serviceDetail'],
          serviceName: servicesList[i]['serviceName'],
          serviceImage: servicesList[i]['serviceImage'],
          selectedItemId: servicesList[i].id,
            searchType: SearchType.Service,
            hospitalsLabsDiagnostics: await getHospitalById(servicesList[i]['hospital_id'])
        );
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
        hospServicestypes.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              "\nId : " +
              element.id);
        });
      }
      hospServicestypes.toSet();
      allHospitalSelectedServiceTypes = hospServicestypes;
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
                searchType: SearchType.ServiceProvider,
                latitude: data['location'].latitude,
                longitude: data['location'].longitude,
                description: data['description'],
                services: data['services'],
              officehours: data['officehours'],
                email: data['email'],
                images: data['images']
            );
            int temp = 0;
            hos.hospitalsLabsDiagnostics= hos;
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

  Future<Hospitals> getHospitalById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('diagnostics').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Hospitals diagnostics = Hospitals(
            type: Type.Hospital,
            Id: docs.id,
            name: data['name'],
            locationName: data['location_name'],
            phone: data['phone'],
            image: data['image'],
            searchType: SearchType.ServiceProvider,
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            description: data['description'],
            services: data['services'],
            officehours: data['officehours'],
            email: data['email'],
            images: data['images']
            );
        return diagnostics;
      }
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

  // Future<List<HLDServices>> getAllHospServiceByTypeId(String id) async {
  //   isLoading = true;
  //   hospServices.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('hospital').doc(id).get();
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
  //             if(hospServices.length==0){
  //               hospServices.add(hos);
  //             }else{
  //               hospServices.forEach((element) {
  //                 if(hos.id==element.id)
  //                 {
  //                   temp++;
  //                 }
  //               });
  //               if(temp==0){
  //                 hospServices.add(hos);
  //               }
  //             }
  //           }
  //         }
  //       }
  //       hospServices.forEach((element) {
  //         print("Name : " +
  //             element.name +
  //             '\nImage : ' +
  //             element.image +
  //             "\nId : " +
  //             element.id);
  //       });
  //     hospServices.toSet();
  //     return hospServices;
  //   } catch (error) {
  //     isLoading = false;
  //     print("Category . . . . . . :$error");
  //     return null;
  //   }
  // }

  Future<List<HLDServices>> getHospServicesByHospitalId(String Id) async {


    isLoading = true;
    hospServices.clear();
    try {
      var docs =
      await fire.collection('seleted_hospital_services').where('hospital_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['service_id'];
        // print("This is my id: ${servicesData}");
        // var document = await fire
        //     .collection('laboratory_service_types').doc(servicesData).get();
        //     // .where('id', isEqualTo: servicesData)
        //     // .get();
        // var serviceType = document.data()['service'];
        // // print("This is my Try: ${document.docs.first.data()['service_id']}");
        // // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
        // var serviceDocument = await fire
        //     .collection('laboratory_services').doc(servicesData).get();
        //     // .where('id', isEqualTo: serviceType)
        //     // .get();
        // var service = serviceDocument.data();
        // print('This is my service: $service');
        print(i);
        final HLDServices category = new HLDServices(
          servicesList[i]['serviceDetail'],
          servicesList[i]['service_id'],
          servicesList[i]['serviceImage'],
          servicesList[i]['serviceName'],
        );
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

        // print("Also here$i");
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

enum SearchType{
  ServiceProvider,
  Service,
  Drug
}
abstract class Search{
  SearchType searchType;
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;
  Search(this.searchType, this.hospitalsLabsDiagnostics);
}

class HLDServiceTypes implements Search,HospitalsLabsDiagnostics{
  String id;
  String description;
  String name;
  String image;
  String serviceId;
  String price;
  String additionalDiscription;
  String serviceDetail;
  String serviceImage;
  String serviceName;
  String selectedItemId;


  HLDServiceTypes(this.id, this.description, this.name, this.image,
      this.price, this.additionalDiscription, this.serviceId,{
        this.serviceDetail, this.serviceImage, this.serviceName, this.selectedItemId, this.searchType, this.hospitalsLabsDiagnostics,
        this.creditedDate, this.trending, this.Id, this.email, this.type, this.phone,
        this.longitude, this.officehours, this.createdAt, this.distance, this.images, this.latitude,
        this.locationName, this.services, this.shopCredit,
      });

  @override
  SearchType searchType;

  @override
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;

  @override
  String Id;

  @override
  DateTime createdAt;

  @override
  DateTime creditedDate;

  @override
  double distance;

  @override
  String email;

  @override
  List images;

  @override
  double latitude;

  @override
  String locationName;

  @override
  double longitude;

  @override
  String officehours;

  @override
  String phone;

  @override
  List services;

  @override
  String shopCredit;

  @override
  bool trending;

  @override
  Type type;
}