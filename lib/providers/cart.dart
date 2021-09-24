import 'package:alen/models/cart.dart';
import 'package:alen/models/drugs.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/models/newDrug.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Drugs> drugs = [];
  List<Cart> cartItems = [];
  // List<Category> categoriesList = [];

  bool isLoading = false;

  Future<List<Cart>> getMyPharmaCartDrugs(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    cartItems.clear();
    totalPrice=0;
    var curr;
    try {
      var docs =
      await fire.collection('pharma_cart').where('user_id', isEqualTo: "abcd").get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['pharmacy_drug_id'];
          String itemId = servicesList[i].id;
          int amount = await servicesList[i]['amount'];
          var document = await fire
              .collection('pharmacy_drug').doc(servicesData).get();
          String pharmacyId = await document["pharmacy_id"];
          bool trending = await document["trending"];
          String price = await document["price"];
          String quantity = await document["quantity"];
          String drugId = await document["drug_id"];
          print("bbbbbbbbbbbbbbbbbbbb");
          Drugs drug = await getDrugById(drugId, price, quantity, pharmacyId, trending);

          Cart cart = Cart(
            amount: amount,
            drug: drug,
            id: itemId,
          );
          var temporary = amount*num.parse(drug.price);
          totalPrice+=temporary;
          int temp2 = 0;
          if(cartItems.length==0){
            cartItems.add(cart);
          }else{
            cartItems.forEach((element) {
              if(cart.id==element.id)
              {
                temp2++;
              }
            });
            if(temp2==0){
              cartItems.add(cart);
            }
          }

          print("Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa(${cart.drug.name})(${cart.id})(${cart.amount})");
        print("none here either");
      }}
      return cartItems;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return cartItems;
    }
  }

  Future<void> addNewDrugToCart(Drugs drug, String userId, int amount) async {
    Map<String, dynamic> data = <String, dynamic>{
      "pharmacy_drug_id": drug.itemId,
      "user_id": userId,
      "amount": amount,
    };
    print("This is the pharma_drug id to be added, :${drug.itemId}");
    FirebaseFirestore.instance.collection('pharma_cart').add(data);
  }

  Future<void> deleteDrugFromCart(Cart cart) async {
    print("Deleting item with id :${cart.id}.");
    await FirebaseFirestore.instance
        .collection('pharma_cart').doc(cart.id).delete();

  }

  Future<List<Cart>> getMyImporterCartDrugs(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    totalPrice=0;
    cartItems.clear();
    var curr;
    try {
      var docs =
      await fire.collection('importer_cart').where('user_id', isEqualTo: "abcd").get();
      if (docs.docs.isNotEmpty) {
        var data2 = docs.docs.toList();
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          String servicesData = await servicesList[i]['importer_drug_id'];
          String itemId = servicesList[i].id;
          int amount = await servicesList[i]['amount'];
          var document = await fire
              .collection('importer_drug').doc(servicesData).get();
          String pharmacyId = await document["importer_id"];
          bool trending = await document["trending"];
          String price = await document["price"];
          String quantity = await document["quantity"];
          String drugId = await document["drug_id"];
          print("bbbbbbbbbbbbbbbbbbbb");
          Drugs drug = await getDrugImporterById(drugId, price, quantity, pharmacyId, trending);

          Cart cart = Cart(
            amount: amount,
            drug: drug,
            id: itemId,
          );
          var temporary = amount*num.parse(drug.price);
          totalPrice+=temporary;
          int temp2 = 0;
          if(cartItems.length==0){
            cartItems.add(cart);
          }else{
            cartItems.forEach((element) {
              if(cart.id==element.id)
              {
                temp2++;
              }
            });
            if(temp2==0){
              cartItems.add(cart);
            }
          }

          print("Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa(${cart.drug.name})(${cart.id})(${cart.amount})");
          print("none here either");
        }}
      return cartItems;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return cartItems;
    }
  }
  static num totalPrice=0;

  Future<void> addNewDrugToImporterCart(Drugs drug, String userId, int amount) async {
    Map<String, dynamic> data = <String, dynamic>{
      "importer_drug_id": drug.itemId,
      "user_id": userId,
      "amount": amount,
    };
    print("This is the pharma_drug id to be added, :${drug.itemId}");
    FirebaseFirestore.instance.collection('importer_cart').add(data);
  }

  Future<void> deleteDrugFromImporterCart(Cart cart) async {
    print("Deleting item with id :${cart.id}.");
    await FirebaseFirestore.instance
        .collection('importer_cart').doc(cart.id).delete();

  }

  Future<Importers> getImporterById(String Id) async {
    isLoading = true;
    var curr;
    try {
      var docs =
      await FirebaseFirestore.instance.collection('importers').doc(Id).get();
      if (docs.exists) {
        var data = docs.data();
        final Importers importers = Importers(
            name: data['name'],
            phone: data['phone'],
            image: data['image'],
            isPharma: false,
            email: data['email'],
            images: data['images'],
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            description: data['description']);
        return importers;
      }
      return null;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
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
            latitude: data['location'].latitude,
            longitude: data['location'].longitude,
            officehours: data['officehours'],
            email: data['email'],
            images: data['images'],
            isPharma: true,
            description: data['description']);
        return pharmacies;
      }
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<Drugs> getDrugById(String Id, String price,
      String quantity, String pharmacyId, bool trending ) async {
    isLoading = true;
    var curr;
    try {
      ImportersPharmacies phar = await getPharmacyById(pharmacyId);
      var document = await FirebaseFirestore.instance
          .collection('all_drugs')
          .where('id', isEqualTo: Id)
          .get();
      var serviceType = document.docs.first.data();

      print("Service type:"+serviceType.toString());
      final Drugs drug = Drugs(
          id: serviceType['id'],
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
          pharmacies: phar,
          trending: trending);
      print("Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        return drug;

    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }

  Future<Drugs> getDrugImporterById(String Id, String price,
      String quantity, String importerId, bool trending ) async {
    isLoading = true;
    var curr;
    try {
      ImportersPharmacies phar = await getImporterById(importerId);
      var document = await FirebaseFirestore.instance
          .collection('all_drugs')
          .where('id', isEqualTo: Id)
          .get();
      var serviceType = document.docs.first.data();

      print("Service type:"+serviceType.toString());
      final Drugs drug = Drugs(
          id: serviceType['id'],
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
          pharmacies: phar,
          trending: trending);
      print("Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      return drug;

    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
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
        'pharmacy_cart': [
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 400
          },
        ],
        'importer_cart':[
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 100
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 40
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 70
          },
        ]
      })
          .then((value) => print("Added"))
          .catchError((error)=>print("Failed with error $error"));

      docs.add({
        'user_id': 'vLGXS3lXfKZpNja1nWzDgl25NHJ3',
        'pharmacy_cart': [
          {'drug_id': '',
            'amount': 50
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 80
          },
        ],
        'importer_cart':[
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 10
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 40
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 20
          },
          {'drug_id': '1eeg7eQxP5nV7vSPLCi7',
            'amount': 100
          },
        ]
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