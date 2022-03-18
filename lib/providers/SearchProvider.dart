import 'package:alen/models/TrendingSearchable.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user_location.dart';
import 'hospital.dart';

class SearchProvider with ChangeNotifier {

  static List<TrendingSearchable> pharmacies = [];
  static List<TrendingSearchable> pharmacies2 = [];
  static List<TrendingSearchable> hospitals = [];
  static List<TrendingSearchable> hospitals2 = [];
  static List<TrendingSearchable> companies = [];
  static List<TrendingSearchable> companies2 = [];
  static List<TrendingSearchable> diagnostics = [];
  static List<TrendingSearchable> diagnostics2 = [];
  static List<TrendingSearchable> homecares = [];
  static List<TrendingSearchable> homecares2 = [];
  static List<TrendingSearchable> laboratories = [];
  static List<TrendingSearchable> laboratories2 = [];
  static List<TrendingSearchable> emergencyMSs = [];
  static List<TrendingSearchable> emergencyMSs2 = [];
  static List<TrendingSearchable> importers = [];
  static List<TrendingSearchable> importers2 = [];
  static List<TrendingSearchable> pharmacyDrugs = [];
  static List<TrendingSearchable> pharmacyDrugs2 = [];
  static List<TrendingSearchable> importerDrugs = [];
  static List<TrendingSearchable> importerDrugs2 = [];
  static List<TrendingSearchable> hospitalServices = [];
  static List<TrendingSearchable> hospitalServices2 = [];
  static List<TrendingSearchable> diagnosticServices = [];
  static List<TrendingSearchable> diagnosticServices2 = [];
  static List<TrendingSearchable> labServices = [];
  static List<TrendingSearchable> labServices2 = [];



  bool isLoading = false;
  UserLocation currentLocation;

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

  Future<String> fetchDiagnosticName(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('diagnostics').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final String name = data['name'];
        return name;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<String> fetchHospitalName(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('hospital').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final String name = data['name'];
        return name;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<String> fetchLaboratoryName(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('laboratory').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final String name = data['name'];
        return name;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<String> fetchPharmacyName(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('pharmacy').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final String name = data['name'];
        return name;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<String> fetchImporterName(String id) async {
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('importers').doc(id).get();
      if (docs.exists) {
        var data = docs.data();
        final String name = data['name'];
        return name;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllPharmacies(UserLocation location) async {
    isLoading = true;
    pharmacies.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('pharmacy').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Pharmacy,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(pharmacies.length==0){
              pharmacies.add(item);
            }else{
              pharmacies.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                pharmacies.add(item);
              }
            }
          }
        }
      }
      return pharmacies;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return pharmacies;
    }
  }

  Future<List<TrendingSearchable>> fetchAllPharmacies2(UserLocation location) async {
    isLoading = true;
    pharmacies2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('pharmacy').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Pharmacy,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(pharmacies2.length==0){
              pharmacies2.add(item);
            }else{
              pharmacies2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                pharmacies2.add(item);
              }
            }
          }
        }
      }
      return pharmacies2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return pharmacies2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllHospitals(UserLocation location) async {
    isLoading = true;
    hospitals.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('hospital').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Hospital,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(hospitals.length==0){
              hospitals.add(item);
            }else{
              hospitals.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                hospitals.add(item);
              }
            }
          }
        }
      }
      return hospitals;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllHospitals2(UserLocation location) async {
    isLoading = true;
    hospitals2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('hospital').get();
      if (docs.docs.isNotEmpty) {
        if (hospitals2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Hospital,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(hospitals2.length==0){
              hospitals2.add(item);
            }else{
              hospitals2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                hospitals2.add(item);
              }
            }
          }
        }
      }
      return hospitals2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return hospitals2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllCompanies(UserLocation location) async {
    isLoading = true;
    companies.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('company').get();
      if (docs.docs.isNotEmpty) {
        if (companies.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Company,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(companies.length==0){
              companies.add(item);
            }else{
              companies.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                companies.add(item);
              }
            }
          }
        }
      }
      return companies;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllCompanies2(UserLocation location) async {
    isLoading = true;
    companies2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('company').get();
      if (docs.docs.isNotEmpty) {
        if (companies2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Company,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(companies2.length==0){
              companies2.add(item);
            }else{
              companies2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                companies2.add(item);
              }
            }
          }
        }
      }
      return companies2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return companies2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllLabs(UserLocation location) async {
    isLoading = true;
    laboratories.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('laboratory').get();
      if (docs.docs.isNotEmpty) {
        if (laboratories.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Lab,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(laboratories.length==0){
              laboratories.add(item);
            }else{
              laboratories.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                laboratories.add(item);
              }
            }
          }
        }
      }
      return laboratories;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllLabs2(UserLocation location) async {
    isLoading = true;
    laboratories2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('laboratory').get();
      if (docs.docs.isNotEmpty) {
        if (laboratories2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Lab,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(laboratories2.length==0){
              laboratories2.add(item);
            }else{
              laboratories2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                laboratories2.add(item);
              }
            }
          }
        }
      }
      return laboratories2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return laboratories2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllDiagnosis(UserLocation location) async {
    isLoading = true;
    diagnostics.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('diagnostics').get();
      if (docs.docs.isNotEmpty) {
        if (diagnostics.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Diagnosis,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(diagnostics.length==0){
              diagnostics.add(item);
            }else{
              diagnostics.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                diagnostics.add(item);
              }
            }
          }
        }
      }
      return diagnostics;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllDiagnosis2(UserLocation location) async {
    isLoading = true;
    diagnostics2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('diagnostics').get();
      if (docs.docs.isNotEmpty) {
        if (diagnostics2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Diagnosis,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(diagnostics2.length==0){
              diagnostics2.add(item);
            }else{
              diagnostics2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                diagnostics2.add(item);
              }
            }
          }
        }
      }
      return diagnostics2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return diagnostics2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllEmergencyMSs(UserLocation location) async {
    isLoading = true;
    emergencyMSs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('e_m_s').get();
      if (docs.docs.isNotEmpty) {
        if (emergencyMSs.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.EmergencyMS,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(emergencyMSs.length==0){
              emergencyMSs.add(item);
            }else{
              emergencyMSs.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                emergencyMSs.add(item);
              }
            }
          }
        }
      }
      return emergencyMSs;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllEmergencyMSs2(UserLocation location) async {
    isLoading = true;
    emergencyMSs2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('e_m_s').get();
      if (docs.docs.isNotEmpty) {
        if (emergencyMSs2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.EmergencyMS,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(emergencyMSs2.length==0){
              emergencyMSs2.add(item);
            }else{
              emergencyMSs2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                emergencyMSs2.add(item);
              }
            }
          }
        }
      }
      return emergencyMSs2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return emergencyMSs2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllHomeCares(UserLocation location) async {
    isLoading = true;
    homecares.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('home_care').get();
      if (docs.docs.isNotEmpty) {
        if (homecares.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.HomeCare,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(homecares.length==0){
              homecares.add(item);
            }else{
              homecares.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                homecares.add(item);
              }
            }
          }
        }
      }
      return homecares;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllHomeCares2(UserLocation location) async {
    isLoading = true;
    homecares2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('home_care').get();
      if (docs.docs.isNotEmpty) {
        if (homecares2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.HomeCare,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(homecares2.length==0){
              homecares2.add(item);
            }else{
              homecares2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                homecares2.add(item);
              }
            }
          }
        }
      }
      return homecares2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return homecares2;
    }
  }

  Future<List<TrendingSearchable>> fetchAllImporters(UserLocation location) async {
    isLoading = true;
    importers.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('importers').get();
      if (docs.docs.isNotEmpty) {
        if (importers.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Importer,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(importers.length==0){
              importers.add(item);
            }else{
              importers.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                importers.add(item);
              }
            }
          }
        }
      }
      return importers;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<TrendingSearchable>> fetchAllImporters2(UserLocation location) async {
    isLoading = true;
    importers2.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance.collection('importers').get();
      if (docs.docs.isNotEmpty) {
        if (importers2.length == 0) {
          for (var i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            final TrendingSearchable item = TrendingSearchable(
                type: Type.Importer,
                id: docs.docs[i].id,
                title: data['name'],
                image: data['image'],
                searchType: SearchType.ServiceProvider,
                description: data['description']);
            int temp = 0;
            if(importers2.length==0){
              importers2.add(item);
            }else{
              importers2.forEach((element) {
                if(item.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                importers2.add(item);
              }
            }
          }
        }
      }
      return importers2;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return importers2;
    }
  }

  Future<List<TrendingSearchable>> getAllSelectedLabServiceTypes() async {
    isLoading = true;
    labServices.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('selected_lab_services').where("lab_id", isNull: false).get();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final TrendingSearchable category = new TrendingSearchable(
            id: servicesList[i]['lab_id'],
            itemId: servicesList[i]['service_id'],
            description: await fetchLaboratoryName(servicesList[i]['lab_id']),
            image: servicesList[i]['image'],
            searchType: SearchType.Service,
            title: servicesList[i]['serviceName'],
            type: Type.Lab,
        );
        int temp = 0;
        if(labServices.length==0){
          labServices.add(category);
        }else{
          labServices.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            labServices.add(category);
          }
        }
      }
      labServices.toSet();
      return labServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return hospitalServices;
    }
  }

  Future<List<TrendingSearchable>> getAllSelectedLabServiceTypes2() async {
    isLoading = true;
    labServices2.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('selected_lab_services').where("lab_id", isNull: false).get();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final TrendingSearchable category = new TrendingSearchable(
          id: servicesList[i]['lab_id'],
          itemId: servicesList[i]['service_id'],
          // description: servicesList[i]['description'],
          description: await fetchLaboratoryName(servicesList[i]['lab_id']),
          image: servicesList[i]['image'],
          searchType: SearchType.Service,
          title: servicesList[i]['serviceName'],
          type: Type.Lab,
        );
        int temp = 0;
        if(labServices2.length==0){
          labServices2.add(category);
        }else{
          labServices2.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            labServices2.add(category);
          }
        }
      }
      labServices2.toSet();
      return labServices2;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return labServices2;
    }
  }

  Future<List<TrendingSearchable>> getAllSelectedDiagnosticsServicesTypes() async {
    isLoading = true;
    diagnosticServices.clear();
    try {
      var docs =
      await FirebaseFirestore.instance.collection('selected_imaging_services').where("imaging_id", isNull: false).get();
      var servicesList =docs.docs.toList()?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final TrendingSearchable category = new TrendingSearchable(
          id: servicesList[i]['imaging_id'],
          itemId: servicesList[i]['service_id'],
          // description: servicesList[i]['description'],
          description: await fetchDiagnosticName(servicesList[i]['imaging_id']),
          image: servicesList[i]['image'],
          searchType: SearchType.Service,
          title: servicesList[i]['serviceName'],
          type: Type.Diagnosis,
        );
        int temp = 0;
        if(diagnosticServices.length==0){
          diagnosticServices.add(category);
        }else{
          diagnosticServices.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            diagnosticServices.add(category);
          }
        }
      }
      diagnosticServices.toSet();
      return diagnosticServices;
    } catch (error) {
      isLoading = false;
      print("Diagnostic all selected services error, . . . . . . :$error");
      return diagnosticServices;
    }
  }



  Future<List<TrendingSearchable>> getAllSelectedDiagnosticsServicesTypes2() async {
    isLoading = true;
    diagnosticServices2.clear();
    try {
      var docs =
      await FirebaseFirestore.instance.collection('selected_imaging_services').where("imaging_id", isNull: false).get();
      var servicesList =docs.docs.toList()?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final TrendingSearchable category = new TrendingSearchable(
          id: servicesList[i]['imaging_id'],
          itemId: servicesList[i]['service_id'],
          // description: servicesList[i]['description'],
          description: await fetchDiagnosticName(servicesList[i]['imaging_id']),
          image: servicesList[i]['image'],
          searchType: SearchType.Service,
          title: servicesList[i]['serviceName'],
          type: Type.Diagnosis,
        );
        int temp = 0;
        if(diagnosticServices2.length==0){
          diagnosticServices2.add(category);
        }else{
          diagnosticServices2.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            diagnosticServices2.add(category);
          }
        }
      }
      diagnosticServices2.toSet();
      return diagnosticServices2;
    } catch (error) {
      isLoading = false;
      print("Diagnostic all selected services error, . . . . . . :$error");
      return diagnosticServices2;
    }
  }

  Future<List<TrendingSearchable>> getAllSelectedHospServiceTypes() async {
    isLoading = true;
    hospitalServices.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('seleted_hospital_services').where("hospital_id", isNull: false).get();
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
        final TrendingSearchable category = new TrendingSearchable(
          id: servicesList[i]['hospital_id'],
          itemId: servicesList[i]['service_id'],
          // description: servicesList[i]['description'],
          description: await fetchDiagnosticName(servicesList[i]['hospital_id']),
          image: servicesList[i]['image'],
          searchType: SearchType.Service,
          title: servicesList[i]['serviceName'],
          type: Type.Hospital,
        );
        int temp = 0;
        if(hospitalServices.length==0){
          hospitalServices.add(category);
        }else{
          hospitalServices.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            hospitalServices.add(category);
          }
        }
      }
      hospitalServices.toSet();
      return hospitalServices;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return hospitalServices;
    }
  }

  Future<List<TrendingSearchable>> getAllSelectedHospServiceTypes2() async {
    isLoading = true;
    hospitalServices2.clear();
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('seleted_hospital_services').where("hospital_id", isNull: false).get();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        final TrendingSearchable category = new TrendingSearchable(
          id: servicesList[i]['hospital_id'],
          itemId: servicesList[i]['service_id'],
          // description: servicesList[i]['description'],
          description: await fetchDiagnosticName(servicesList[i]['hospital_id']),
          image: servicesList[i]['image'],
          searchType: SearchType.Service,
          title: servicesList[i]['serviceName'],
          type: Type.Hospital,
        );
        int temp = 0;
        if(hospitalServices2.length==0){
          hospitalServices2.add(category);
        }else{
          hospitalServices2.forEach((element) {
            if(category.itemId==element.itemId &&
                category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            hospitalServices2.add(category);
          }
        }
      }
      hospitalServices2.toSet();
      return hospitalServices2;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return hospitalServices2;
    }
  }

  Future<List<TrendingSearchable>> getAllPharmacySelectedDrugs() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    pharmacyDrugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where("pharmacy_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          final TrendingSearchable category = new TrendingSearchable(
            id: servicesList[i]['pharmacy_id'],
            itemId: servicesList[i]['drug_id'],
            // description: servicesList[i]['CategoryName'],
            description: await fetchPharmacyName(servicesList[i]['pharmacy_id']),
            image: servicesList[i]['image'],
            searchType: SearchType.Drug,
            title: servicesList[i]['drug_name'],
            type: Type.Pharmacy,
          );
          int temp = 0;
          if(pharmacyDrugs.length==0){
            pharmacyDrugs.add(category);
          }else{
            pharmacyDrugs.forEach((element) {
              if(category.itemId==element.itemId && element.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              pharmacyDrugs.add(category);
            }
          }
          print("Also here$i");
        }
        print("none here either");
      }
      return pharmacyDrugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return pharmacyDrugs;
    }
  }

  Future<List<TrendingSearchable>> getAllPharmacySelectedDrugs2() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    pharmacyDrugs2.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where("pharmacy_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          final TrendingSearchable category = new TrendingSearchable(
            id: servicesList[i]['pharmacy_id'],
            itemId: servicesList[i]['drug_id'],
            // description: servicesList[i]['CategoryName'],
            description: await fetchPharmacyName(servicesList[i]['pharmacy_id']),
            image: servicesList[i]['image'],
            searchType: SearchType.Drug,
            title: servicesList[i]['drug_name'],
            type: Type.Pharmacy,
          );
          int temp = 0;
          if(pharmacyDrugs2.length==0){
            pharmacyDrugs2.add(category);
          }else{
            pharmacyDrugs2.forEach((element) {
              if(category.itemId==element.itemId && element.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              pharmacyDrugs2.add(category);
            }
          }
          print("Also here$i");
        }
        print("none here either");
      }
      return pharmacyDrugs2;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return pharmacyDrugs2;
    }
  }

  Future<List<TrendingSearchable>> getAllImporterSelectedDrugs() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    importerDrugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where("importer_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          final TrendingSearchable category = new TrendingSearchable(
            id: servicesList[i]['importer_id'],
            itemId: servicesList[i]['drug_id'],
            // description: servicesList[i]['CategoryName'],
            description: await fetchImporterName(servicesList[i]['importer_id']),
            image: servicesList[i]['image'],
            searchType: SearchType.Drug,
            title: servicesList[i]['drug_name'],
            type: Type.Pharmacy,
          );
          int temp = 0;
          if(importerDrugs.length==0){
            importerDrugs.add(category);
          }else{
            importerDrugs.forEach((element) {
              if(category.itemId==element.itemId && element.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              importerDrugs.add(category);
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      return importerDrugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return importerDrugs;
    }
  }

  Future<List<TrendingSearchable>> getAllImporterSelectedDrugs2() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    importerDrugs2.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where("importer_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          final TrendingSearchable category = new TrendingSearchable(
            id: servicesList[i]['importer_id'],
            itemId: servicesList[i]['drug_id'],
            // description: servicesList[i]['CategoryName'],
            description: await fetchImporterName(servicesList[i]['importer_id']),
            image: servicesList[i]['image'],
            searchType: SearchType.Drug,
            title: servicesList[i]['drug_name'],
            type: Type.Importer,
          );
          int temp = 0;
          if(importerDrugs2.length==0){
            importerDrugs2.add(category);
          }else{
            importerDrugs2.forEach((element) {
              if(category.itemId==element.itemId && element.id==element.id)
              {
                temp++;
              }
            });
            if(temp==0){
              importerDrugs2.add(category);
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      return importerDrugs2;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return importerDrugs2;
    }
  }

}
