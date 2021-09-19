import 'package:alen/ui/Pages/Importer.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';
import '../../Details/PharmacyDetail.dart';

class SeeAllImporters extends StatefulWidget {

  @override
  _SeeAllImportersState createState() => _SeeAllImportersState();
}

class _SeeAllImportersState extends State<SeeAllImporters> {

  static const myCustomColors = AppColors();
  List<Importer> importers = Importer.importers;

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
                          child: importers.length == 0
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
                              return _buildImportersListItem(
                                  importers[index], ctxt);
                            },
                            itemCount: importers.length,
                          )),
                    ]))
        );
  }
  _buildImportersListItem(Importer importers, BuildContext ctxt) {
    return GestureDetector(
      //Todo the on tap navigations for the categories
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => PharamacyDetail(
                    title: importers.title,
                    phone: importers.phone,
                    name: importers.name,
                    description:importers.detail,
                    latitude: importers.location,
                    longtude: importers.info,
                    officeHours: importers.officeHours,
                    services: importers.services,
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
                  child: Image.asset(importers.imagesList.first,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              importers.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              importers.phone,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              importers.location,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
