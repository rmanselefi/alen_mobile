import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Pages/Diagnosis.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';

class SeeAllDiagnosises extends StatefulWidget {

  @override
  _SeeAllDiagnosisesState createState() => _SeeAllDiagnosisesState();
}

class _SeeAllDiagnosisesState extends State<SeeAllDiagnosises> {

  static const myCustomColors = AppColors();
  List<Diagnosis> diagnosises = Diagnosis.diagnosises;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground),
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: myCustomColors.loginBackgroud,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Container(
                          child: diagnosises.length == 0
                              ? Center(
                            child: Text(
                              "No Health Articles Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 3.1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildDiagnosisListItem(
                                  diagnosises[index], ctxt);
                            },
                            itemCount: diagnosises.length,
                          )),
                    ]))
        )
    );
  }
  _buildDiagnosisListItem(Diagnosis diagnosis, BuildContext ctxt) {
    return GestureDetector(
      //Todo the on tap navigations for the categories
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => HospitalDetail(
                    title: diagnosis.title,
                    phone: diagnosis.phone,
                    image: diagnosis.imagesList.first,
                    name: diagnosis.name,
                    description:diagnosis.detail,
                    location: diagnosis.location,
                    info: diagnosis.info,
                    officeHours: diagnosis.officeHours,
                    services: diagnosis.services,
                  )));
        },
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
                width: 150,
                height: 180,
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: Image.asset(diagnosis.imagesList.first,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              diagnosis.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              diagnosis.phone,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              diagnosis.location,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
