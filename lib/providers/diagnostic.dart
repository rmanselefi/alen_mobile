import 'package:alen/models/diagnostic.dart';
import 'package:alen/providers/pharmacy.dart';
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
  FirebaseFirestore fire = FirebaseFirestore.instance;


  Future<List<HLDServices>> getDiagnosticsServicesByDiagnosticsId(String Id) async {
    isLoading = true;
    diagnosisServices.clear();
    try {
      var docs =
      await fire.collection('selected_imaging_services').where('imaging_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['service_id'];
        print(i);
        final HLDServices category = new HLDServices(
          servicesList[i]['serviceDetail'],
          servicesList[i]['service_id'],
          servicesList[i]['serviceImage'],
          servicesList[i]['serviceName'],
        );
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

        // print("Also here$i");
      }
      return diagnosisServices;
      print("none here either");

      return diagnosisServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return diagnosisServices;
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
              type: Type.Diagnosis,
                Id: docs.docs[i].id,
                name: data['name'],
                price: data['price'],
                image: data['image'],
              searchType: SearchType.ServiceProvider,
              locationName: data['location_name'],
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
            int temp = 0;
            hos.hospitalsLabsDiagnostics= hos;
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
              locationName: data['location_name'],
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
  //               diagnosisServices.forEach((element) {
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
    isLoading = true;
    diagnosisServices.clear();
    try {
      var docs =
      await fire.collection('selected_imaging_services').where('imaging_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['service_id'];
        print(i);
        final HLDServices category = new HLDServices(
          servicesList[i]['serviceDetail'],
          servicesList[i]['service_id'],
          servicesList[i]['serviceImage'],
          servicesList[i]['serviceName'],
        );
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

        // print("Also here$i");
      }
      return diagnosisServices;
      print("none here either");

      return diagnosisServices;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return diagnosisServices;
    }
  }

  Future<List<HLDServiceTypes>> getDiagnosticsServiceTypesByDiagnosticsId(String Id, String hospitalId) async {
    isLoading = true;
    labServiceTypes.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_imaging_services').where('imaging_id', isEqualTo: hospitalId).get();
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
      labServiceTypes.toSet();
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }


  Future<Diagnostics> getDiagnosticById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('diagnostics').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Diagnostics diagnostics = Diagnostics(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['whours'],
            email: data['email'],
            images: data['images'],
            type: Type.Diagnosis,
            description: data['description']);
        return diagnostics;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }


  static List<HLDServiceTypes> allDiagnosisSelectedServiceTypes = [];

  Future<List<HLDServiceTypes>> getAllSelectedDiagnosticsServicesTypes() async {
    isLoading = true;
    labServiceTypes.clear();
    try {
      var docs =
      await fire.collection('selected_imaging_services').where("imaging_id", isNull: false).get();
      var servicesList =docs.docs.toList()?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final HLDServiceTypes category = new HLDServiceTypes(
          servicesList[i]['service_type_id']??"",
          servicesList[i]['description']??"",
          servicesList[i]['serviceName']??"",
          servicesList[i]['serviceImage']??"",
          servicesList[i]['price']??"",
          servicesList[i]['additional_detail']??"",
          servicesList[i]['service_id']??"",
          serviceDetail: servicesList[i]['serviceDetail']??"",
          serviceName: servicesList[i]['serviceName']??"",
          serviceImage: servicesList[i]['serviceImage']??"",
          selectedItemId: servicesList[i].id??"",
          searchType: SearchType.Service,
          hospitalsLabsDiagnostics: await getDiagnosticById(servicesList[i]['imaging_id'])
        );
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
        labServiceTypes.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              "\nId : " +
              element.id);
        });
      }
      // labServiceTypes.toSet();
      allDiagnosisSelectedServiceTypes = labServiceTypes;
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Diagnostic all selected services error, . . . . . . :$error");
      return labServiceTypes;
    }
  }
}


// factory User.fromDocument(DocumentSnapshot doc) {
// return User(
// id: doc.data()['id'],
// email: doc.data()['email'],
// username: doc.data()['username'],
// photoUrl: doc.data()['photoUrl'],
// displayName: doc.data()['displayName'],
// bio: doc.data()['bio'],
// fullNames: doc.data()['fullNames'],
// practice: doc.data()['practice'],
// speciality: doc.data()['speciality'],
// phone: doc.data()['phone'],
// mobile: doc.data()['mobile'],
// emergency: doc.data()['emergency'],
// address: doc.data()['address'],
// city: doc.data()['city'],
// location: doc.data()['location'],
// );
// }