import 'package:alen/models/drugs.dart';
import 'package:alen/models/hospital.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/models/newDrug.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrugProvider with ChangeNotifier {
  List<Drugs> drugs = [];
  static List<Drugs> allPharmacySelectedDrugs = [];
  static List<Drugs> allPharmacySelectedDrugsFromDetail = [];
  static List<Drugs> allImporterSelectedDrugs = [];
  static List<Drugs> allImporterSelectedDrugsFromDetail = [];
  List<Category> categories = [];
  List<Category> categoriesList = [];
  bool isLoading = false;


  Future<List<Category>> getDrugsCategoryByImporterId(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    categoriesList.clear();
    print("pppppppppppppppppppppppp");
    print("-----------------"+Id+"-----------------");
    print("pppppppppppppppppppppppp");
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where('importer_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['drug_id'];
        print("This is my id: ${servicesData}");
        // var serviceType = document.docs.first.data()['category'];
        // print("This is my Try: ${document.docs.first.data()['service_id']}");
        // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
        final Category category = new Category(
          servicesList[i]['CategoryName'],
          servicesList[i]['CategoryImage'],
          servicesList[i]['CategoryId'],
        );
        int temp = 0;
        if(categoriesList.length==0){
          categoriesList.add(category);
        }else{
          categoriesList.forEach((element) {
            if(category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            categoriesList.add(category);
          }
          print("Also here$i");
        }
        print("none here either");
      }
      categoriesList.forEach((element) {
        print("*****************************");
        print("Element Id: ${element.id}");
        print("Element Name: ${element.name}");
        print("Element Image: ${element.image}");
        print("*****************************");
      });
      return categoriesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return categoriesList;
    }
  }

  // Future<List<Drugs>> getPharmacyById(String Id) async {
  //   isLoading = true;
  //   drugs.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('new_drugs')
  //         .where('pharmacy_id', isEqualTo: Id)
  //         .get();
  //     if (docs.docs.isNotEmpty) {
  //       for (var i = 0; i < docs.docs.length; i++) {
  //         var data = docs.docs[i].data();
  //         final Drugs drug = Drugs(
  //             id: docs.docs[i].id,
  //             name: data['name'],
  //             quantity: data['quantity'],
  //             dosage: data['dosage'],
  //             madein: data['madein'],
  //             root: data['root'],
  //             image: data.containsKey('image') ? data['image'] : '',
  //             category:
  //                 data.containsKey('category') ? data['category']['name'] : '',
  //             category_image:
  //                 data.containsKey('category') ? data['category']['image'] : '',
  //             trending: data['trending']);
  //         int temp2 = 0;
  //         if(drugs.length==0){
  //           drugs.add(drug);
  //         }else{
  //           drugs.forEach((element) {
  //             if(drug.id==element.id)
  //             {
  //               temp2++;
  //             }
  //           });
  //           if(temp2==0){
  //             drugs.add(drug);
  //           }
  //         }
  //       }
  //     }
  //     // drugs.toSet();
  //     return drugs;
  //   } catch (error) {
  //     isLoading = false;
  //     print("mjkhjjhbjhvjhvhjvjhgv $error");
  //     return null;
  //   }
  // }

  Future<List<Category>> getCategoryById(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    categoriesList.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where('pharmacy_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['drug_id'];
        print("This is my id: ${servicesData}");
        // var serviceType = document.docs.first.data()['category'];
        // print("This is my Try: ${document.docs.first.data()['service_id']}");
        // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
        final Category category = new Category(
          servicesList[i]['CategoryName'],
          servicesList[i]['CategoryImage'],
          servicesList[i]['CategoryId'],
        );
        int temp = 0;
        if(categoriesList.length==0){
          categoriesList.add(category);
        }else{
          categoriesList.forEach((element) {
            if(category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            categoriesList.add(category);
          }
          print("Also here$i");
        }
        print("none here either");
      }
      categoriesList.forEach((element) {
        print("*****************************");
        print("Element Id: ${element.id}");
        print("Element Name: ${element.name}");
        print("Element Image: ${element.image}");
        print("*****************************");
      });
      return categoriesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return categoriesList;
    }
  }

  Future<List<Category>> getCategoryImporterById(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    categoriesList.clear();
    print("pppppppppppppppppppppppp");
    print("-----------------"+Id+"-----------------");
    print("pppppppppppppppppppppppp");
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where('importer_id', isEqualTo: Id).get();
      // if (docs.docs.isNotEmpty) {
      var data2 = docs.docs.toList();
      // var data = docs.docs.first.data();
      var servicesList =docs.docs?? [];
      for (var i = 0; i < servicesList.length; i++) {
        String servicesData = await servicesList[i]['drug_id'];
        print("This is my id: ${servicesData}");
        // var serviceType = document.docs.first.data()['category'];
        // print("This is my Try: ${document.docs.first.data()['service_id']}");
        // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
        final Category category = new Category(
          servicesList[i]['CategoryName'],
          servicesList[i]['CategoryImage'],
          servicesList[i]['CategoryId'],
        );
        int temp = 0;
        if(categoriesList.length==0){
          categoriesList.add(category);
        }else{
          categoriesList.forEach((element) {
            if(category.id==element.id)
            {
              temp++;
            }
          });
          if(temp==0){
            categoriesList.add(category);
          }
          print("Also here$i");
        }
        print("none here either");
      }
      categoriesList.forEach((element) {
        print("*****************************");
        print("Element Id: ${element.id}");
        print("Element Name: ${element.name}");
        print("Element Image: ${element.image}");
        print("*****************************");
      });
      return categoriesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return categoriesList;
    }
  }

  // Future<List<Drugs>> getDrugByCategoryAndId(String Id,Category category) async {
  //   isLoading = true;
  //   drugs.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('new_drugs')
  //         .where('pharmacy_id', isEqualTo: Id)
  //         .get();
  //     if (docs.docs.isNotEmpty) {
  //       for (var i = 0; i < docs.docs.length; i++) {
  //         var data = docs.docs[i].data();
  //         final Drugs drug = Drugs(
  //             id: docs.docs[i].id,
  //             name: data['name'],
  //             quantity: data['quantity'],
  //             dosage: data['dosage'],
  //             madein: data['madein'],
  //             root: data['root'],
  //             image: data.containsKey('image') ? data['image'] : '',
  //             category:
  //             data.containsKey('category') ? data['category']['name'] : '',
  //             category_image:
  //             data.containsKey('category') ? data['category']['image'] : '',
  //             trending: data['trending']);
  //         if(drug.category==category.name) {
  //           int temp2 = 0;
  //           if(drugs.length==0){
  //             drugs.add(drug);
  //           }else{
  //             drugs.forEach((element) {
  //               if(drug.id==element.id)
  //               {
  //                 temp2++;
  //               }
  //             });
  //             if(temp2==0){
  //               drugs.add(drug);
  //             }
  //           }
  //         }
  //       }
  //     }
  //     // drugs.toSet();
  //     return drugs;
  //   } catch (error) {
  //     isLoading = false;
  //     print("mjkhjjhbjhvjhvhjvjhgv $error");
  //     return null;
  //   }
  // }

  Future<List<Drugs>> getDrugByCategoryAndPharmacyId(
      String Id, Category category) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where('pharmacy_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];
          if (servicesList[i]['CategoryId'] == category.id) {
            final Drugs drug = Drugs(
                itemId: servicesList[i].id,
                id: servicesList[i]['drug_id'],
                name: servicesList[i]['drug_name'],
                quantity: quantity,
                dosage: servicesList[i]['dosage'],
                madein: servicesList[i]['madein'],
                root: servicesList[i]['root'],
                image: servicesList[i]['image']??"",
                category: servicesList[i]['CategoryName']??"",
                category_image: servicesList[i]['CategoryImage']??"",
                category_id: servicesList[i]['CategoryId']??"",
                price: price ?? "0",
                pharmacies: await getPharmacyById(Id),
                trending: trending);
            int temp = 0;
            if(drugs.length==0){
              drugs.add(drug);
            }else{
              drugs.forEach((element) {
                if(drug.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                drugs.add(drug);
              }
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      return drugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return drugs;
    }
  }

  Future<List<Drugs>> getAllPharmacySelectedDrugs() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where("pharmacy_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          // String servicesData = await servicesList[i]['drug_id'];
          // String price = await servicesList[i]['price'];
          // String quantity = await servicesList[i]['quantity'];
          // bool trending = await servicesList[i]['trending'];
          String price = "";
          String quantity = "";
          bool trending = false;
          Pharmacies pharmacy = await getPharmacyById(await servicesList[i]['pharmacy_id'],);
            final Drugs drug = Drugs(
                // itemId: servicesList[i].id,
                // id: servicesList[i]['drug_id'],
                // name: servicesList[i]['drug_name'],
                // quantity: quantity,
                // dosage: servicesList[i]['dosage'],
                // madein: servicesList[i]['madein'],
                // root: servicesList[i]['root'],
                // image: servicesList[i]['image']??"",
                // category: servicesList[i]['CategoryName']??"",
                // category_image: servicesList[i]['CategoryImage']??"",
                // category_id: servicesList[i]['CategoryId']??"",
                // price: price ?? "0",
                // searchType: SearchType.Drug,
                itemId: servicesList[i].id,
                id: servicesList[i]['drug_id'],
                name: servicesList[i]['drug_name'],
                quantity: quantity,
                dosage: "",
                madein: "",
                root: "",
                image: "",
                category: "",
                category_image: "",
                category_id: "",
                price: "0",
                searchType: SearchType.Drug,
                hospitalsLabsDiagnostics: pharmacy,
                pharmacies: pharmacy,
                trending: trending);
            int temp = 0;
            if(drugs.length==0){
              drugs.add(drug);
            }else{
              drugs.forEach((element) {
                if(drug.id==element.id && drug.pharmacies.Id==element.pharmacies.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                drugs.add(drug);
              }
            }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      allPharmacySelectedDrugs = drugs;
      return drugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return drugs;
    }
  }

  Future<List<Drugs>> getAllPharmacySelectedDrugsFromDetail() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_pharmacy_drugs').where("pharmacy_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          // String servicesData = await servicesList[i]['drug_id'];
          // String price = await servicesList[i]['price'];
          // String quantity = await servicesList[i]['quantity'];
          // bool trending = await servicesList[i]['trending'];
          String price = "";
          String quantity = "";
          bool trending = false;
          Pharmacies pharmacy = await getPharmacyById(await servicesList[i]['pharmacy_id'],);
          final Drugs drug = Drugs(
            // itemId: servicesList[i].id,
            // id: servicesList[i]['drug_id'],
            // name: servicesList[i]['drug_name'],
            // quantity: quantity,
            // dosage: servicesList[i]['dosage'],
            // madein: servicesList[i]['madein'],
            // root: servicesList[i]['root'],
            // image: servicesList[i]['image']??"",
            // category: servicesList[i]['CategoryName']??"",
            // category_image: servicesList[i]['CategoryImage']??"",
            // category_id: servicesList[i]['CategoryId']??"",
            // price: price ?? "0",
            // searchType: SearchType.Drug,
              itemId: servicesList[i].id,
              id: servicesList[i]['drug_id'],
              name: servicesList[i]['drug_name'],
              quantity: quantity,
              dosage: "",
              madein: "",
              root: "",
              image: "",
              category: "",
              category_image: "",
              category_id: "",
              price: "0",
              searchType: SearchType.Drug,
              hospitalsLabsDiagnostics: pharmacy,
              pharmacies: pharmacy,
              trending: trending);
          int temp = 0;
          if(drugs.length==0){
            drugs.add(drug);
          }else{
            drugs.forEach((element) {
              if(drug.id==element.id && drug.pharmacies.Id==element.pharmacies.Id)
              {
                temp++;
              }
            });
            if(temp==0){
              drugs.add(drug);
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      allPharmacySelectedDrugsFromDetail = drugs;
      allPharmacySelectedDrugsFromDetail.forEach((element) {
        print("element.hospitalsLabsDiagnostics.Id");
        print(element.hospitalsLabsDiagnostics.Id);
        print("element.hospitalsLabsDiagnostics.Id");
      });
      return drugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return drugs;
    }
  }

  Future<Pharmacies> getPharmacyById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('pharmacy').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Pharmacies pharmacies = Pharmacies(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            locationName: data['location_name'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            email: data['email'],
            type: Type.Pharmacy,
            images: data['images'],
            isPharma: true,
            description: data['description']);
        return pharmacies;
      }
    } catch (error) {
      isLoading = false;
      print("Get Pharmacy By Id Problem on drug $error");
      return null;
    }
  }

  Future<Importers> getImporterById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('importers').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Importers hos = Importers(
            Id: docs.id,
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            email: data['email'],
            locationName: data['location_name'],
            images: data['images'],
            officehours: data['officehours'],
            isPharma: false,
            type: Type.Importer,
            description: data['description']);
        return hos;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Drugs>> getDrugByCategoryAndImporterId(
      String Id, Category category) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where('importer_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];
          if (servicesList[i]['CategoryId'] == category.id) {
            final Drugs drug = Drugs(
                itemId: servicesList[i].id,
                id: servicesList[i]['drug_id'],
                name: servicesList[i]['drug_name'],
                quantity: quantity,
                dosage: servicesList[i]['dosage'],
                madein: servicesList[i]['madein'],
                root: servicesList[i]['root'],
                image: servicesList[i]['image']??"",
                category: servicesList[i]['CategoryName']??"",
                category_image: servicesList[i]['CategoryImage']??"",
                category_id: servicesList[i]['CategoryId']??"",
                price: price ?? "0",
                pharmacies: await getImporterById(Id),
                trending: trending);
            int temp = 0;
            if(drugs.length==0){
              drugs.add(drug);
            }else{
              drugs.forEach((element) {
                if(drug.id==element.id)
                {
                  temp++;
                }
              });
              if(temp==0){
                drugs.add(drug);
              }
            }
          }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      return drugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return drugs;
    }
  }

  Future<List<Drugs>> getAllImporterSelectedDrugs() async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('selected_importer_drugs').where("importer_id", isNull: false).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String price = "";
          String quantity = "";
          bool trending = false;
          Importers importer =  await getImporterById(servicesList[i]['importer_id'],);
            final Drugs drug = Drugs(
                itemId: servicesList[i].id,
                id: servicesList[i]['drug_id'],
                name: servicesList[i]['drug_name'],
                quantity: quantity,
                dosage: "",
                madein: "",
                root: "",
                image: "",
                category: "",
                category_image: "",
                category_id: "",
                price: price ?? "0",
                searchType: SearchType.Drug,
                pharmacies:importer,
                hospitalsLabsDiagnostics: importer,
                trending: trending);
            int temp = 0;
            if(drugs.length==0){
              drugs.add(drug);
            }else{
              drugs.forEach((element) {
                if(drug.id==element.id && drug.pharmacies.Id==element.pharmacies.Id)
                {
                  temp++;
                }
              });
              if(temp==0){
                drugs.add(drug);
              }
            }
          // return categoriesList;
          print("Also here$i");
        }
        print("none here either");
      }
      allImporterSelectedDrugs = drugs;
      return drugs;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return drugs;
    }
  }

  Future<String> putOnFire() async {
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('cart');
      docs.add({
        'user_id': 'HvQWillqpmNO7mlKnhSF3IRVkFi1',
        'pharmacy_cart': [],
        'importer_cart':[]
      })
          .then((value) => print("Added"))
          .catchError((error)=>print("Failed with error $error"));

      docs.add({
        'user_id': 'vLGXS3lXfKZpNja1nWzDgl25NHJ3',
        'pharmacy_cart': [],
        'importer_cart':[]
      })
          .then((value) => print("Added"))
          .catchError((error)=>print("Failed with error $error"));

      return "----------DONE-----------";
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }
}

class Category{
  String name;
  String image;
  String id;

  Category(this.name, this.image, this.id);
}