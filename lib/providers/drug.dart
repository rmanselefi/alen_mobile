import 'package:alen/models/drugs.dart';
import 'package:alen/models/newDrug.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrugProvider with ChangeNotifier {
  List<Drugs> drugs = [];
  List<Category> categories = [];
  List<Category> categoriesList = [];
  bool isLoading = false;

  Future<List<Drugs>> getPharmacyById(String Id) async {
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('new_drugs')
          .where('pharmacy_id', isEqualTo: Id)
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Drugs drug = Drugs(
              id: docs.docs[i].id,
              name: data['name'],
              quantity: data['quantity'],
              dosage: data['dosage'],
              madein: data['madein'],
              root: data['root'],
              image: data.containsKey('image') ? data['image'] : '',
              category:
                  data.containsKey('category') ? data['category']['name'] : '',
              category_image:
                  data.containsKey('category') ? data['category']['image'] : '',
              trending: data['trending']);
          drugs.add(drug);
        }
      }
      // drugs.toSet();
      return drugs;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Category>> getCategoryById(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    categoriesList.clear();
    var curr;
    try {
      var docs =
      await fire.collection('pharmacy_drug').where('pharmacy_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data()['category'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          final Category category = new Category(
            serviceType['name'],
            serviceType['image'],
            serviceType['id'],
          );
          int temp=0;
          (categoriesList.isEmpty)?
            categoriesList.add(category):
          categoriesList.forEach((element) {
            print('--------------temp : ($temp)--------------');
            if(element.id==category.id){
              temp++;
              print('--------------temp : ($temp)--------------');
            }
          });
          if(temp==0 && categoriesList.length>1){
            categoriesList.add(category);
          }
          print("Also here$i");
        }
        print("none here either");
      }
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
    var curr;
    try {
      var docs =
      await fire.collection('importer_drug').where('importer_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          // print("This is my id: ${servicesData}");
          print('-----------here---------------');
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data()['category'];
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();
          final Category category = new Category(
            serviceType['name'],
            serviceType['image'],
            serviceType['id'],
          );
          int temp=0;
          (categoriesList.isEmpty)?
          categoriesList.add(category):
          categoriesList.forEach((element) {
            print('--------------temp : ($temp)--------------');
            if(element.id==category.id){
              temp++;
              print('--------------temp : ($temp)--------------');
            }
          });
          if(temp==0 && categoriesList.length>1){
            categoriesList.add(category);
          }
          print("------------------------------Also here$i");
        }
        print("----------------------------------none here either");
      }
      return categoriesList;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return categoriesList;
    }
  }

  Future<List<Drugs>> getDrugByCategoryAndId(String Id,Category category) async {
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('new_drugs')
          .where('pharmacy_id', isEqualTo: Id)
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Drugs drug = Drugs(
              id: docs.docs[i].id,
              name: data['name'],
              quantity: data['quantity'],
              dosage: data['dosage'],
              madein: data['madein'],
              root: data['root'],
              image: data.containsKey('image') ? data['image'] : '',
              category:
              data.containsKey('category') ? data['category']['name'] : '',
              category_image:
              data.containsKey('category') ? data['category']['image'] : '',
              trending: data['trending']);
          if(drug.category==category.name) {
            drugs.add(drug);
          }
        }
      }
      // drugs.toSet();
      return drugs;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<List<Drugs>> getDrugByCategoryAndPharmacyId(
      String Id, Category category) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('pharmacy_drug').where('pharmacy_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['drug_id'];
          String pharmaDrugId = await servicesList[i].id;
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];

          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();
          // print("This is my Try: ${document.docs.first.data()['service_id']}");
          // DocumentSnapshot variable = await Firestore.instance.collection('COLLECTION NAME').document('DOCUMENT ID').get();

          if (serviceType['category']['id'] == category.id) {
            final Drugs drug = Drugs(
                id: serviceType['id'],
                itemId: pharmaDrugId,
                name: serviceType['name'],
                quantity: quantity,
                dosage: serviceType['dosage'],
                madein: serviceType['madein'],
                root: serviceType['root'],
                image: serviceType.containsKey('image')
                    ? serviceType['image']
                    : '',
                category: serviceType.containsKey('category')
                    ? serviceType['category']['name']
                    : '',
                category_image: serviceType.containsKey('category')
                    ? serviceType['category']['image']
                    : '',
                price: price ?? "0",
                trending: trending);
            drugs.add(drug);
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

  Future<List<Drugs>> getDrugByCategoryAndImporterId(
      String Id, Category category) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs =
      await fire.collection('importer_drug').where('importer_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        // var data = docs.docs.first.data();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String importerDrugId = await servicesList[i].id;
          String servicesData = await servicesList[i]['drug_id'];
          String price = await servicesList[i]['price'];
          String quantity = await servicesList[i]['quantity'];
          bool trending = await servicesList[i]['trending'];
          print("Service data : ($servicesData)");
          print("Price : ($price)");
          print("Quantity : ($quantity)");
          print("Trending : ($trending)");
          // print("This is my id: ${servicesData}");
          var document = await fire
              .collection('all_drugs')
              .where('id', isEqualTo: servicesData)
              .get();
          var serviceType = document.docs.first.data();

          if (serviceType['category']['id'] == category.id) {
            final Drugs drug = Drugs(
                id: serviceType['id'],
                name: serviceType['name'],
                itemId: importerDrugId,
                quantity: quantity,
                dosage: serviceType['dosage'],
                madein: serviceType['madein'],
                root: serviceType['root'],
                image: serviceType.containsKey('image')
                    ? serviceType['image']
                    : '',
                category: serviceType.containsKey('category')
                    ? serviceType['category']['name']
                    : '',
                category_image: serviceType.containsKey('category')
                    ? serviceType['category']['image']
                    : '',
                price: price ?? "0",
                trending: trending);
            drugs.add(drug);
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