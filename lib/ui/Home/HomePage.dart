import 'dart:io';

import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllHealthArticles.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllTrendings.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:alen/ui/Models/HealthArticles.dart';
import 'package:alen/ui/Models/MainAd.dart';
import 'package:alen/ui/Models/Services.dart';
import 'package:alen/ui/Models/SmallAd.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/mainPages/DiagnosisesPage.dart';
import 'package:alen/ui/mainPages/HospitalsPage.dart';
import 'package:alen/ui/mainPages/ImportersPage.dart';
import 'package:alen/ui/mainPages/LabsPage.dart';
import 'package:alen/ui/mainPages/PharmaciesPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alen/models/healtharticle.dart';
import 'package:alen/providers/healtharticle.dart';
import 'package:alen/models/drugs.dart';
import '../SearchDelegates/searchTrending.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SmallAd> smallAds = SmallAd.smallAds;
  List<MainAd> mainAds = MainAd.mainAds;
  List<Services> services = Services.services;
  List<Trending> trendings = Trending.trendings;
  List<HealthArticle> healthArticles = HealthArticle.healthArticles;

  static const myCustomColors = AppColors();

  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext ctxt) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }

    }
    );
    _getPresreption(ctxt);
  }

  @override
  Widget build(BuildContext context) {
    var healthProvider = Provider.of<HealthArticleProvider>(context);
    var pharmacyProvider = Provider.of<PharmacyProvider>(context,listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          scaffoldBackgroundColor: myCustomColors.mainBackground,
          appBarTheme: AppBarTheme(
            color: myCustomColors.loginBackgroud,
          )),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Alen"),
          actions: [
            Container(
                child: IconButton(
                  onPressed: () {
                    print("hello");
                    // getImage();
                    _getPresreption(context);
                  },
                  icon: Icon(Icons.attach_file),
                )),
            Container(
                child: IconButton(
                    onPressed: () {},
                    icon: IconButton(
                        onPressed: () => launch("tel://0910111213"),
                        icon: Icon(
                          Icons.call,
                        )))),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      showSearch<Trending>(
                          context: context,
                          delegate: TrendingSearch(trendings));
                    },
                    icon: Icon(
                      Icons.search,
                    )))
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children:<Widget>[
              Expanded(
                // width: MediaQuery.of(context).size.width,
                child:ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    //new Container(child: new DrawerHeader(child: new CircleAvatar()),color: myCustomColors.loginBackgroud,),
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: myCustomColors.loginBackgroud),
                      accountName: Text("User Name"),
                      accountEmail: Text("abhishekm977@gmail.com"),
                      currentAccountPicture: CircleAvatar(
                        //backgroundColor: myCustomColors.loginButton,
                        // child: Text(
                        //   "A",
                        //   style: TextStyle(
                        //       fontSize: 40.0, color: myCustomColors.loginBackgroud),
                        // ),
                        backgroundImage: AssetImage('assets/images/alen_no_name.png'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: Text("Contact Us"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.rate_review),
                      title: Text("Rate Us"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.lock),
                      title: Text("Privacy Policy"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shield),
                      title: Text("Terms & Conditions"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.flag),
                      title: Text("Transactions"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                  ],

                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(MdiIcons.telegram),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(MdiIcons.gmail),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.facebook_outlined),
                  ),
                ],
              )
            ],


          ),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Swiper(
                      autoplayDelay: 6000,
                      itemCount: mainAds.length,
                      layout: SwiperLayout.DEFAULT,
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      pagination: SwiperPagination(),
                      itemBuilder: (context, index) {
                        return _buildMainAdsListItem(mainAds[index], context);
                      },
                      itemHeight: MediaQuery.of(context).size.width * 0.38,
                      itemWidth: MediaQuery.of(context).size.width,
                    ),
                    // child:mainAds.length==0? Center(
                    //   child: Text(
                    //     "No main Ads Available",
                    //   ),)
                    //     : ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   itemBuilder: (BuildContext ctxt, int index) {
                    //     return _buildMainAdsListItem(mainAds[index], ctxt);
                    //   },
                    //   itemCount: mainAds.length-2,
                    // )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 7.0),
                      height: 90.0,
                      child: smallAds.length == 0
                          ? Center(
                              child: Text(
                                "No small Ads Available",
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _buildSmallAdsListItem(
                                    smallAds[index], ctxt);
                              },
                              itemCount: smallAds.length - 1,
                            )),
                  Text(
                    "  Services",
                    textAlign: TextAlign.left,
                    textScaleFactor: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.07),
                      height: 100.0,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HospitalsPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.hospital,
                                      size: 40,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      'Hospitals',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PharmaciesPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.pharmacy,
                                      size: 40,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Pharmacies",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LabsPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.microscope,
                                      size: 40,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Labs",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DiagnosisesPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.diabetes,
                                      size: 40,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Diagnosises",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImportersPage()));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.02),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.import,
                                      size: 40,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Importers",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                        scrollDirection: Axis.horizontal,
                      )),
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
                            "Trending",
                            textAlign: TextAlign.left,
                            textScaleFactor: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Container(
                      // height: 180.0,
                      child: trendings.length == 0
                          ? Center(
                              child: Text(
                                "No Trendings Available",
                              ),
                            )
                          : FutureBuilder<List<Drugs>>(
                              future: pharmacyProvider.fetchTrendingDrugs(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.none &&
                                    snapshot.hasData == null) {
                                  return CircularProgressIndicator();
                                }
                                print('Trendings: ${snapshot.data}');
                                if (snapshot.data == null) {
                                  return Container(
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                } else {
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 160,
                                            childAspectRatio:
                                                (MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait)
                                                    ? 2 / 3
                                                    : 2 / 2.2,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return _buildTrendingsListItem(
                                          snapshot.data[index], ctxt);
                                    },
                                    itemCount: snapshot.data.length,
                                  );
                                }
                              })),
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
                            "Health Articles",
                            textAlign: TextAlign.left,
                            textScaleFactor: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  FutureBuilder<List<HealthArticles>>(
                      future: healthProvider.fetchNearByHospitals(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return CircularProgressIndicator();
                        }
                        print('project snapshot data is: ${snapshot.data}');
                        if (snapshot.data == null) {
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else {
                          return Container(
                            height: 185.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _buildHealthArticlesListItem(
                                    snapshot.data[index], ctxt);
                              },
                              itemCount: snapshot.data.length,
                            ),
                          );
                        }
                      })
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  _buildSmallAdsListItem(SmallAd smallAd, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        name: smallAd.name,
                        description: smallAd.detail,
                        imageUrl: smallAd.imagePath,
                      )));
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 8,
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              width: 160.0,
              child: SizedBox(
                height: 90,
                width: 160,
                child: Image.asset(smallAd.imagePath,
                    width: 200, height: 120, fit: BoxFit.fill),
              ),
            )));
  }

  _getPresreption(BuildContext ctxt) async {
    return showDialog(
        context: ctxt,
        builder: (context) {
          return AlertDialog(
            title: Text('Search by Prescription?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add image of your prescription from your Gallery."),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child:SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: (_image==null)?Image.asset(
                        'assets/images/addPrescription.jpg',
                        fit: BoxFit.fill,
                      ):Image.file(
                        (_image),
                        fit: BoxFit.fill,
                      ),
                    ))
              ],
            ),
            actions: <Widget>[
              new ElevatedButton(
                  child: new Center(
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.attach_file_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add')
                            ])),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ctxt);

                  })
            ],
          );
        });
  }

  _buildMainAdsListItem(MainAd mainAd, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        name: mainAd.name,
                        description: mainAd.detail,
                        imageUrl: mainAd.imagePath,
                      )));
        },
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.38,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(mainAd.imagePath,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.38,
                fit: BoxFit.fill),
          ),
        ));
  }

  _buildTrendingsListItem(Drugs drugs, BuildContext ctxt) {
    print("DrugsDrugsDrugs ${drugs.image}");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => PharamacyDetail(
                        title: drugs.pharmacies.name,
                        phone: drugs.pharmacies.phone,
                        imagesList: drugs.pharmacies.image,
                        name: drugs.pharmacies.name,
                        description: drugs.pharmacies.description,
                        location: drugs.pharmacies.latitude.toString(),
                        officeHours: drugs.pharmacies.officehours,
                      )));
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
                    width: 90,
                    height: 110,
                    child: SizedBox(
                      height: 110,
                      width: 90,
                      child: drugs.image != ''
                          ? Image.network(drugs.image,
                              width: 90, height: 110, fit: BoxFit.fill)
                          : Text('No image'),
                    ),
                  ),
                ),
                Text(
                  drugs.name,
                  maxLines: 2,
                  textScaleFactor: 1.1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  drugs.pharmacies.name,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )));
  }

  _buildHealthArticlesListItem(
      HealthArticles healthArticle, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        name: healthArticle.title,
                        description: healthArticle.description,
                        imageUrl: healthArticle.image,
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
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 150,
                      child: SizedBox(
                        height: 150,
                        width: 120,
                        child: Image.network(healthArticle.image,
                            width: 120, height: 150, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }
}
