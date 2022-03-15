import 'dart:io';

import 'package:alen/models/company.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/company.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Contact%20Us/ContactUs.dart';
import 'package:alen/ui/Details/catalogueDetail.dart';
import 'package:alen/ui/Privacy%20Policy/PrivacyPolicy.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/languageData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class CompanyDetail extends StatefulWidget {
  final String companyId;

  const CompanyDetail ({ Key key, this.companyId }): super(key: key);


  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  static const myCustomColors = AppColors();
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('pharmacy_id');
    return stringValue;
  }

  // void getHospitalId() {
  //   UserPreferences().getId().then((value) {
  //     setState(() {
  //       hospitalId = value;
  //     });
  //   });
  // }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  launchMailtoWithMyEmail(String email) async {
    final mailtoLink = Mailto(
      to: [email],
      subject: '',
      body: '',
    );
    await launch('$mailtoLink');
  }

  String _lang;
  double screenWidth;
  @override
  Widget build(BuildContext firstParentContext) {
    screenWidth = MediaQuery.of(firstParentContext).size.width;
    var hosProvider = Provider.of<HospitalProvider>(firstParentContext, listen: false);
    var companyProvider = Provider.of<CompanyProvider>(firstParentContext, listen: false);
    var authProvider = Provider.of<AuthProvider>(firstParentContext, listen: false);
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

            return FutureBuilder<Company>(
                future: companyProvider.fetchCompany(widget.companyId),
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
                                        ['Your Company account has no images.'] ??
                                            'Your Company account has no images.'
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
                                        print("-------------------------------");
                                        print(snapshot.data.images.length??"null");
                                        print("-------------------------------");
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
                                          MediaQuery.of(context).size.width * 0.03,
                                          30,
                                          MediaQuery.of(context).size.width * 0.03,
                                          5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            languageData[languageProvider.langOPT]
                                            ['Catalogues'] ??
                                                "Catalogues",
                                            textScaleFactor: 1.5,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder<List<Catalogue>>(
                                        future:
                                        companyProvider.getMyServiceTypes(widget.companyId),
                                        builder: (context, hospServSnapshot) {
                                          if (hospServSnapshot.connectionState ==
                                              ConnectionState.none &&
                                              hospServSnapshot.hasData == null) {
                                            return Container(
                                              height: 110,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                          print(
                                              'project snapshot data is: ${hospServSnapshot.data}');
                                          if (hospServSnapshot.data == null) {
                                            return Container(
                                              height: 110,
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                                height: 110.0,
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context).size.width *
                                                        0.07,
                                                    5,
                                                    MediaQuery.of(context).size.width *
                                                        0.07,
                                                    30),
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder:
                                                      (BuildContext ctxt, int index) {
                                                    print(hospServSnapshot.data[index]);
                                                    return _buildHopitalServicesListItem(
                                                        hospServSnapshot.data[index],
                                                        ctxt,
                                                        widget.companyId);
                                                  },
                                                  itemCount: hospServSnapshot.data.length,
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
                                            // maxLines: 10,
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

  _buildHopitalServicesListItem(
      Catalogue hospitalServices, BuildContext ctxt, String companyId) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => CatalogueDetail(
                      companyId: companyId,
                      name: hospitalServices.name,
                      imageUrl: hospitalServices.image,
                      description: hospitalServices.description,
                      catalogue: hospitalServices.typeName,
                      typeName: hospitalServices.typeName,
                      typeDescription: hospitalServices.typeDescription,
                      typeImageUrl: hospitalServices.typeImage,
                      typeId: hospitalServices.typeId,
                      serviceId: hospitalServices.id)));
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70.0),
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
                  hospitalServices.typeName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
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
}
