import 'package:alen/models/company.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class CompanyProvider with ChangeNotifier {
  List<Company> diagnosises = [];
  List<Company> nearHospital = [];
  bool isLoading = false;
  UserLocation currentLocation;
  List<HLDServices> diagnosisServices = [];
  List<HLDServiceTypes> labServiceTypes = [];
  static List<Company> nearby=[];
  static List<Company> trending=[];


  Future<Company> fetchCompany(String id) async {
    print("ididididididididi $id");
    isLoading = true;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('company').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final Company hos = Company(
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
      }
      diagnosisServices.toSet();
      return labServiceTypes;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<Company>> fetchNearByCompanies(UserLocation location) async {

    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('company').get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Company hos = Company(
              type: Type.Company,
              Id: docs.docs[i].id,
              searchType: SearchType.ServiceProvider,
              name: data['name'],
              price: data['price'],
              image: data['image'],
              images: data['images'],
              latitude: data['location'].latitude,
              longitude: data['location'].longitude,
              procedureTime: data['procedure_time'],
              officehours: data['officehours'],
              phone: data['phone'],
              locationName: data['location_name'],
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


  Future<Company> getCompanyById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('diagnostics').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Company diagnostics = Company(
          type: Type.Company,
          name: data['name'],
          price: data['price'],
          image: data['image'],
          images: data['images'],
          latitude: data['location'].latitude,
          longitude: data['location'].longitude,
          procedureTime: data['procedure_time'],
          officehours: data['officehours'],
          phone: data['phone'],
          locationName: data['location_name'],
          email: data['email'],
          description: data['description'],
          dname: data['dname'],
        );
        return diagnostics;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  List<Catalogue> cataloguesList = [];

  Future<List<Catalogue>> getAllCompanyCatalogues() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    cataloguesList.clear();
    var curr;
    try {
      var docs = await fire.collection('catalogues').get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          // print("This is my id: ${servicesData}");
          final Catalogue catalogue = new Catalogue(
              id:data['id'],
              description: data['description'],
              name: data['name'],
              image: data['image'],
              typeId: data['type']['id'],
              typeImage: data['type']['image'],
              typeName: data['type']['name'],
              typeDescription: data['type']['description']??"");
          int temp = 0;
          int kit = 0;
          int diag = 0;
          // if(cataloguesList.length==0){
          //   cataloguesList.add(catalogue);
          // }else{
          cataloguesList.forEach((element) {
            if(catalogue.id==element.id)
            {
              temp++;
            }
            if(element.typeId=="4")
            {
              kit++;
            }
            if(element.typeId=="5")
            {
              diag++;
            }
          });
          if(temp==0){
            if(((catalogue.typeId != "4" || kit==0) && catalogue.typeId == "4")
                ||((catalogue.typeId != "5" || diag==0) && catalogue.typeId == "5") ||
                (catalogue.typeId != "1" && catalogue.typeId != "2" && catalogue.typeId != "3")){
              cataloguesList.add(catalogue);
            }
          }
        }
      }
      cataloguesList.forEach((element) {
        print("Element name:${element.name}");
      });
      cataloguesList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return cataloguesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return null;
    }
  }

  Future<List<Catalogue>> getMyServiceTypes(String hospitalId) async {
    isLoading = true;
    cataloguesList.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('company')
          .where('id', isEqualTo: hospitalId)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList = data.containsKey('catalogues') ? data['catalogues'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['id'];
          String servicesDescription = await servicesList[i]['description'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('catalogues')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();
          print("ServiceType:$serviceType");
          final Catalogue catalogue = new Catalogue(
            id: serviceType['id'],
            description: servicesDescription,
            name : serviceType['name'],
            image : serviceType['image'],
            typeDescription: serviceType['type']['description'],
            typeImage: serviceType['type']['image'],
            typeId: serviceType['type']['id'],
            typeName: serviceType['type']['name'],
          );
          int temp = 0;
          int kit = 0;
          int diag = 0;
          // if(cataloguesList.length==0){
          //   cataloguesList.add(catalogue);
          // }else{
          cataloguesList.forEach((element) {
            if(catalogue.id==element.id)
            {
              temp++;
            }
            if(element.typeId=="4")
            {
              kit++;
            }
            if(element.typeId=="5")
            {
              diag++;
            }
          });
          if(temp==0){
            if(((catalogue.typeId != "4" || kit==0) && catalogue.typeId == "4")
                ||((catalogue.typeId != "5" || diag==0) && catalogue.typeId == "5") ||
                (catalogue.typeId == "1" || catalogue.typeId == "2" || catalogue.typeId == "3")){
              cataloguesList.add(catalogue);
            }
          }
          // }

        }
      }
      cataloguesList.forEach((element) {
        print("Name : " +
            element.name +
            '\nImage : ' +
            element.image +
            "\nId : " +
            element.id);
      });
      cataloguesList.toSet();
      return cataloguesList;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<Catalogue>> getMySubServiceTypes(String hospitalId, String SubTypeId) async {
    isLoading = true;
    cataloguesList.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('company')
          .where('id', isEqualTo: hospitalId)
          .get();
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList = data.containsKey('catalogues') ? data['catalogues'] : [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['id'];
          String servicesDescription = await servicesList[i]['description'];
          print("ServiceTypeId:$servicesData");
          var document = await FirebaseFirestore.instance
              .collection('catalogues')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();
          print("ServiceType:$serviceType");
          if(serviceType['type']['id'] == SubTypeId){
            final Catalogue catalogue = new Catalogue(
              id: serviceType['id'],
              description: servicesDescription,
              name : serviceType['name'],
              image : serviceType['image'],
              typeDescription: serviceType['type']['description'],
              typeImage: serviceType['type']['image'],
              typeId: serviceType['type']['id'],
              typeName: serviceType['type']['name'],
            );

            int temp = 0;
            int kit = 0;
            int diag = 0;
            // if(cataloguesList.length==0){
            //   cataloguesList.add(catalogue);
            // }else{
            cataloguesList.forEach((element) {
              if(catalogue.id==element.id)
              {
                temp++;
              }
              if(element.typeId=="4")
              {
                kit++;
              }
              if(element.typeId=="5")
              {
                diag++;
              }
            });
            if(temp==0){
              if(((catalogue.typeId != "4" || kit==0) && catalogue.typeId == "4")
                  ||((catalogue.typeId != "5" || diag==0) && catalogue.typeId == "5") ||
                  (catalogue.typeId != "1" && catalogue.typeId != "2" && catalogue.typeId != "3")){
                cataloguesList.add(catalogue);
              }
            }
          }
          // }

        }
      }
      cataloguesList.forEach((element) {
        print("Name : " +
            element.name +
            '\nImage : ' +
            element.image +
            "\nId : " +
            element.id);
      });
      cataloguesList.toSet();
      return cataloguesList;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }


  Future<List<Company>> fetchTrendingCompanies() async {
    isLoading = true;
    diagnosises.clear();
    nearHospital.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('company').where('trending',isEqualTo: true).get();
      if (docs.docs.isNotEmpty) {
        if (diagnosises.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final Company diagnosis = Company(
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
              int temp = 0;
              if(diagnosisServices.length==0){
                diagnosisServices.add(hos);
              }else{
                diagnosisServices.forEach((element) {
                  if(hos.id==element.id)
                  {
                    temp++;
                  }
                });
                if(temp==0){
                  diagnosisServices.add(hos);
                }
              }
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
      await FirebaseFirestore.instance.collection('company').doc(id).get();
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
  List<HLDServiceTypes> hospServicestypes = [];
  Future<List<HLDServiceTypes>> getMyCataloguesTypes(String id) async {
    isLoading = true;
    hospServicestypes.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('company_services')
          .where('company_id', isEqualTo: id)
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          HLDServiceTypes hldServiceTypes =  new HLDServiceTypes(
            docs.docs[i].id,
            data['description'],
            "",
            data['catalogue'],
            data['image'],
            data['catalogue'],
            data['company_id'],
          );
          int temp = 0;
          if(hospServicestypes.length==0){
            hospServicestypes.add(hldServiceTypes);
          }else{
            hospServicestypes.forEach((element) {
              if(hldServiceTypes.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              hospServicestypes.add(hldServiceTypes);
            }
          }
        }
        hospServicestypes.forEach((element) {
          print("Name : " +
              element.name +
              '\nImage : ' +
              element.image +
              '\nCatalogue : ' +
              element.price +
              '\nHomeCareId : ' +
              element.id +
              "\nId : " +
              element.serviceId);
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
}
