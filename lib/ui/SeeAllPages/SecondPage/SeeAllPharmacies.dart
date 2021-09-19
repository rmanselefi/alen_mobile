import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';
import '../../Details/PharmacyDetail.dart';
import '../../Pages/Pharmacy.dart';

class SeeAllPharmacies extends StatefulWidget {

  @override
  _SeeAllPharmaciesState createState() => _SeeAllPharmaciesState();
}

class _SeeAllPharmaciesState extends State<SeeAllPharmacies> {

  static const myCustomColors = AppColors();
  List<Pharmacy> pharmacies = Pharmacy.pharmacies;

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
                          child: pharmacies.length == 0
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
                              return _buildPharmaciesListItem(
                                  pharmacies[index], ctxt);
                            },
                            itemCount: pharmacies.length,
                          )),
                    ]))
        );
  }
  _buildPharmaciesListItem(Pharmacy pharmacy, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => PharamacyDetail(
                    title: pharmacy.title,
                    phone: pharmacy.phone,
                    name: pharmacy.name,
                    description:pharmacy.detail,
                    latitude: pharmacy.location,
                    longtude: pharmacy.info,
                    officeHours: pharmacy.officeHours,
                    services: pharmacy.services,
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
                  child: Image.asset(pharmacy.imagesList.first,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              pharmacy.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              pharmacy.phone,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              pharmacy.location,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
