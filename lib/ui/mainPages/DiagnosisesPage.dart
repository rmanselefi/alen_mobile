import 'package:alen/models/user_location.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/SeeAllPages/SecondPage/SeeAllDiagnosises.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/Pages/Diagnosis.dart';
import 'package:alen/ui/SearchDelegates/searchDiagnosises.dart';
import 'package:provider/provider.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/models/diagnostic.dart';

import '../../utils/AppColors.dart';

class DiagnosisesPage extends StatelessWidget {
  List<HospitalServices> hospitalServices = HospitalServices.hospitalServices;
  List<Diagnosis> diagnosises = Diagnosis.diagnosises;
  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var diagProvider = Provider.of<DiagnosticProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          scaffoldBackgroundColor: const Color(0xFFEBEBEB),
          appBarTheme: AppBarTheme(
            color: myCustomColors.loginBackgroud,
          )),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: myCustomColors.loginBackgroud,
            elevation: 2,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text("Diagnoses", textAlign: TextAlign.center)),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        showSearch<Diagnosis>(
                            context: context,
                            delegate: DiagnosisSearch(diagnosises));
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 60, 0, 50),
                          child: Center(
                              child: Container(
                                  // padding: EdgeInsets.all(40.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: Theme(
                                      data: ThemeData(
                                        hintColor: Colors.white,
                                      ),
                                      child: Card(
                                          elevation: 4,
                                          shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0)),
                                            borderSide: BorderSide(
                                                color: myCustomColors
                                                    .loginBackgroud,
                                                width: 2),
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.search,
                                                color: myCustomColors
                                                    .loginBackgroud,
                                              ),
                                              title: Text(
                                                'Search',
                                                style: TextStyle(
                                                  color: myCustomColors
                                                      .loginBackgroud,
                                                ),
                                              ),
                                            ),
                                          ))))))),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          0,
                          MediaQuery.of(context).size.width * 0.05,
                          0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Diagnosisess",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                        ],
                      )),
                  Container(
                      height: 150.0,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _buildTopServicesListItem(
                              hospitalServices[index], ctxt);
                        },
                        itemCount: hospitalServices.length,
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          0,
                          MediaQuery.of(context).size.width * 0.05,
                          0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearby Diagnosisess",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                        ],
                      )),
                  Container(
                      height: 190.0,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: FutureBuilder<UserLocation>(
                          future: diagProvider.getCurrentLocation(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                snapshot.hasData == null) {
                              return CircularProgressIndicator();
                            }
                            return FutureBuilder<List<Diagnostics>>(
                                future: diagProvider
                                    .fetchNearByDiagnostic(snapshot.data),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.none &&
                                      snapshot.hasData == null) {
                                    return CircularProgressIndicator();
                                  }
                                  print(
                                      'project snapshot data is: ${snapshot.data}');
                                  if (snapshot.data == null) {
                                    return Container(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return _buildDiagnosisesListItem(
                                            snapshot.data[index], ctxt);
                                      },
                                      itemCount: snapshot.data.length,
                                    );
                                  }
                                });
                          })),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  _buildTopServicesListItem(
      HospitalServices hospitalService, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        name: hospitalService.name,
                        description: hospitalService.detail,
                        imageUrl: hospitalService.imagePath,
                      )));
        },
        child: Card(
            elevation: 14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
                width: 120.0,
                margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 140,
                      child: SizedBox(
                        height: 140,
                        width: 120,
                        child: Image.asset(hospitalService.imagePath,
                            width: 120, height: 140, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }

  _buildDiagnosisesListItem(Diagnostics diagosis, BuildContext ctxt) {
    print("diagosis.procedureTime ${diagosis.procedureTime}");
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //     ctxt,
          //     MaterialPageRoute(
          //         builder: (context) => HospitalDetail(
          //           title: diagosis.title,
          //           phone: diagosis.phone,
          //           imagesList: diagosis.imagesList,
          //           name: diagosis.name,
          //           description:diagosis.detail,
          //           location: diagosis.location,
          //           info: diagosis.info,
          //           officeHours: diagosis.officeHours,
          //           services: diagosis.services,
          //         )
          //     ));
        },
        child: Card(
            // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 0,
            // elevation: 14,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    width: 120,
                    height: 120,
                    child: SizedBox(
                        height: 120,
                        width: 120,
                        child: diagosis.image != null
                            ? Image.network(diagosis.image,
                                width: 120, height: 120, fit: BoxFit.fill)
                            : Container(
                                child: Center(
                                  child: Text('Image'),
                                ),
                              )),
                  ),
                ),
                Text(
                  diagosis.name,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  diagosis.latitude.toString(),
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  diagosis.procedureTime,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
