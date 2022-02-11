import 'dart:async';
import 'dart:io';
import 'package:alen/Terms%20Of%20Use/Terms%20Of%20Use.dart';
import 'package:alen/main.dart';
import 'package:alen/models/ads.dart';
import 'package:alen/models/hospital.dart';
import 'package:alen/models/user_location.dart';
import 'package:alen/providers/EmergencyMS.dart';
import 'package:alen/providers/HomeCare.dart';
import 'package:alen/providers/ads.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:alen/providers/company.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/importer.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Contact%20Us/ContactUs.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/Details/TransactionDetail.dart';
import 'package:alen/ui/Forms/PhoneForm.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:alen/ui/Privacy%20Policy/PrivacyPolicy.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllHealthArticles.dart';
import 'package:alen/ui/SeeAllPages/Home/SeeAllTrendings.dart';
import 'package:alen/ui/mainPages/CompaniesPage.dart';
import 'package:alen/ui/mainPages/EmergencyMSesPage.dart';
import 'package:alen/ui/mainPages/HomeCaresPage.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/Detail.dart';
// import 'package:alen/utils/image.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:alen/utils/languageData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alen/models/healtharticle.dart';
import 'package:alen/providers/healtharticle.dart';
import 'package:alen/models/drugs.dart';
import '../SearchDelegates/searchTrending.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailto/mailto.dart';
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
  String status = 'add';
  List<HealthArticle> healthArticles = HealthArticle.healthArticles;
  ScrollController _scrollController = ScrollController();
  String _lang;

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
    var duration = (20 / 7.0) * _scrollController.position.maxScrollExtent / 10;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeOutCubic,
    );
  }

  _scrollToEdge() {
    var duration = (20 / 7.0) * _scrollController.position.maxScrollExtent / 10;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeOutCubic,
    );
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

  static const myCustomColors = AppColors();
  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext ctxt) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        status = 'save';
      } else {
        print('No image selected.');
      }
    });
    _getPresreption(ctxt);
  }

  Future<List<Search>> searchInitializer(
      // BuildContext context
      ) async {
    // context.loaderOverlay.show();
    List<HospitalsLabsDiagnostics> hld = [];
    hld += PharmacyProvider.nearby;
    hld += ImporterProvider.nearby;
    hld += PharmacyProvider.trendingDRGS;
    hld += HospitalProvider.nearby;
    hld += LaboratoryProvider.nearby;
    hld += DiagnosticProvider.nearby;
    hld += HomeCareProvider.nearby;
    hld += CompanyProvider.nearby;
    hld += EmergencyMSProvider.nearby;

    // //Services
    hld += LaboratoryProvider.allLabSelectedServiceTypes;
    hld += DiagnosticProvider.allDiagnosisSelectedServiceTypes;
    hld += HospitalProvider.allHospitalSelectedServiceTypes;
    // //drugs
    hld += DrugProvider.allPharmacySelectedDrugs;
    hld += DrugProvider.allImporterSelectedDrugs;
    // // context.loaderOverlay.hide();
    return hld;
  }


  @override
  void didChangeDependencies() async {

    //Location
    UserLocation location =
        await Provider.of<PharmacyProvider>(context, listen: false)
            .getCurrentLocation();

    //Service Providers
    await Provider.of<PharmacyProvider>(context, listen: false)
        .fetchNearByPharmacies(location);
    await Provider.of<HospitalProvider>(context, listen: false)
        .fetchNearByHospitals(location);
    await Provider.of<DiagnosticProvider>(context, listen: false)
        .fetchNearByDiagnostic(location);
    await Provider.of<ImporterProvider>(context, listen: false)
        .fetchNearByImporters(location);
    await Provider.of<LaboratoryProvider>(context, listen: false)
        .fetchNearByLaboratories(location);
    await Provider.of<CompanyProvider>(context, listen: false)
        .fetchNearByCompanies(location);
    await Provider.of<HomeCareProvider>(context, listen: false)
        .fetchNearByHomeCare(location);
    await Provider.of<EmergencyMSProvider>(context, listen: false)
        .fetchNearByEmergencyMS(location);

//Services
    await Provider.of<LaboratoryProvider>(context, listen: false)
        .getAllSelectedLabServiceTypes();
    await Provider.of<DiagnosticProvider>(context, listen: false)
        .getAllSelectedDiagnosticsServicesTypes();
    await Provider.of<HospitalProvider>(context, listen: false)
        .getAllSelectedHospServiceTypes();


// //Drugs
    await Provider.of<DrugProvider>(context, listen: false)
        .getAllPharmacySelectedDrugs();
    await Provider.of<DrugProvider>(context, listen: false)
        .getAllImporterSelectedDrugs();
    //
    // searchInitializer();
    super.didChangeDependencies();
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var fontSize = 15;
    var healthProvider =
        Provider.of<HealthArticleProvider>(context, listen: true);
    var adsProvider = Provider.of<AdsProvider>(context, listen: true);
    var pharmacyProvider = Provider.of<PharmacyProvider>(context, listen: true);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    // search();
    Future<dynamic> handleExitApp() async{
      final result= await showDialog(
          context: context,
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

    return WillPopScope(
      onWillPop:() async => handleExitApp(),
      child: LoaderOverlay(
              overlayOpacity: 0.8,
              child: FutureBuilder<dynamic>(
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
                      var languageProvider =
                      Provider.of<LanguageProvider>(context, listen: true);
                      languageProvider.langOPT = _myLanguage;
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(languageData[languageProvider.langOPT]['Alen']),
                          actions: [
                            Container(
                                child: IconButton(
                                  onPressed: () {
                                    _getPresreption(context);
                                  },
                                  icon: Icon(Icons.attach_file),
                                )),
                            Container(
                                child: IconButton(
                                    onPressed: () => launch("tel://9484"),
                                    icon: Icon(
                                      Icons.call,
                                    ))),
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: IconButton(
                                    onPressed: () async {
                                      // FutureBuilder<List<HospitalsLabsDiagnostics>>(
                                      //     future: searchInitializer(),
                                      //     builder: (context, snapshot) {
                                      //       if (snapshot.connectionState == ConnectionState.none &&
                                      //           snapshot.hasData == null) {
                                      //         return Scaffold(
                                      //             body:
                                      //             Center(child: CircularProgressIndicator()));
                                      //       }
                                      //       print('project snapshot data is: ${snapshot.data}');
                                      //       if (snapshot.data == null) {
                                      //         return Scaffold(
                                      //             body:
                                      //             Center(child: CircularProgressIndicator()));
                                      //       } else {
                                      //         WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                                      //         showSearch<HospitalsLabsDiagnostics>(
                                      //             context: context,
                                      //             delegate: TrendingSearch(trendings:snapshot.data));
                                      //         return Container(
                                      //             );
                                      //       }
                                      //     });
                                      List<HospitalsLabsDiagnostics> hld =
                                      await searchInitializer();
                                      showSearch<HospitalsLabsDiagnostics>(
                                          context: context,
                                          delegate: TrendingSearch(trendings: hld, searchFor: "Search Everything"));
                                    },
                                    icon: Icon(
                                      Icons.search,
                                    )))
                          ],
                        ),
                        drawer: Drawer(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                // width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  // Important: Remove any padding from the ListView.
                                  padding: EdgeInsets.zero,
                                  children: <Widget>[
                                    //new Container(child: new DrawerHeader(child: new CircleAvatar()),color: myCustomColors.loginBackgroud,),
                                    UserAccountsDrawerHeader(
                                      decoration: BoxDecoration(
                                          color: myCustomColors.loginBackgroud),
                                      accountName: FutureBuilder<SharedPreferences>(
                                          future: SharedPreferences.getInstance(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.none &&
                                                snapshot.hasData == null) {
                                              return Container(
                                                  height: 10,
                                                  child: Center(
                                                      child:
                                                      CircularProgressIndicator()));
                                            }
                                            print(
                                                'project snapshot data is: ${snapshot.data}');
                                            if (snapshot.data == null) {
                                              return Container(
                                                  height: 10,
                                                  child: Center(
                                                      child:
                                                      CircularProgressIndicator()));
                                            } else {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (_) => _scrollToBottom());
                                              return snapshot.data
                                                  .getString('first_name') ==
                                                  null
                                                  ? Text(
                                                "User Name",
                                              )
                                                  : Text(snapshot.data
                                                  .getString('first_name'));
                                            }
                                          }),
                                      accountEmail: FutureBuilder<SharedPreferences>(
                                          future: SharedPreferences.getInstance(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.none &&
                                                snapshot.hasData == null) {
                                              return Container(
                                                  height: 10,
                                                  child: Center(
                                                      child:
                                                      CircularProgressIndicator()));
                                            }
                                            print(
                                                'project snapshot data is: ${snapshot.data}');
                                            if (snapshot.data == null) {
                                              return Container(
                                                  height: 10,
                                                  child: Center(
                                                      child:
                                                      CircularProgressIndicator()));
                                            } else {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (_) => _scrollToBottom());
                                              return snapshot.data
                                                  .getString('email') ==
                                                  null
                                                  ? Text(
                                                "9484alen@gmail.com",
                                              )
                                                  : Text(snapshot.data
                                                  .getString('email'));
                                            }
                                          }),
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
                                      leading: Icon(Icons.contacts,
                                          color: myCustomColors.loginBackgroud),
                                      title: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Contact us'] ??
                                              'Contact us'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ContactUs()));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.rate_review,
                                        color: myCustomColors.loginBackgroud,
                                      ),
                                      title: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Rate us']??["Rate Us"]),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _launchURL("https://play.google.com/store/apps/details?id=com.qemer.alen");
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.lock,
                                        color: myCustomColors.loginBackgroud,
                                      ),
                                      title: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Privacy Policy'] ??
                                              "Privacy policy"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrivacyPolicy()));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.shield,
                                        color: myCustomColors.loginBackgroud,
                                      ),
                                      title: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Terms & Conditions'] ??
                                              "Terms & Conditions"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TermsOfUse()));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.flag,
                                        color: myCustomColors.loginBackgroud,
                                      ),
                                      title: Text(
                                          languageData[languageProvider.langOPT]
                                          ['Transactions']),
                                      onTap: () async {
                                        var prefs =
                                        await SharedPreferences.getInstance();
                                        String userId = prefs.getString('user_id');
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionDetail(
                                                        userId: userId)));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.logout,
                                          color: myCustomColors.loginBackgroud),
                                      title: Text(languageData[languageProvider.langOPT]
                                      ['Log Out'] ??
                                          "Log Out"),
                                      onTap: () {
                                        authProvider.signOut();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SignUp(),
                                          ),
                                              (route) => false,
                                        );
                                      },
                                    ),
                                    Row(
                                      children: [
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text("English"),
                                              value: 'en',
                                            ),
                                            PopupMenuItem(
                                              child: Text("አማርኛ"),
                                              value: 'am',
                                            ),
                                            // PopupMenuItem(
                                            //   child: Text("Afaan Oromo"),
                                            //   value: 'or',
                                            // ),
                                            // PopupMenuItem(
                                            //   child: Text("ትግርኛ"),
                                            //   value: 'tg',
                                            // )
                                          ],
                                          initialValue: _lang,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width *
                                                0.5,
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.language,
                                                color: myCustomColors.loginBackgroud,
                                              ),
                                              title: Text(languageData[
                                              languageProvider.langOPT]
                                              ['Language']),
                                            ),
                                          ),
                                          onSelected: (String value) async {
                                            _lang = value;
                                            languageProvider.changeLang(value);
                                            var prefs =
                                            await SharedPreferences.getInstance();
                                            prefs.setString('lang', value);
                                          },
                                        )
                                      ],
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
                                    onPressed: () {
                                      launch("http://t.me/alen9484");
                                    },
                                    icon: Icon(
                                      MdiIcons.telegram,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      launchMailto();
                                    },
                                    icon: Icon(
                                      MdiIcons.gmail,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      launch(
                                          "https://m.facebook.com/Alen%E1%8A%A0%E1%88%88%E1%8A%95-112161981273464/?refid=46&tsid=0.21078368701843675&source=result");
                                    },
                                    icon: Icon(
                                      Icons.facebook_outlined,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                // width: 70,
                                margin: EdgeInsets.symmetric(horizontal:10, vertical:5),
                                child: Text.rich(
                                    TextSpan(
                                      text: 'Qemer Software Technology PLC.',
                                      recognizer: TapGestureRecognizer()..onTap = () => launch("https://www.qemertech.com/"),
                                      style: TextStyle(color: const Color(0xFF00C6db)),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        body: DoubleBackToCloseWidget(
                          child: SingleChildScrollView(
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
                                              if (snapshot.connectionState ==
                                                  ConnectionState.none &&
                                                  snapshot.hasData == null) {
                                                return Container(
                                                    height: 90,
                                                    child: Center(
                                                        child:
                                                        CircularProgressIndicator()));
                                              }
                                              print(
                                                  'project snapshot data is: ${snapshot.data}');
                                              if (snapshot.data == null) {
                                                return Container(
                                                    height: 90,
                                                    child: Center(
                                                        child:
                                                        CircularProgressIndicator()));
                                              } else {
                                                return Container(
                                                  height:
                                                  MediaQuery.of(context).size.width *
                                                      0.4,
                                                  child: snapshot.data.length == 0
                                                      ? Center(
                                                    child: Text(languageData[
                                                    languageProvider
                                                        .langOPT][
                                                    'No Main Ads Available'] ??
                                                        "No Main Ads Available"),
                                                  )
                                                      : Swiper(
                                                    autoplayDelay: 6000,
                                                    itemCount: snapshot.data.length,
                                                    layout: SwiperLayout.DEFAULT,
                                                    scrollDirection: Axis.horizontal,
                                                    autoplay: true,
                                                    pagination: SwiperPagination(),
                                                    itemBuilder: (context, index) {
                                                      return _buildMainAdsListItem(
                                                          snapshot.data[index],
                                                          context);
                                                    },
                                                    itemHeight: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.38,
                                                    itemWidth: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                  ),
                                                );
                                              }
                                            }),
                                        FutureBuilder<List<Ads>>(
                                            future: adsProvider.fetchSmallAds(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.none &&
                                                  snapshot.hasData == null) {
                                                return Container(
                                                    height: 90,
                                                    child: Center(
                                                        child:
                                                        CircularProgressIndicator()));
                                              }
                                              print(
                                                  'project snapshot data is: ${snapshot.data}');
                                              if (snapshot.data == null) {
                                                return Container(
                                                    height: 90,
                                                    child: Center(
                                                        child:
                                                        CircularProgressIndicator()));
                                              } else {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) => _scrollToBottom());
                                                return Container(
                                                    margin:
                                                    EdgeInsets.symmetric(vertical: 7.0),
                                                    height: 90.0,
                                                    child: snapshot.data.length == 0
                                                        ? Center(
                                                      child: Text(languageData[
                                                      languageProvider
                                                          .langOPT][
                                                      'No small Ads Available'] ??
                                                          "No small Ads Available"),
                                                    )
                                                        : ListView.builder(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      controller: _scrollController,
                                                      // reverse: true,
                                                      shrinkWrap: true,
                                                      itemBuilder: (BuildContext ctxt,
                                                          int index) {
                                                        return _buildSmallAdsListItem(
                                                            snapshot.data[index],
                                                            ctxt);
                                                      },
                                                      itemCount: snapshot.data.length,
                                                    ));
                                              }
                                            }),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context).size.width * 0.05,
                                              0,
                                              MediaQuery.of(context).size.width * 0.05,
                                              0),
                                          child: Text(
                                            languageData[languageProvider.langOPT]
                                            ['Services'] ??
                                                "Services",
                                            textAlign: TextAlign.left,
                                            textScaleFactor: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        (screenWidth > 450)
                                            ? Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.04),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PharmaciesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/pharmacy.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT][
                                                                'Pharmacies'] ??
                                                                    "Pharmacies",
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DiagnosisesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/diagnostic.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Imaging'] ?? "Imaging",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    LabsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/lab.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                ['Labs'] ??
                                                                    "Labs",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeCaresPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          // width: MediaQuery.of(context).size.width*0.15,
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            textBaseline: TextBaseline
                                                                .ideographic,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/homecare.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider.langOPT]['HomeCare'] ?? "Home Care",
                                                                  maxLines: 3,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.04),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HospitalsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/hospital.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Health Facilities'] ?? "Health Facilities",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ImportersPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/importer.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT][
                                                                'Importers'] ??
                                                                    "Importers",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    CompaniesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/company.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT][
                                                                'Companies'] ??
                                                                    "Companies",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EmergencyMSesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/emergencyMS.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider
                                                                      .langOPT]
                                                                  [
                                                                  'EmergencyMS'] ??
                                                                      "Emergency",
                                                                  maxLines: 2,
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                          ],
                                        )
                                            : (screenWidth > 350)
                                            ? Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.04),
                                                height: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PharmaciesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/pharmacy.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Pharmacies'] ??
                                                                    "Pharmacies",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DiagnosisesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/diagnostic.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Imaging'] ?? "Imaging",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    LabsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/lab.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Labs'] ??
                                                                    "Labs",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeCaresPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          // width: MediaQuery.of(context).size.width*0.15,
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            textBaseline:
                                                            TextBaseline
                                                                .ideographic,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/homecare.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider.langOPT]['HomeCare'] ?? "Home Care",
                                                                  maxLines: 3,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                    fontSize: 10,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HospitalsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/hospital.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Health Facilities'] ?? "Health Facilities",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ImportersPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/importer.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Importers'] ??
                                                                    "Importers",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    CompaniesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/company.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Companies'] ??
                                                                    "Companies",
                                                                style: const TextStyle(
                                                                  fontSize: 10,
                                                                  // fontWeight:
                                                                  //     FontWeight
                                                                  //         .bold
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EmergencyMSesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/emergencyMS.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider
                                                                      .langOPT]
                                                                  [
                                                                  'EmergencyMS'] ??
                                                                      "Emergency",
                                                                  maxLines: 2,
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                    fontSize: 10,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                          ],
                                        )
                                            : Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.04),
                                                height: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PharmaciesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/pharmacy.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Pharmacies'] ??
                                                                    "Pharmacies",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DiagnosisesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/diagnostic.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Imaging'] ?? "Imaging",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    LabsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/lab.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Labs'] ??
                                                                    "Labs",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeCaresPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          // width: MediaQuery.of(context).size.width*0.15,
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            textBaseline:
                                                            TextBaseline
                                                                .ideographic,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/homecare.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider.langOPT]['HomeCare'] ?? "Home Care",
                                                                  maxLines: 3,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                      fontSize: 5,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                height: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HospitalsPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/hospital.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider.langOPT]['Health Facilities'] ?? "Health Facilities",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ImportersPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/importer.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Importers'] ??
                                                                    "Importers",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                height: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    CompaniesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/company.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Text(
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Companies'] ??
                                                                    "Companies",
                                                                style: const TextStyle(
                                                                    fontSize: 5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EmergencyMSesPage()));
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                "assets/images/emergencyMS.png",
                                                                width: 60,
                                                                height: 60,
                                                                color: myCustomColors
                                                                    .loginBackgroud,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.18,
                                                                child: Text(
                                                                  languageData[languageProvider
                                                                      .langOPT]
                                                                  [
                                                                  'EmergencyMS'] ??
                                                                      "Emergency",
                                                                  maxLines: 2,
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                                  style: const TextStyle(
                                                                      fontSize: 5,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                  // scrollDirection: Axis.horizontal,
                                                )),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context).size.width * 0.05,
                                                0,
                                                MediaQuery.of(context).size.width * 0.05,
                                                0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  languageData[languageProvider.langOPT]
                                                  ['Trending'] ??
                                                      "Trending",
                                                  textAlign: TextAlign.left,
                                                  textScaleFactor: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          // height: 180.0,
                                            child: FutureBuilder<List<Drugs>>(
                                                future:
                                                pharmacyProvider.fetchTrendingDrugs(),
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
                                                            child:
                                                            CircularProgressIndicator()));
                                                  } else {
                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      child: GridView.builder(
                                                        gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                          // maxCrossAxisExtent: 160,
                                                            crossAxisCount: 3,
                                                            childAspectRatio: (MediaQuery
                                                                .of(context)
                                                                .orientation ==
                                                                Orientation
                                                                    .portrait)
                                                                ? 2 / 3
                                                                : 2 / 2.2,
                                                            crossAxisSpacing: 10,
                                                            mainAxisSpacing: 10),
                                                        shrinkWrap: true,
                                                        physics:
                                                        NeverScrollableScrollPhysics(),
                                                        scrollDirection: Axis.vertical,
                                                        itemBuilder:
                                                            (BuildContext ctxt, int index) {
                                                          return _buildTrendingsListItem(
                                                              snapshot.data[index], ctxt);
                                                        },
                                                        itemCount: snapshot.data.length,
                                                      ),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  languageData[languageProvider.langOPT]
                                                  ['Health Articles'] ??
                                                      "Health Articles",
                                                  textAlign: TextAlign.left,
                                                  textScaleFactor: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                        FutureBuilder<List<HealthArticles>>(
                                            future: healthProvider.fetchHealthArticles(),
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
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) => _scrollToEdge());
                                                return Container(
                                                  height: 158.5,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext ctxt, int index) {
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
                  })
      ),
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
                child: CachedNetworkImage(
                    imageUrl:smallAd.image,
                    width: 160,
                    height: 90,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        Image.asset(
                          "assets/images/hos1.jpg",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.38,
                          fit: BoxFit.cover,
                        )),
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
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: (_image == null)
                            ? Image.asset(
                                'assets/images/addPrescription.jpg',
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                (_image),
                                fit: BoxFit.fill,
                              ),
                      )),
                )
              ],
            ),
            actions: <Widget>[
              new ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          myCustomColors.loginBackgroud),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color:
                                  myCustomColors.loginBackgroud)))),
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
                              Text(status == 'add' ? 'Add Prescription' : 'Save Prescription')
                        ])),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    // getImage(ctxt);
                    if (status == 'add') {
                      Navigator.pop(context);
                      getImage(ctxt);
                    } else {
                      CartProvider().addPrescriptionToCart(_image);
                      // _image=null;
                      // status='add';
                      Navigator.pop(context);
                    }
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
            child: CachedNetworkImage(
              imageUrl: mainAd.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.38,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) =>
                Image.asset(
                  "assets/images/hos1.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.38,
                  fit: BoxFit.cover,
                )
              ,
            ),
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
                      ? PharamacyDetail(
                          title: drugs.pharmacies.name,
                          phone: drugs.pharmacies.phone,
                          imagesList: drugs.pharmacies.image,
                          name: drugs.pharmacies.name,
                          locationName: drugs.pharmacies.locationName,
                          images: drugs.pharmacies.images,
                          email: drugs.pharmacies.email,
                          id: drugs.pharmacies.Id,
                          description: drugs.pharmacies.description,
                          latitude:
                              drugs.pharmacies.latitude.toStringAsFixed(3),
                          longtude:
                              drugs.pharmacies.longitude.toStringAsFixed(3),
                          officeHours: drugs.pharmacies.officehours,
                        )
                      : ImporterDetail(
                          title: drugs.pharmacies.name,
                          phone: drugs.pharmacies.phone,
                          imagesList: drugs.pharmacies.image,
                          name: drugs.pharmacies.name,
                          locationName: drugs.pharmacies.locationName,
                          images: drugs.pharmacies.images,
                          email: drugs.pharmacies.email,
                          id: drugs.pharmacies.Id,
                          description: drugs.pharmacies.description,
                          latitude:
                              drugs.pharmacies.latitude.toStringAsFixed(3),
                          longtude:
                              drugs.pharmacies.longitude.toStringAsFixed(3),
                          officeHours: drugs.pharmacies.officehours,
                        )));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            child: Container(
                width: MediaQuery.of(ctxt).size.width * 2.5 / 9,
                height: MediaQuery.of(ctxt).size.height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Center(
                              child: CachedNetworkImage(
                                  imageUrl:drugs.image,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        "assets/images/hos1.jpg",
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.width * 0.38,
                                        fit: BoxFit.cover,
                                      ))),
                        ),
                        Divider(
                          color: Colors.black12,
                        ),
                        // SizedBox(height: 5,),
                        Text(
                          drugs.name,
                          maxLines: 2,
                          textScaleFactor: 1.1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          drugs.pharmacies.name,
                          maxLines: 1,
                          textScaleFactor: 0.9,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          // style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
          ),
        )
        // Card(
        //
        //     // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        //     // color: myCustomColors.cardBackgroud,
        //     color: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     clipBehavior: Clip.hardEdge,
        //     // elevation: 4,
        //     // elevation: 14,
        //     child: Container(
        //       width: 160,
        //       alignment: Alignment.centerLeft,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         mainAxisSize: MainAxisSize.max,
        //         children: <Widget>[
        //           Card(
        //             // elevation: 8,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(8.0),
        //             ),
        //
        //             clipBehavior: Clip.hardEdge,
        //             child: Container(
        //               width: 160,
        //               height: 110,
        //               child: SizedBox(
        //                 height: 110,
        //                 width: 160,
        //                 child: drugs.image != ''
        //                     ? Image.network(drugs.image,
        //                         width: 160, height: 120, fit: BoxFit.fill)
        //                     : Text('No image'),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
        //             child: Text(
        //               drugs.name,
        //               maxLines: 2,
        //               textScaleFactor: 1.1,
        //               softWrap: false,
        //               overflow: TextOverflow.ellipsis,
        //               textAlign: TextAlign.center,
        //               style: const TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 5),
        //             child: Text(
        //               drugs.pharmacies.name,
        //               maxLines: 1,
        //               softWrap: false,
        //               overflow: TextOverflow.ellipsis,
        //               textAlign: TextAlign.center,
        //               // style: const TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ))
        );
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
                        child: CachedNetworkImage(
                            imageUrl:healthArticle.image,
                            width: 120, height: 150, fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                Image.asset(
                                  "assets/images/hos1.jpg",
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width * 0.38,
                                  fit: BoxFit.cover,
                                )),
                      ),
                    ),
                  ],
                ))));
  }
}

class DoubleBackToCloseWidget extends StatefulWidget {
  final Widget child; // Make Sure this child has a Scaffold widget as parent.

  const DoubleBackToCloseWidget({
    @required this.child,
  });

  @override
  _DoubleBackToCloseWidgetState createState() =>
      _DoubleBackToCloseWidgetState();
}

class _DoubleBackToCloseWidgetState extends State<DoubleBackToCloseWidget> {
  int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final _currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_lastTimeBackButtonWasTapped != null &&
        (_currentTime - _lastTimeBackButtonWasTapped) < exitTimeInMillis) {
      Scaffold.of(context).removeCurrentSnackBar();
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        _getExitSnackBar(context),
      );
      return false;
    }
  }

  SnackBar _getExitSnackBar(
      BuildContext context,
      ) {
    return SnackBar(
      content: Text(
        'Press BACK again to exit!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Detail.myCustomColors.loginBackgroud,
      duration: const Duration(
        seconds: 4,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
}

