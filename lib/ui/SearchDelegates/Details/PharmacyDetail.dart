import 'dart:io';

import 'package:alen/models/hospital.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/importer.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Contact%20Us/ContactUs.dart';
import 'package:alen/ui/Details/DetailForService.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/ListInCategoryService/ListInCategory.dart';
import 'package:alen/ui/Privacy%20Policy/PrivacyPolicy.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/languageData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mailto/mailto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyDetail extends StatefulWidget {
  final String pharmacyId;

  const PharmacyDetail ({ Key key, this.pharmacyId }): super(key: key);

  @override
  _PharmacyDetailState createState() => _PharmacyDetailState();
}

class _PharmacyDetailState extends State<PharmacyDetail> {
  static const myCustomColors = AppColors();

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('pharmacy_id');
    return stringValue;
  }

  _launchURL(String url) async {
    // const _url = 'https://helenair.com/news/state-and-regional/govt-and-politics/montanans-find-insurance-alternative-pitfalls-with-health-care-sharing-ministries/article_802af5a3-fc97-56da-8d29-c09d3b1a9ea5.html?campaignid=14250156906&adgroupid=127482060924&adid=538696984263&gclid=CjwKCAjwhOyJBhA4EiwAEcJdcVeRfY_e9Osp3IkQ9ch5lLStx6f46yvNaRMqoEMfmrsNknQrcgxJthoCBFgQAvD_BwE';
    const _url =
        'https://helenair.com/news/state-and-regional/govt-and-politics/montanans-find-insurance-alternative-pitfalls-with-health-care-sharing-ministries/article_802af5a3-fc97-56da-8d29-c09d3b1a9ea5.html?campaignid=14250156906&adgroupid=127482060924&adid=538696984263&gclid=CjwKCAjwhOyJBhA4EiwAEcJdcVeRfY_e9Osp3IkQ9ch5lLStx6f46yvNaRMqoEMfmrsNknQrcgxJthoCBFgQAvD_BwE';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
      throw 'Could not launch $url';
    }
  }


  // void getHospitalId() {
  //   UserPreferences().getId().then((value) {
  //     setState(() {
  //       widget.hospitalId = value;
  //     });
  //   });
  // }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['9484alen@gmail.com'],
      subject: 'Feedback on Alen',
      body: '',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  launchMailtoWithMyEmail(String email) async {
    final mailtoLink = Mailto(
      to: [email],
      subject: '',
      body: '',
    );
    await launch('$mailtoLink');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _lang;
  double screenWidth;
  @override
  Widget build(BuildContext firstParentContext) {
    screenWidth = MediaQuery.of(firstParentContext).size.width;
    var pharmacyProvider =
    Provider.of<PharmacyProvider>(firstParentContext, listen: false);
    var drugProvider = Provider.of<DrugProvider>(firstParentContext);

    Future<dynamic> handleExitApp() async{
      final result= await showDialog(
          context: firstParentContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Do you want to exit the app?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context, false);
                    },
                    child: Text('No')
                ),
                FlatButton(
                    onPressed: (){
                      Navigator.pop(context, true);
                      exit(0);
                    },
                    child: Text('Yes', style: TextStyle(color: Colors.red),)
                )
              ],
            );
          });
      return result;
    }

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
            return FutureBuilder<Pharmacies>(
                future: pharmacyProvider.fetchPharmacy(widget.pharmacyId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  print('project snapshot data is: ${snapshot.data}');
                  if (snapshot.data == null) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(snapshot.data.name??""),
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
                                    snapshot.data.images==null||snapshot.data.images.length==0?
                                    Container(
                                      height: MediaQuery.of(context).size.width * 0.40,
                                      child: Center(
                                        child: Text(
                                            languageData[languageProvider.langOPT]
                                            ['Pharmacy has no images.'] ??
                                                'Pharmacy has no images.'
                                        ),
                                      ),
                                    )
                                        :Swiper(
                                      itemCount: snapshot.data.images.length,
                                      layout: SwiperLayout.STACK,
                                      scrollDirection: Axis.horizontal,
                                      autoplay: true,
                                      pagination: SwiperPagination(
                                        alignment: Alignment.bottomCenter,
                                      ),
                                      itemBuilder: (context, index) {
                                        return _buildMainAdsListItem(
                                            snapshot.data.images[index],
                                            context);
                                        // return Image.network(
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
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                            30,
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                            5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              languageData[languageProvider
                                                  .langOPT]['Categories'] ??
                                                  "Categories",
                                              textScaleFactor: 1.5,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    FutureBuilder<List<Category>>(
                                      // future: drugProvider.getCategoryById(pharmacyId),
                                        future: drugProvider.getCategoryById(
                                            widget.pharmacyId),
                                        builder: (context, hospServSnapshot) {
                                          if (hospServSnapshot.connectionState ==
                                              ConnectionState.none &&
                                              hospServSnapshot.hasData == null) {
                                            return Container(
                                              height: 110,
                                              child: Center(
                                                child:
                                                CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                          print(
                                              'project snapshot data is: ${hospServSnapshot.data}');
                                          if (hospServSnapshot.data == null) {
                                            return Container(
                                              height: 110,
                                              child: Center(
                                                child:
                                                CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                                height: 110.0,
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.07,
                                                    5,
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.07,
                                                    30),
                                                child: ListView.builder(
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemBuilder: (BuildContext ctxt,
                                                      int index) {
                                                    return _buildPharmacyServicesListItem(
                                                        hospServSnapshot
                                                            .data[index],
                                                        ctxt,
                                                        widget.pharmacyId.toString());
                                                  },
                                                  itemCount: hospServSnapshot
                                                      .data.length,
                                                ));
                                          }
                                        }),
                                    Flexible(
                                      child: Text(
                                        snapshot.data.name,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 2,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Text(
                                            snapshot.data.description,
                                            textDirection: TextDirection.ltr,
                                            maxLines: 10,
                                          ),
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.05, top: 10),
                                            width: screenWidth * 0.4,
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
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.05, top: 10),
                                            width: screenWidth * 0.4,
                                            child: Text(
                                              snapshot.data.officehours ?? "Office Hours",
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ]),
                                        GestureDetector(
                                            onTap: () =>
                                                launch("tel://${snapshot.data.phone}"),
                                            child: Column(children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: screenWidth * 0.05, top: 10),
                                                width: screenWidth * 0.4,
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
                                                padding: EdgeInsets.only(
                                                    right: screenWidth * 0.05, top: 10),
                                                width: screenWidth * 0.4,
                                                child: Text(
                                                  snapshot.data.phone ?? "0900000000",
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
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.05, top: 10),
                                            width: screenWidth * 0.4,
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
                                              launchMailtoWithMyEmail(
                                                  snapshot.data.email ?? "");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.05, top: 10),
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                snapshot.data.email ?? "Email",
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ]),
                                        Column(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: screenWidth * 0.05, top: 10),
                                            width: screenWidth * 0.4,
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
                                            padding: EdgeInsets.only(
                                                right: screenWidth * 0.05, top: 10),
                                            width: screenWidth * 0.4,
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      final coords = Coords(
                                                        snapshot.data.latitude,
                                                        snapshot.data.longitude,
                                                      );
                                                      final availableMaps =
                                                      await MapLauncher.installedMaps;
                                                      print(
                                                          availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                                      await availableMaps.first.showMarker(
                                                        coords: coords,
                                                        title: snapshot.data.name,
                                                        description:
                                                        snapshot.data.description,
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
                                                    snapshot.data.locationName ?? "",
                                                    // "${snapshot.data.longitude.toStringAsFixed(2)} - ${snapshot.data.latitude.toStringAsFixed(2)}"??"-",
                                                    maxLines: 3,
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
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
              "assets/images/hos1.jpg",
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
                borderRadius: BorderRadius.circular(70.0),
              ),
              // // c
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70.0),
                child: Image.network(pharmacyServices.image,
                    fit: BoxFit.fitHeight,
                    height: 70.0,
                    width: 70.0, errorBuilder: (BuildContext context,
                        Object exception, StackTrace stackTrace) {
                      return Image.asset(
                        "assets/images/hos1.jpg",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            ),
            Container(
              width: 150,
              child: Text(
                pharmacyServices.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
