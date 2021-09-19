import 'package:alen/ui/ListInCategoryService/ListInService.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/DetailsPage.dart';

class SeeAllServices extends StatefulWidget {

  @override
  _SeeAllServicesState createState() => _SeeAllServicesState();
}

class _SeeAllServicesState extends State<SeeAllServices> {

  static const myCustomColors = AppColors();
  List<HospitalServices> hospitalServices = HospitalServices.hospitalServices;

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
                          child: hospitalServices.length == 0
                              ? Center(
                            child: Text(
                              "No Health Articles Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.6,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildHospitalServiesListItem(
                                  hospitalServices[index], ctxt);
                            },
                            itemCount: hospitalServices.length,
                          )),
                    ]))
        );
  }
  _buildHospitalServiesListItem(HospitalServices hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) =>ListInServices()));
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
                  child: Image.asset(hospitalServices.imagePath,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              hospitalServices.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
