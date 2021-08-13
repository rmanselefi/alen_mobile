import 'package:flutter/material.dart';

class Services {
  String name;
  IconData icon;

  Services(this.name, this.icon);

  static List<Services> services = [
    Services("Hospital", Icons.local_hospital_outlined),
    Services("Pharmacy", Icons.local_pharmacy_outlined),
    Services("Lab", Icons.local_hospital_outlined),
    Services("Diagnosis", Icons.local_hospital_outlined),
    Services("Import", Icons.local_hospital_outlined),
  ];
}
