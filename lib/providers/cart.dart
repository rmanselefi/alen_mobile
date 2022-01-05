import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:alen/models/cart.dart';
import 'package:alen/models/drugs.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/models/newDrug.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartProvider with ChangeNotifier {
  List<Drugs> drugs = [];
  List<CartDrug> localImporterCartDrugs = [];
  List<CartDrug> localPharmacyCartDrugs = [];
  List<Cart> cartItems = [];
  // List<Category> categoriesList = [];
  firebase_storage.UploadTask uploadTask;


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

  Future<void> addPrescriptionToCart(File file) async {
    var prefs =
    await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id');
    String userName = prefs.getString('first_name')??""+prefs.getString('lastName')??"";
    String userPhone = prefs.getString('phone');
    var profile;
    if (file != null) {
      await uploadImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          profile = res;
        }
      });
    } else {
      return null;
    }
    Map<String, dynamic> data = <String, dynamic>{
      "prescription": profile,
      "user_id": userId,
      "user_name": userName,
      "user_phone": userPhone,
      "timeStamp": DateTime.now(),
      'addressed':false,
    };
    print("This is the prescription  image to be added,");
    FirebaseFirestore.instance.collection('prescriptions').add(data);
  }

  Future<String> uploadImage(File back, {String path}) async {
    // final mimetypeData = lookupMimeType(image.path).split('/');
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    String fileName = basename(back.path);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("prescription_images/$fileName");

    uploadTask = storageReference.putFile(back);

// Cancel your subscription when done.
    firebase_storage.TaskSnapshot snapshot = await uploadTask;
    var imageUrl = await snapshot.ref.getDownloadURL();
    notifyListeners();
    return imageUrl;
  }


  List<Map<String, dynamic>> jsonList=[];

  bool importerUploaded=false;

  Future<num> finalizeImporterCart(String userId) async {
    if(!importerUploaded){
    jsonList.clear();
    localImporterCartDrugs.forEach((element) {
      // jsonList.add(jsonEncode(element));
      jsonList.add(element.toJson());
      print(element.toJson());
    });
    Map<String, dynamic> data = <String, dynamic>{
      "user_id": userId,
      "cart_Items": jsonList,
      "timeStamp": DateTime.now(),
      "delivered": false,
    };
    //TODO check internet connection

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ) {
      FirebaseFirestore.instance.collection('importer_cart').add(data);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      FirebaseFirestore.instance.collection('importer_cart').add(data);
    }else return 3;

    notifyListeners();
    importerUploaded=true;
    return 1;
  }else{
  return 2;
  }
  }


  Future<bool> addImporterDrugToLocalCart(Drugs drug, String userId, int amount) async {
    if(localImporterCartDrugs.length==0){
      localImporterCartDrugs.add(CartDrug(drug, drug.pharmacies, amount, userId));
      importerUploaded=false;
      return true;
    }
    else{
      int temp=0;
      localImporterCartDrugs.forEach((element) {
      if(element.drug.id==drug.id){
        temp++;
      }
    });
    if(temp==0){
      localImporterCartDrugs.add(CartDrug(drug, drug.pharmacies, amount, userId));
      importerUploaded=false;
      return true;
    }
    return false;
    }
    // temp==0?localImporterCartDrugs.add(ImporterCartDrug(drug, drug.pharmacies, amount, userId)):print("Already here");
    notifyListeners();
  }

  Future<List<CartDrug>> getImporterDrugFromLocalCart() async {
    return localImporterCartDrugs;
  }

  Future<num> getImporterTotalPayment() async {
    num sum=0;
    localImporterCartDrugs.forEach((element) {
      sum+=num.parse(element.drug.price)*element.amount;
    });
    return sum;
  }

  Future<void> deleteImporterDrugToLocalCart(CartDrug cartItem) async {
    localImporterCartDrugs.forEach((element) {
      if(element.drug.id==cartItem.drug.id){
        localImporterCartDrugs.remove(element);
        importerUploaded=false;
      }
    });
    notifyListeners();
  }

  bool pharmacyUploaded=false;

  Future<num> finalizePharmacyCart(String userId) async {
    if(!pharmacyUploaded){
      jsonList.clear();
      localPharmacyCartDrugs.forEach((element) {
        // jsonList.add(jsonEncode(element));
        jsonList.add(element.toJson());
        print(element.toJson());
      });
      Map<String, dynamic> data = <String, dynamic>{
        "user_id": userId,
        "cart_Items": jsonList,
        "timeStamp": DateTime.now(),
        "delivered": false,
      };
      //TODO check internet connection
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ) {
        FirebaseFirestore.instance.collection('pharma_cart').add(data);
      } else if (connectivityResult == ConnectivityResult.wifi) {
        FirebaseFirestore.instance.collection('pharma_cart').add(data);
      }else return 3;

      notifyListeners();
      pharmacyUploaded=true;
      return 1;
    }else{
      return 2;
    }
  }
  

  Future<bool> addPharmacyDrugToLocalCart(Drugs drug, String userId, int amount) async {
    if(localPharmacyCartDrugs.length==0){
      localPharmacyCartDrugs.add(CartDrug(drug, drug.pharmacies, amount, userId));
      pharmacyUploaded=false;
      return true;
    }
    else{
      int temp=0;
      localPharmacyCartDrugs.forEach((element) {
        if(element.drug.id==drug.id){
          temp++;
        }
      });
      if(temp==0){
        localPharmacyCartDrugs.add(CartDrug(drug, drug.pharmacies, amount, userId));
        pharmacyUploaded=false;
        return true;
      }
      return false;
    }
    // temp==0?localPharmacyCartDrugs.add(PharmacyCartDrug(drug, drug.pharmacies, amount, userId)):print("Already here");
    notifyListeners();
  }

  Future<List<CartDrug>> getPharmacyDrugFromLocalCart() async {
    localPharmacyCartDrugs.forEach((element) {
      print(element.drug.name);
    });
    return localPharmacyCartDrugs;
  }

  Future<num> getPharmacyTotalPayment() async {
    num sum=0;
    localPharmacyCartDrugs.forEach((element) {
      sum+=num.parse(element.drug.price)*element.amount;
    });
    return sum;
  }

  Future<void> deletePharmacyDrugToLocalCart(CartDrug cartItem) async {
    localPharmacyCartDrugs.forEach((element) {
      if(element.drug.id==cartItem.drug.id){
        localPharmacyCartDrugs.remove(element);
        pharmacyUploaded=false;
      }
    });
    notifyListeners();
  }




  Future<void> deleteDrugFromCart(Cart cart) async {
    print("Deleting item with id :${cart.id}.");
    await FirebaseFirestore.instance
        .collection('pharma_cart').doc(cart.id).delete();

  }

  List<BatchOfCart> totalTransaction;
  List<CartDrug> temporaryCart;
  List<CartDrug> temporaryCart2;

  Future<List<BatchOfCart>> getAllTransactions(String Id) async {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    isLoading = true;
    totalTransaction=[];
    temporaryCart=[];
    temporaryCart2=[];
    try {
      var docs =
      await fire.collection('importer_cart').where('user_id', isEqualTo: Id).get();
      if (docs.docs.isNotEmpty) {
        var servicesList =docs.docs?? [];
        for (var i = 0; i < servicesList.length; i++) {
          temporaryCart = [];
          // var timeStamp = new DateTime.fromMicrosecondsSinceEpoch(time);
          var timeStamp = (servicesList[i]['timeStamp'] as Timestamp).toDate();
          var delivered = await servicesList[i]['delivered'];
          String transactionId = servicesList[i].id;
          var cartItemsList =await servicesList[i]['cart_Items']??[];
          for(var a = 0; a < cartItemsList.length; a++){
            num amount = await cartItemsList[a]['amount'];
            String supplierId = await cartItemsList[a]['supplier_id'];
            String importerDrugId = await cartItemsList[a]['drug_id'];
            var document2 = await fire
                .collection('importer_drug').where('drug_id', isEqualTo: importerDrugId).get();
            var document = document2.docs.first.data();
            bool trending = await document["trending"]??false;
            String price = await document["price"];
            String quantity = await document["quantity"];
            String drugId = await document["drug_id"];

            Drugs drug = await getDrugImporterById(drugId, price, quantity, supplierId, trending);

            CartDrug cartDrug = CartDrug(drug, drug.pharmacies, amount, Id);
            if(temporaryCart.length==0){
              temporaryCart.add(
                  cartDrug
              );
            }
            else {
              int temp = 0;
              temporaryCart.forEach((element) {
                if (element.drug.id == cartDrug.drug.id) {
                  temp++;
                }
              });
              if (temp == 0) {
                temporaryCart.add(
                    cartDrug
                );
              }
            }
            // temporaryCart.add(
            //   CartDrug(drug, drug.pharmacies, amount, Id)
            // );

          }
          BatchOfCart batchOfCart =  BatchOfCart(
              batchTimeStamp: timeStamp.toString(),
              delivered: delivered,
              isPharma: false,
              drugList: temporaryCart,
              transactionId: transactionId,
              userId: Id
          );
          if(totalTransaction.length==0){
            totalTransaction.add(
                batchOfCart
            );
          }
          else {
            int temp = 0;
            totalTransaction.forEach((element) {
              if (element.transactionId == batchOfCart.transactionId) {
                temp++;
              }
            });
            if (temp == 0) {
              totalTransaction.add(
                  batchOfCart
              );
            }
          }

          // totalTransaction.add(
          //   BatchOfCart(
          //     batchTimeStamp: timeStamp.toString(),
          //     delivered: delivered,
          //     isPharma: false,
          //     drugList: temporaryCart,
          //     transactionId: transactionId,
          //     userId: Id
          //   )
          // );


          print("none here either");
        }}
      var docs2 =
      await fire.collection('pharma_cart').where('user_id', isEqualTo: Id).get();
      if (docs2.docs.isNotEmpty) {
        var servicesList2 =docs2.docs?? [];
        for (var i = 0; i < servicesList2.length; i++) {
          temporaryCart2 = [];
          // var timeStamp2 = new DateTime.fromMicrosecondsSinceEpoch(time);
          var timeStamp2 = (servicesList2[i]['timeStamp'] as Timestamp).toDate();
          var delivered2 = await servicesList2[i]['delivered'];
          String transactionId2 = servicesList2[i].id;
          var cartItemsList2 =await servicesList2[i]['cart_Items']??[];
          for(var a = 0; a < cartItemsList2.length; a++){
            num amount2 = await cartItemsList2[a]['amount'];
            String supplierId2 = await cartItemsList2[a]['supplier_id'];
            String importerDrugId2 = await cartItemsList2[a]['drug_id'];
            var document4 = await fire
                .collection('pharmacy_drug').where('drug_id', isEqualTo: importerDrugId2).get();
            var document3 = document4.docs.first.data();
            bool trending2 = await document3["trending"]??false;
            String price2 = await document3["price"];
            String quantity2 = await document3["quantity"];
            String drugId2 = await document3["drug_id"];

            Drugs drug2 = await getDrugPharmacyById(drugId2, price2, quantity2, supplierId2, trending2);

            CartDrug cartDrug2 = CartDrug(drug2, drug2.pharmacies, amount2, Id);

            if(temporaryCart2.length==0){
              temporaryCart2.add(
                  cartDrug2
              );
            }
            else {
              int temp = 0;
              temporaryCart2.forEach((element) {
                if (element.drug.id == cartDrug2.drug.id) {
                  temp++;
                }
              });
              if (temp == 0) {
                temporaryCart2.add(
                    cartDrug2
                );
              }
            }

            // temporaryCart2.add(
            //     CartDrug(drug2, drug2.pharmacies, amount2, Id)
            // );

          }

          BatchOfCart batchOfCart2 =  BatchOfCart(
              batchTimeStamp: timeStamp2.toString(),
              delivered: delivered2,
              isPharma: true,
              drugList: temporaryCart2,
              transactionId: transactionId2,
              userId: Id
          );
          if(totalTransaction.length==0){
            totalTransaction.add(
                batchOfCart2
            );
          }
          else {
            int temp = 0;
            totalTransaction.forEach((element) {
              if (element.transactionId == batchOfCart2.transactionId) {
                temp++;
              }
            });
            if (temp == 0) {
              totalTransaction.add(
                  batchOfCart2
              );
            }
          }

          // totalTransaction.add(
          //     BatchOfCart(
          //         batchTimeStamp: timeStamp2.toString(),
          //         delivered: delivered2,
          //         isPharma: true,
          //         drugList: temporaryCart2,
          //         transactionId: transactionId2,
          //         userId: Id
          //     )
          // );


          print("none here either");
        }}

      return totalTransaction;
    } catch (error) {
      isLoading = false;
      print("Problem . . . . . . :$error");
      return totalTransaction;
    }
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

  Future<Drugs> getDrugPharmacyById(String Id, String price,
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

class CartDrug{
  Drugs drug;
  num amount;
  ImportersPharmacies importer;
  String userId;

  CartDrug(this.drug, this.importer, this.amount, this.userId);


  Map<String, dynamic> toJson() {
    return {
      'drug_id': drug.id,
      'supplier_id': importer.Id,
      'amount': amount};
  }

}

class BatchOfCart{

  String userId;
  String transactionId;
  List<CartDrug> drugList;
  String batchTimeStamp;
  num totalPrice;
  bool delivered;
  bool isPharma;
  BatchOfCart({this.drugList, this.userId, this.batchTimeStamp, this.isPharma, this.transactionId, this.delivered});

  num getTotalPrice(){
    totalPrice=0;
    drugList.forEach((element) {
      totalPrice += element.amount * num.parse(element.drug.price);
    });
    return totalPrice;
  }

}

