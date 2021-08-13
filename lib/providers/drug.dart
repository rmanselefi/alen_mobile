import 'package:alen/models/drugs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrugProvider with ChangeNotifier {
  List<Drugs> drugs = [];

  bool isLoading = false;

  Future<List<Drugs>> getPharmacyById(String Id) async {
    isLoading = true;
    drugs.clear();
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('drugs')
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
      return drugs;
    } catch (error) {
      isLoading = false;
      print("mjkhjjhbjhvjhvhjvjhgv $error");
      return null;
    }
  }
}
