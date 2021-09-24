import 'dart:async';
import 'dart:io';

import 'package:alen/models/ads.dart';
import 'package:alen/models/hospital.dart';
import 'package:alen/models/user_location.dart';
import 'package:alen/providers/HomeCare.dart';
import 'package:alen/providers/ads.dart';
import 'package:alen/providers/cart.dart';
import 'package:alen/providers/company.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/importer.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Contact%20Us/ContactUs.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:alen/ui/Privacy%20Policy/PrivacyPolicy.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllHealthArticles.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllTrendings.dart';
import 'package:alen/ui/Terms%20Of%20Use/Terms%20Of%20Use.dart';
import 'package:alen/ui/mainPages/CompaniesPage.dart';
import 'package:alen/ui/mainPages/HomeCaresPage.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/Detail.dart';
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

  ScrollController _scrollController = ScrollController();
  // //
  // _scrollToBottom() {
  //   // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: Duration(seconds: 1),
  //     curve: Curves.fastOutSlowIn,
  //   );
  // }
  _scrollToBottom() {
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // var extent= _scrollController.position.maxScrollExtent;
    var duration= (20/7.0)*_scrollController.position.maxScrollExtent/10;
    _scrollController.animateTo(
      0,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeOutCubic,
    );
    String an="-"+duration.toString();
    print("---------------------");
    print(an);
    print("---------------------");
    double a=double.parse(an);
    print(a.toString());
    print("---------------------");

    // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeOutCubic,
    );
  }
  _launchURL(String url) async {
    // const _url = 'https://helenair.com/news/state-and-regional/govt-and-politics/montanans-find-insurance-alternative-pitfalls-with-health-care-sharing-ministries/article_802af5a3-fc97-56da-8d29-c09d3b1a9ea5.html?campaignid=14250156906&adgroupid=127482060924&adid=538696984263&gclid=CjwKCAjwhOyJBhA4EiwAEcJdcVeRfY_e9Osp3IkQ9ch5lLStx6f46yvNaRMqoEMfmrsNknQrcgxJthoCBFgQAvD_BwE';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


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
    // Timer(
    //   Duration(seconds: 1),
    //       () =>
    //     // _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    //       _scrollController.animateTo(
    //         _scrollController.position.maxScrollExtent,
    //       duration: Duration(seconds: 1),
    //       curve: Curves.fastOutSlowIn,
    //     )
    // );
    var drugProvider = Provider.of<CartProvider>(context,listen: true);
    var healthProvider = Provider.of<HealthArticleProvider>(context,listen: true);
    var adsProvider = Provider.of<AdsProvider>(context,listen: true);
    var pharmacyProvider = Provider.of<PharmacyProvider>(context,listen: true);
    return  Scaffold(
        appBar: AppBar(
          title: Text("Alen"),
          actions: [
            // IconButton(
            //   onPressed: (){
            //     drugProvider.putOnFire();
            //   },
            //   icon: Icon(MdiIcons.plus),
            // ),
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
                    onPressed: () async {
                      UserLocation location = await Provider.of<PharmacyProvider>(context,listen: false).getCurrentLocation();
                      await Provider.of<PharmacyProvider>(context,listen: false).fetchNearByHospitals(location);
                      await Provider.of<HospitalProvider>(context,listen: false).fetchNearByHospitals(location);
                      await Provider.of<DiagnosticProvider>(context,listen: false).fetchNearByDiagnostic(location);
                      await Provider.of<ImporterProvider>(context,listen: false).fetchNearByImporters(location);
                      await Provider.of<LaboratoryProvider>(context,listen: false).fetchNearByLaboratories(location);
                      await Provider.of<CompanyProvider>(context,listen: false).fetchNearByCompanies(location);
                      await Provider.of<HomeCareProvider>(context,listen: false).fetchNearByHomeCare(location);
                      List<HospitalsLabsDiagnostics> hld= [];
                      hld += PharmacyProvider.nearby;
                      hld += ImporterProvider.nearby;
                      hld += PharmacyProvider.trendingDRGS;
                      hld += HospitalProvider.nearby;
                      hld += LaboratoryProvider.nearby;
                      hld += DiagnosticProvider.nearby;
                      hld += HomeCareProvider.nearby;
                      hld += CompanyProvider.nearby;


                      showSearch<HospitalsLabsDiagnostics>(
                          context: context,
                          delegate: TrendingSearch(trendings:hld));
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
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                            'assets/images/alen_no_name.png',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.contacts),
                      title: Text("Contact Us"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactUs()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shield),
                      title: Text("Terms & Conditions"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsOfUse()));
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
                  FutureBuilder<List<Ads>>(
                      future: adsProvider.fetchMainAds(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return Container(
                              height: 90,
                              child:
                              Center(child: CircularProgressIndicator()));
                        }
                        print('project snapshot data is: ${snapshot.data}');
                        if (snapshot.data == null) {
                          return Container(
                              height: 90,
                              child:
                              Center(child: CircularProgressIndicator()));
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            child: snapshot.data.length == 0
                                ? Center(
                              child: Text(
                                "No Main Ads Available",
                              ),
                            )
                                : Swiper(
                              autoplayDelay: 6000,
                              itemCount: snapshot.data.length,
                              layout: SwiperLayout.DEFAULT,
                              scrollDirection: Axis.horizontal,
                              autoplay: true,
                              pagination: SwiperPagination(),
                              itemBuilder: (context, index) {
                                return _buildMainAdsListItem(snapshot.data[index], context);
                              },
                              itemHeight: MediaQuery.of(context).size.width * 0.38,
                              itemWidth: MediaQuery.of(context).size.width,
                            ),
                          );
                        }
                      }),

                  FutureBuilder<List<Ads>>(
                      future: adsProvider.fetchSmallAds(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return Container(
                              height: 90,
                              child:
                              Center(child: CircularProgressIndicator()));
                        }
                        print('project snapshot data is: ${snapshot.data}');
                        if (snapshot.data == null) {
                          return Container(
                            height: 90,
                              child:
                              Center(child: CircularProgressIndicator()));
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 7.0),
                              height: 90.0,
                              child: snapshot.data.length == 0
                                  ? Center(
                                child: Text(
                                  "No small Ads Available",
                                ),
                              )
                                  : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                // reverse: true,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return _buildSmallAdsListItem(
                                      snapshot.data[index], ctxt);
                                },
                                itemCount: snapshot.data.length,
                              ));
                        }
                      }),

                  Text(
                    "  Services",
                    textAlign: TextAlign.left,
                    textScaleFactor: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      height: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    Image.asset(
                                      "assets/images/hospital.png",
                                      width: 60,
                                      height: 60,
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
                                    Image.asset(
                                      "assets/images/lab.png",
                                      width: 60,
                                      height: 60,
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
                                    Image.asset(
                                      "assets/images/importer.png",
                                      width: 60,
                                      height: 60,
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
                                    Image.asset(
                                      "assets/images/pharmacy.png",
                                      width: 60,
                                      height: 60,
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
                        ],
                        // scrollDirection: Axis.horizontal,
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      height: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                                    Image.asset(
                                      "assets/images/diagnostic.png",
                                      width: 60,
                                      height: 60,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Diagnostics",
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
                                      builder: (context) => HomeCaresPage()));
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
                                    Image.asset(
                                      "assets/images/homecare.png",
                                      width: 60,
                                      height: 60,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Home care services",
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
                                      builder: (context) => CompaniesPage()));
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
                                    Image.asset(
                                      "assets/images/company.png",
                                      width: 60,
                                      height: 60,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                    Text(
                                      "Companies",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),

                        ],
                        // scrollDirection: Axis.horizontal,
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
                      child: FutureBuilder<List<Drugs>>(
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
                      future: healthProvider.fetchHealthArticles(),
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
                            height: 158.5,
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
      );
  }

  _buildSmallAdsListItem(var smallAd, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => Detail(
                        name: smallAd.title,
                        description: smallAd.description,
                        imageUrl: smallAd.image,
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
                child: Image.network(smallAd.image,
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

  _buildMainAdsListItem(var mainAd, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => Detail(
                        name: mainAd.title,
                        description: mainAd.description,
                        imageUrl: mainAd.image,
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
            child: Image.network(mainAd.image,
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
                  builder: (context) => (drugs.pharmacies.isPharma)
                      ?
                  PharamacyDetail(
                    title: drugs.pharmacies.name,
                    phone: drugs.pharmacies.phone,
                    imagesList: drugs.pharmacies.image,
                    name: drugs.pharmacies.name,
                    locationName: drugs.pharmacies.locationName,
                    images: drugs.pharmacies.images,
                    email: drugs.pharmacies.email,
                    id: drugs.pharmacies.Id,
                    description: drugs.pharmacies.description,
                    latitude: drugs.pharmacies.latitude.toStringAsFixed(3),
                    longtude: drugs.pharmacies.longitude.toStringAsFixed(3),
                    officeHours: drugs.pharmacies.officehours,
                  )
                      :
                  ImporterDetail(
                    title: drugs.pharmacies.name,
                    phone: drugs.pharmacies.phone,
                    imagesList: drugs.pharmacies.image,
                    name: drugs.pharmacies.name,
                    locationName: drugs.pharmacies.locationName,
                    images: drugs.pharmacies.images,
                    email: drugs.pharmacies.email,
                    id: drugs.pharmacies.Id,
                    description: drugs.pharmacies.description,
                    latitude: drugs.pharmacies.latitude.toStringAsFixed(3),
                    longtude: drugs.pharmacies.longitude.toStringAsFixed(3),
                    officeHours: drugs.pharmacies.officehours,
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
            elevation: 4,
            // elevation: 14,
            child: Container(
              width: 160,
              alignment: Alignment.centerLeft,
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
                      width: 160,
                      height: 110,
                      child: SizedBox(
                        height: 110,
                        width: 160,
                        child: drugs.image != ''
                            ? Image.network(drugs.image,
                            width: 160, height: 120, fit: BoxFit.fill)
                            : Text('No image'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                    child: Text(
                      drugs.name,
                      maxLines: 2,
                      textScaleFactor: 1.1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      drugs.pharmacies.name,
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      // style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
        ));
  }

  _buildHealthArticlesListItem(
      HealthArticles healthArticle, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          _launchURL(healthArticle.link);
          // Navigator.push(
          //     ctxt,
          //     MaterialPageRoute(
          //         builder: (context) => Detail(
          //               name: healthArticle.title,
          //               description: healthArticle.description,
          //               imageUrl: healthArticle.image,
          //             )));
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
