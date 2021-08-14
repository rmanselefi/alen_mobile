import 'package:alen/models/user_location.dart';
import 'package:alen/ui/Cart/PharmacyCart.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllCategories.dart';
import 'package:alen/ui/SeeAllPages/SecondPage/SeeAllPharmacies.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:alen/ui/SearchDelegates/searchPharmacies.dart';
import 'package:provider/provider.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/models/pharmacy.dart';

import '../../utils/AppColors.dart';

class PharmaciesPage extends StatelessWidget {
  List<PharmacyServices> pharmacyServices = PharmacyServices.pharmacyServices;
  List<Pharmacy> pharmacies = Pharmacy.pharmacies;
  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
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
            title: Text("Pharmacies", textAlign: TextAlign.center),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 15),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PharmacyCart()
                    )
                );
              },
              icon: Icon(
                  Icons.shopping_cart
              ),
            )
          ],
        ),
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
                        showSearch<Pharmacy>(
                            context: context,
                            delegate: PharmacySearch(pharmacies));
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
                  Divider(
                    color: Colors.black38,
                  ),
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
                            "Top Pharmacies",
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
                      child: FutureBuilder<List<Pharmacies>>(
                          future: pharmacyProvider.fetchTrendingPharmacies() ,
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
                                  return _buildPharmaciesListItem(
                                      snapshot.data[index], ctxt);
                                },
                                itemCount: snapshot.data.length,
                              );
                            }
                          })),
                  Divider(
                    color: Colors.black38,
                  ),
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
                            "Nearby Pharmacies",
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
                          future: pharmacyProvider.getCurrentLocation(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                snapshot.hasData == null) {
                              return CircularProgressIndicator();
                            }
                            return FutureBuilder<List<Pharmacies>>(
                                future: pharmacyProvider
                                    .fetchNearByHospitals(snapshot.data),
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
                                        return _buildPharmaciesListItem(
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

  _buildPharmaciesListItem(Pharmacies pharmacy, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => PharamacyDetail(
                    title: pharmacy.name,
                    phone: pharmacy.phone,
                    imagesList: pharmacy.image,
                    name: pharmacy.name,
                    description:pharmacy.description,
                    location: pharmacy.latitude.toString(),
                    info: "info",
                    officeHours: pharmacy.officehours,
                  ),
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
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: 120,
                    height: 120,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: pharmacy.image != null
                          ? Image.network(pharmacy.image,
                          width: 120, height: 120, fit: BoxFit.fill)
                          : Container(
                        child: Center(
                          child: Text('Image'),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  pharmacy.name,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  pharmacy.latitude.toString(),
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  pharmacy.phone,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  _buildTopServicesListItem(
      PharmacyServices pharmacyService, BuildContext ctxt) {
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
