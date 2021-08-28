import 'package:alen/models/drugs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrugProvider with ChangeNotifier {
  List<Drugs> drugs = [];
  List<Category> categories = [];

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
    isLoading = true;
    categories.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('new_drugs')
          .where('pharmacy_id', isEqualTo: Id)
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Category category= new Category(
              data.containsKey('category') ? data['category']['name'] : '',
              data.containsKey('category') ? data['category']['image'] : '',
              data.containsKey('category') ? data['category']['id'] : '');
          (categories.length==0)?
              categories.add(category):
          categories.forEach((element) {
            (element.id==category.id)?print("${element.id} already here ${category.id}"):categories.add(category);
          });
          print("${categories.length}");
          // categories.length==0?
          //     categories.add(category):
          // categories.forEach((element) {
          //   if(element.name==category.name){
          //     print("${category.name} Already here.");
          //   }else{
          //     categories.add(category);
          //   }
          // });
          categories.forEach((element) {
            print("Name : "+element.name + '\nImage : '+element.image +"\nId : " +element.id);
          });
        }
      }
      categories.toSet();
      return categories;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return null;
    }
  }

  Future<List<Drugs>> getDrugByCategoryAndId(String Id,Category category) async {
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('new_drugs')
          .where('pharmacy_id', isEqualTo: Id )
          .get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Drugs drug = Drugs(
              id: docs.docs[i].id,
              name: data['name'],
              quantity: data['quantity'].toString(),
              dosage: data['dosage'],
              madein: data['madein'],
              root: data['root'],
              image: data.containsKey('image') ? data['image'] : '',
              category:
              data.containsKey('category') ? data['category']['name'] : '',
              category_image:
              data.containsKey('category') ? data['category']['image'] : '',
              price: data['price'],
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

  // Future<String> putOnFire() async {
  //   isLoading = true;
  //   drugs.clear();
  //   var curr;
  //   try {
  //     var docs = await FirebaseFirestore.instance
  //         .collection('new_drugs');
  //     docs.add({
  //         'category': {
  //           'name' : "Category 2",
  //           'image':"https://firebasestorage.googleapis.com/v0/b/alen-38d3f.appspot.com/o/category%202_images%2FPhaSerCat1Toner.jpg?alt=media&token=679e4cab-d967-4490-b009-78d65ee31461",
  //           'id':"1eeg7eQxP5nV7vSPLCi7"
  //         },
  //         'dosage': "20",
  //         'id': '1eeg7eQxP5nV7vSPLCi7',
  //         'image': 'https://firebasestorage.googleapis.com/v0/b/alen-38d3f.appspot.com/o/category%202_images%2FPhaSerCat1Toner.jpg?alt=media&token=679e4cab-d967-4490-b009-78d65ee31461',
  //         'madein': "US",
  //         'pharmacy_id': "lwD5iAL68kthQfYQXHma",
  //         'name': "Paracetamol",
  //         'price': 10.50,
  //         'quantity': 200,
  //         'root': 'rer',
  //         'trending': true,
  //     })
  //         .then((value) => print("Added"))
  //     .catchError((error)=>print("Failed with error $error"));
  //
  //     docs.add({
  //       'category': {
  //         'name' : "Category 2",
  //         'image':"https://firebasestorage.googleapis.com/v0/b/alen-38d3f.appspot.com/o/category%202_images%2FPhaSerCat1Toner.jpg?alt=media&token=679e4cab-d967-4490-b009-78d65ee31461",
  //         'id':"1eeg7eQxP5nV7vSPLCi7"
  //       },
  //       'dosage': "10",
  //       'id': '1eeg7eQxP5nV7vSPLCi7',
  //       'image': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmedicine&psig=AOvVaw3jdt70vk7kHPjnJH22gX1W&ust=1629561959600000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDHyMX9v_ICFQAAAAAdAAAAABAD',
  //       'madein': "US",
  //       'pharmacy_id': "lwD5iAL68kthQfYQXHma",
  //       'name': "Ketoconasol",
  //       'price': 120.00,
  //       'quantity': 200,
  //       'root': 'rer',
  //       'trending': false,
  //     })
  //         .then((value) => print("Added"))
  //         .catchError((error)=>print("Failed with error $error"));
  //
  //     return "----------DONE-----------";
  //   } catch (error) {
  //     isLoading = false;
  //     print("mjkhjjhbjhvjhvhjvjhgv $error");
  //     return null;
  //   }
  // }

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
