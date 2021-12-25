import 'package:alen/providers/EmergencyMS.dart';
import 'package:alen/providers/HomeCare.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/ui/Details/DetailForService.dart';
import 'package:alen/ui/Details/NormalDetail.dart';
import 'package:alen/ui/ListInCategoryService/ListInService.dart';
import 'package:alen/ui/Models/Services.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/AppColors.dart';
import 'HospitalDetail.dart';

class EmergencyMSDetail extends StatelessWidget {
  String name;
  String title;
  String image;
  String officeHours;
  List<dynamic> services;
  List<dynamic> images;
  String info;
  String location;
  String description;
  String phone;
  String longtude;
  String latitude;
  String email;
  String locationName;
  List<dynamic> newservices;
  String hospitalId;

  static const myCustomColors = AppColors();

  EmergencyMSDetail(
      {this.name,
        this.title,
        this.description,
        this.image,
        this.locationName,
        this.services,
        this.info,
        this.images,
        this.location,
        this.latitude, this.email, this.longtude,
        this.phone,
        this.officeHours,this.newservices, this.hospitalId});

  double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    // final PageController controller = PageController(initialPage: 0);
    var emergencyMSProvider = Provider.of<EmergencyMSProvider>(context, listen: false);
    // final names = services.map((e) => e['name']).toSet();
    // services.retainWhere((x) => names.remove(x['name']));
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
                title: Text(title),

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
                                future: emergencyMSProvider
                                    .fetchImages(hospitalId),
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
                                    return imageSnapshot.data==null||imageSnapshot.data.length==0?
                                    Container(
                                      height: MediaQuery.of(context).size.width * 0.40,
                                      child: Center(
                                        child: Text(
                                            "Emergency has no images."
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
                                        // return Image.network(
                                        //     imageSnapshot.data[index],
                                        //     fit: BoxFit.cover,
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
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                      name??"Name",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    description??"Description",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 10,
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
                                      'Office Hours',
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
                                          'Phone Number',
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
                                      'Email',
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
                                      email??"Email",
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                    width: screenWidth*0.4,
                                    child: Text(
                                      'Our Location',
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

  _buildHopitalServicesListItem(var hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => NormalDetail(
                    name: hospitalServices.name,
                    imageUrl: hospitalServices.image,
                    description: hospitalServices.description,
                    homeCareId: hospitalServices.serviceId,
                    serviceId: hospitalServices.id,)));
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.network(
                        hospitalServices.image,
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
                  hospitalServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
