import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Pages/Hospital.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';

class SeeAllHospitals extends StatefulWidget {

  @override
  _SeeAllHospitalsState createState() => _SeeAllHospitalsState();
}

class _SeeAllHospitalsState extends State<SeeAllHospitals> {

  static const myCustomColors = AppColors();
  List<Hospital> hospitals = Hospital.hospitals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: hospitals.length == 0
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
                              return _buildHospitalsListItem(
                                  hospitals[index], ctxt);
                            },
                            itemCount: hospitals.length,
                          )),
                    ]))
        );
  }
  _buildHospitalsListItem(Hospital hospital, BuildContext ctxt) {
    return GestureDetector(
      //Todo the on tap navigations for the categories
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => HospitalDetail(
                    title: hospital.title,
                    phone: hospital.phone,
                    image: hospital.imagesList.first,
                    name: hospital.name,
                    description:hospital.detail,
                    location: hospital.location,
                    info: hospital.info,
                    officeHours: hospital.officeHours,
                    services: hospital.services,
                  )
              ));
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
                  child: Image.asset(hospital.imagesList.first,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              hospital.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              hospital.phone,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              hospital.location,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
