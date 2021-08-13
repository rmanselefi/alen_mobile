import 'package:alen/ui/Cart/ImportCart.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///D:/Personal/Workspace/flutter_projects/alen/lib/utils/DetailsPage.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/Pages/Importer.dart';
import 'package:alen/ui/SearchDelegates/searchImporters.dart';

import '../../utils/AppColors.dart';

class ImportersPage extends StatelessWidget {
  List<PharmacyServices> pharmacyServices = PharmacyServices.pharmacyServices;
  List<Importer> importers = Importer.importers;

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
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
            elevation: 2,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImportCart()
                      )
                  );
                },
                icon: Icon(
                    Icons.shopping_cart
                ),
              )
            ],
            title: Text("Importers", textAlign: TextAlign.center)),
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
                            showSearch<Importer>(
                                context: context,
                                delegate: ImporterSearch(importers));
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
                                                    color: myCustomColors.loginBackgroud,
                                                    width: 2),
                                              ),
                                              child: SizedBox(
                                                height: 50,
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.search,
                                                    color: myCustomColors.loginBackgroud,
                                                  ),
                                                  title: Text(
                                                    'Search',
                                                    style: TextStyle(
                                                      color: myCustomColors.loginBackgroud,
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
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Top Importers",
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.7,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // GestureDetector(
                              //   onTap: (){
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => SeeAllCategories()
                              //         ));
                              //   },
                              //   child: Text(
                              //     "See All",
                              //     textAlign: TextAlign.left,
                              //     textScaleFactor: 1.3,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: const TextStyle(fontWeight: FontWeight.bold,color: const Color(0xFF9516B6)),
                              //   ),
                              // )
                            ],
                          )),
                      // Container(
                      //     height: 150.0,
                      //     margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (BuildContext ctxt, int index) {
                      //         return _buildTopServicesListItem(
                      //             pharmacyServices[index], ctxt);
                      //       },
                      //       itemCount: pharmacyServices.length,
                      //     )),
                      Container(
                          height: 190.0,
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildImportersListItem(
                                  importers[index], ctxt);
                            },
                            itemCount: importers.length,
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              0,
                              MediaQuery.of(context).size.width * 0.05,
                              0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nearby Services",
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.7,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // GestureDetector(
                              //   onTap: (){
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => SeeAllImporters()
                              //         ));
                              //   },
                              //   child: Text(
                              //     "See All",
                              //     textAlign: TextAlign.left,
                              //     textScaleFactor: 1.3,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: const TextStyle(fontWeight: FontWeight.bold,color: const Color(0xFF9516B6)),
                              //   ),
                              // )
                            ],
                          )),
                      Container(
                          height: 190.0,
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildImportersListItem(
                                  importers[index], ctxt);
                            },
                            itemCount: importers.length,
                          )),

                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  _buildImportersListItem(Importer importer, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => ImporterDetail(
                    title: importer.title,
                    phone: importer.phone,
                    imagesList: importer.imagesList,
                    name: importer.name,
                    description:importer.detail,
                    location: importer.location,
                    info: importer.info,
                    officeHours: importer.officeHours,
                    services: importer.services,
                  )
              ));
        },
        child: Card(
          // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: const Color(0xFFEBEBEB),
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
                      child: Image.asset(importer.imagesList.first,
                          width: 120, height: 120, fit: BoxFit.fill),
                    ),
                  ),
                ),
                Text(
                  importer.name,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  importer.location,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  importer.phone,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  _buildHealthArticlesListItem(Trending trending, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: trending.name,
                    description: trending.detail,
                    imageUrl: trending.imagePath,
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
                        child: Image.asset(trending.imagePath,
                            width: 120, height: 140, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }
  _buildTopServicesListItem(PharmacyServices pharmacyService, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: pharmacyService.name,
                    description: pharmacyService.detail,
                    imageUrl: pharmacyService.imagePath,
                  )));
        },
        child: Card(
            elevation: 14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.hardEdge,
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
                        child: Image.asset(pharmacyService.imagePath,
                            width: 120, height: 140, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }
}
