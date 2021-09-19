import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';
import '../../Details/PharmacyDetail.dart';
import '../../Models/Trending.dart';
import '../../Pages/Pharmacy.dart';

class SeeAllTrendings extends StatefulWidget {

  @override
  _SeeAllTrendingsState createState() => _SeeAllTrendingsState();
}

class _SeeAllTrendingsState extends State<SeeAllTrendings> {

  static const myCustomColors = AppColors();
  List<Trending> trendings = Trending.trendings;

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
              // height: 180.0,
                child: trendings.length == 0
                    ? Center(
                  child: Text(
                    "No Health Articles Available",
                  ),
                )
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 2.9,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return _buildTrendingsListItem(
                        trendings[index], ctxt);
                  },
                  itemCount: trendings.length,
                )),
        ]))
        );
  }
  _buildTrendingsListItem(Trending trending, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context)=> (trending.importerPharmacy is Pharmacy)?
                  PharamacyDetail(
                    title: trending.importerPharmacy.title,
                    phone: trending.importerPharmacy.phone,
                    name: trending.importerPharmacy.name,
                    description:trending.importerPharmacy.detail,
                    latitude: trending.importerPharmacy.location,
                    longtude: trending.importerPharmacy.info,
                    officeHours: trending.importerPharmacy.officeHours,
                    services: trending.importerPharmacy.services,
                  )
                      :
                  PharamacyDetail(
                    title: trending.importerPharmacy.title,
                    phone: trending.importerPharmacy.phone,
                    name: trending.importerPharmacy.name,
                    description:trending.importerPharmacy.detail,
                    latitude: trending.importerPharmacy.location,
                    longtude: trending.importerPharmacy.info,
                    officeHours: trending.importerPharmacy.officeHours,
                    services: trending.importerPharmacy.services,
                  )

              ));
        },
        child: Card(
          // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: myCustomColors.cardBackgroud,
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
                    width: 150,
                    height: 180,
                    child: SizedBox(
                      height: 180,
                      width: 150,
                      child: Image.asset(trending.imagePath,
                          width: 150, height: 180, fit: BoxFit.fill),
                    ),
                  ),
                ),
                Text(
                  trending.name,
                  maxLines: 2,
                  textScaleFactor: 1.1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  trending.importerPharmacy.name,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
