import 'package:alen/models/drugs.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Cart/PharmacyCart.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/ui/ListInCategoryService/ListInCategory.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllCategories.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:alen/utils/languageData.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mailto/mailto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../utils/AppColors.dart';
import 'DetailForDrug.dart';

class PharamacyDetail extends StatelessWidget {
  String id;
  String name;
  String title;
  String imagesList;
  String officeHours;
  List<PharmacyServices> services;
  String longtude;
  String latitude;
  String email;
  String description;
  String locationName;

  String phone;
  List<dynamic> images;

  static const myCustomColors = AppColors();

  PharamacyDetail(
      {this.id,
      this.name,
      this.title,
      this.description,
      this.imagesList,
      this.services,
      this.longtude,
      this.locationName,
      this.latitude,
      this.phone,
        this.email,
        this.images,
      this.officeHours});

  double screenWidth;

  launchMailtoWithMyEmail(String email) async {
    final mailtoLink = Mailto(
      to: [email],
      subject: '',
      body: '',
    );
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    screenWidth = MediaQuery.of(context).size.width;
    var drugProvider = Provider.of<DrugProvider>(context);
    var pharmaProvider = Provider.of<PharmacyProvider>(context);
    return FutureBuilder<dynamic>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          print('project snapshot data is: ${snapshot.data}');
          if (snapshot.data == null) {
            return Container(
                child: Center(child: CircularProgressIndicator()));
          } else {
            var _myLanguage = snapshot.data.getString("lang");
            var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
            languageProvider.langOPT = _myLanguage;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
                title: Text(name),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FutureBuilder<List<dynamic>>(
                                future: pharmaProvider
                                    .fetchImages(id),
                                builder: (context, imageSnapshot) {
                                  if (imageSnapshot.connectionState ==
                                      ConnectionState.none &&
                                      imageSnapshot.hasData == null) {
                                    return Container(
                                      height: 110,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  print(
                                      'project snapshot data is: ${imageSnapshot.data}');
                                  if (imageSnapshot.data == null) {
                                    return Container(
                                      height: 110,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else {
                                    return
                                      imageSnapshot.data==null||imageSnapshot.data.length==0?
                                      Container(
                                        height: MediaQuery.of(context).size.width * 0.40,
                                        child: Center(
                                          child: Text(
                                              "Pharmacy has no images."
                                          ),
                                        ),
                                      ):Swiper(
                                      itemCount: imageSnapshot.data.length ?? 0,
                                      layout: SwiperLayout.STACK,
                                      scrollDirection: Axis.horizontal,
                                      autoplay: true,
                                      pagination: SwiperPagination(
                                        alignment: Alignment.bottomCenter,
                                      ),
                                      itemBuilder: (context, index) {
                                        return _buildMainAdsListItem(
                                            imageSnapshot.data[index],
                                            context);
                                        // Image.network(
                                        //   imageSnapshot.data[index],
                                        //   fit: BoxFit.cover,
                                        //     errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                        //       return Image.asset("assets/images/hos1.jpg",
                                        //         fit: BoxFit.cover,);
                                        //     }
                                        // );
                                      },
                                      itemHeight:
                                      MediaQuery.of(context).size.width * 0.40,
                                      itemWidth: MediaQuery.of(context).size.width,
                                    );
                                  }
                                }),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.07,
                                    30,
                                    MediaQuery.of(context).size.width * 0.07,
                                    5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      languageData[languageProvider.langOPT]
                                      ['Categories'] ??
                                          "Categories",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Container(
                                height: 110.0,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.03,
                                    5,
                                    MediaQuery.of(context).size.width * 0.03,
                                    30),
                                child: FutureBuilder<List<Category>>(
                                    future: drugProvider.getCategoryById(id),
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
                                                child: CircularProgressIndicator()));
                                      } else {
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext ctxt, int index) {
                                            return _buildPharmacyServicesListItem(
                                                snapshot.data[index],
                                                ctxt,
                                                id
                                            );
                                          },
                                          itemCount: snapshot.data.length,
                                        );
                                      }
                                    })),
                            Container(
                                padding: EdgeInsets.only(top: 10, bottom: 30),
                                width: MediaQuery.of(context).size.width*0.8,
                                child: Center(
                                    child: Text(
                                      name??"",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    description??"Description",
                                    textDirection: TextDirection.ltr,
                                   // maxLines: 10,
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Text(
                                      languageData[languageProvider.langOPT]
                                      ['Office Hours'] ??
                                          "Office Hours",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Text(
                                      officeHours??"Office Hours",
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                                GestureDetector(
                                    onTap: () =>
                                        launch("tel://$phone"),
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                        width: screenWidth*0.4,
                                        child: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Phone Number'] ??
                                              "Phone Number",
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                        width: screenWidth*0.4,
                                        child: Text(
                                          phone??"0900000000",
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Text(
                                      languageData[languageProvider.langOPT]
                                      ['Email'] ??
                                          "Email",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      launchMailtoWithMyEmail(email??"");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                                      width: screenWidth*0.4,
                                      child: Text(
                                        email??"Email",
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Text(
                                      languageData[languageProvider.langOPT]
                                      ['Our Location'] ??
                                          "Our Location",
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    // width: 150,
                                    padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                            onPressed: ()async{
                                              final coords = Coords(
                                                double.parse(latitude),
                                                double.parse(longtude),
                                              );
                                              final availableMaps = await MapLauncher.installedMaps;
                                              print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                              await availableMaps.first.showMarker(
                                                coords: coords,
                                                title: name,
                                                description: description,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.location_pin,
                                              color: myCustomColors.loginBackgroud,
                                            ),
                                          ),
                                        ),
                                    Container(
                                      width: screenWidth * 0.2,
                                      child: Text(
                                        locationName ?? "",
                                        // "${snapshot.data.longitude.toStringAsFixed(2)} - ${snapshot.data.latitude.toStringAsFixed(2)}"??"-",
                                        maxLines: 3,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                      ],
                                    ),
                                    // child: Text(
                                    //   "${snapshot.data.longitude.toStringAsFixed(2)} - ${snapshot.data.latitude.toStringAsFixed(2)}"??"-",
                                    //   maxLines: 3,
                                    //   textAlign: TextAlign.left,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ),
                                ])
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            );
          }
        });
  }

  _buildMainAdsListItem(var pharmacyImage, BuildContext ctxt) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: MediaQuery.of(ctxt).size.width * 0.38,
        width: MediaQuery.of(ctxt).size.width,
        child: Image.network(
          pharmacyImage,
          width: MediaQuery.of(ctxt).size.width,
          height: MediaQuery.of(ctxt).size.width * 0.38,
          fit: BoxFit.fill,
          errorBuilder: (BuildContext context, Object exception,
              StackTrace stackTrace) {
            return Image.asset(
              "assets/images/hos1.png",
              width: MediaQuery.of(ctxt).size.width,
              height: MediaQuery.of(ctxt).size.width * 0.38,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  _buildPharmacyServicesListItem(
      var pharmacyServices, BuildContext ctxt, String pharmacyId) {
    return GestureDetector(
        onTap: () {
          print("On tap");
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => ListInCategories(
                    category: pharmacyServices,
                    id: pharmacyId,
                    isPharma: true,
                  )));
        },
        child: Card(
            elevation: 0,
            color: myCustomColors.mainBackground,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.0),
                  ),
                  // // c
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.network(
                      pharmacyServices.image,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                          return Image.asset("assets/images/hos1.jpg",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,);
                        }
                    ),
                  ),
                ),
                Text(
                  pharmacyServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
