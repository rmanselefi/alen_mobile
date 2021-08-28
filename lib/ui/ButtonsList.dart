// import 'package:alen/ui/Details/DiagnosisDetail.dart';
// import 'package:alen/ui/Details/HospitalDetail.dart';
// import 'package:alen/ui/Details/ImporterDetail.dart';
// import 'package:alen/ui/Details/LabDetail.dart';
// import 'package:alen/ui/Pages/Hospital.dart';
// import 'package:alen/ui/Pages/Importer.dart';
// import 'package:alen/ui/Pages/Pharmacy.dart';
// import 'package:flutter/material.dart';
// import 'AppColors.dart';
// import 'Details/PharmacyDetail.dart';
// import 'Pages/Diagnosis.dart';
// import 'Pages/Lab.dart';
//
//
// class ButtonsPage extends StatefulWidget {
//   const ButtonsPage({Key? key}) : super(key: key);
//
//   @override
//   _ButtonsPageState createState() => _ButtonsPageState();
// }
//
// class _ButtonsPageState extends State<ButtonsPage> {
//
//
//   static const myCustomColors = AppColors();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: new ThemeData(
//             fontFamily: 'Ubuntu',
//             scaffoldBackgroundColor: myCustomColors.loginBackgroud),
//         home: Scaffold(
//           body: SingleChildScrollView(
//               child: Stack(
//                 children: [
//                   Container(
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
//                             child: SizedBox(
//                               height: 150,
//                               width: 150,
//                               child: Image.asset('assets/images/alen_no_name.png',
//                                   fit: BoxFit.fill),
//                             ),
//                           ),
//
//                           SizedBox(height: 20,),
//                           Container(
//                               width: 130,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: Text("Hospital",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     )),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         myCustomColors.loginButton),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(30.0),
//                                             side: BorderSide(
//                                                 color:
//                                                 myCustomColors.loginButton)))),
//
//                                 onPressed: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => HospitalDetail(
//                                     hospital: Hospital.hospitals.first,
//                                           )));
//                                 },
//                               )),
//
//                           SizedBox(height: 20,),
//                           Container(
//                               width: 130,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: Text("Pharmacy",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     )),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         myCustomColors.loginButton),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(30.0),
//                                             side: BorderSide(
//                                                 color:
//                                                 myCustomColors.loginButton)))),
//
//                                 onPressed: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => PharamacyDetail(
//                                              pharmacy: Pharmacy.pharmacies.first,)));
//                                 },
//                               )),
//
//                           SizedBox(height: 20,),
//                           Container(
//                               width: 130,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: Text("Lab",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     )),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         myCustomColors.loginButton),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(30.0),
//                                             side: BorderSide(
//                                                 color:
//                                                 myCustomColors.loginButton)))),
//
//                                 onPressed: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => LabDetail(
//                                             lab: Lab.labs.elementAt(1),
//                                           )));
//                                 },
//                               )),
//
//                           SizedBox(height: 20,),
//                           Container(
//                               width: 130,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: Text("Diagnosis",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     )),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         myCustomColors.loginButton),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(30.0),
//                                             side: BorderSide(
//                                                 color:
//                                                 myCustomColors.loginButton)))),
//
//                                 onPressed: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => DiagnosisDetail(
//                                             diagnosis: Diagnosis.diagnosises.elementAt(2),
//                                           )));
//                                 },
//                               )),
//
//                           SizedBox(height: 20,),
//                           Container(
//                               width: 130,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: Text("Importer",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                     )),
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         myCustomColors.loginButton),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(30.0),
//                                             side: BorderSide(
//                                                 color:
//                                                 myCustomColors.loginButton)))),
//
//                                 onPressed: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => ImporterDetail(
//                                               importer: Importer.importers.elementAt(1))));
//                                 },
//                               )),
//
//                           SizedBox(height: 60,)
//                         ],
//
//                       )),
//
//                 ],
//               )),
//         ));
//   }
// }
