import 'package:alen/models/TrendingSearchable.dart';
import 'package:alen/models/diagnostic.dart';
import 'package:alen/models/hospital.dart';
import 'package:alen/models/laboratory.dart';
import 'package:alen/models/user_location.dart';
import 'package:alen/providers/SearchProvider.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/ui/Details/DiagnosticDetail.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/LabDetail.dart';
import 'package:alen/ui/SearchDelegates/searchTrending.dart';
import 'package:alen/ui/SearchDelegates/searchTrending2.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/SeeAllPages/SecondPage/SeeAllHospitals.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:alen/utils/languageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/Pages/Hospital.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppColors.dart';

class DiagnosisesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HospitalPageState();
  }
}

class _HospitalPageState extends State<DiagnosisesPage> {
  List<HospitalServices> hospitalServices = HospitalServices.hospitalServices;
  List<Hospital> hospitals = Hospital.hospitals;

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    var duration= (20/7.0)*_scrollController.position.maxScrollExtent/10;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeOutCubic,
    );
  }

  static const myCustomColors = AppColors();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HospitalProvider().getCurrentLocation();
  }

  Future<void> SearchInitializer() async {

    UserLocation location =
    await Provider.of<SearchProvider>(context, listen: false)
        .getCurrentLocation();

    await Provider.of<SearchProvider>(context, listen: false)
        .fetchAllDiagnosis2(location);

    await Provider.of<SearchProvider>(context, listen: false)
        .getAllSelectedDiagnosticsServicesTypes2();
  }

  @override
  Widget build(BuildContext context) {
    if(SearchProvider.diagnostics2.isEmpty ){
      SearchInitializer();
    }
    // final PageController controller = PageController(initialPage: 0);
    var diagnosticsProvider = Provider.of<DiagnosticProvider>(context, listen: false);
    diagnosticsProvider.getAllSelectedDiagnosticsServicesTypes();
    Future<dynamic> handleExitApp() async{
      Navigator.pop(context, false);
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
                  var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
                  languageProvider.langOPT = _myLanguage;
                  return Scaffold(
                    appBar: AppBar(
                        elevation: 2,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        title: Text(languageData[languageProvider
                            .langOPT]
                        [
                        'Imaging'] ??
                            "Imaging", textAlign: TextAlign.center)),
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
                                        List<TrendingSearchable> hld = [];
                                        hld += SearchProvider.diagnostics2;
                                        hld += SearchProvider.diagnosticServices2;
                                        showSearch<TrendingSearchable>(
                                            context: context,
                                            delegate: TrendingSearch2(trendings: hld, searchFor: "Search Imagings"));
                                        // showSearch<Diagnostics>(
                                        //     context: context,
                                        //     delegate: DiagnosisSearch(diagnosises: DiagnosticProvider.nearby));
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
                                                                languageData[languageProvider
                                                                    .langOPT]
                                                                [
                                                                'Search'] ??
                                                                    "Search",
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
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: Text(
                                              languageData[languageProvider
                                                  .langOPT]
                                              [
                                              'Top Diagnostics'] ??
                                                  "Top Diagnostics",
                                              textAlign: TextAlign.left,
                                              textScaleFactor: 1.7,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                        ],
                                      )),
                                  Container(
                                      height: 190.0,
                                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child: FutureBuilder<List<Diagnostics>>(
                                          future: diagnosticsProvider.fetchTrendingDiagnostic(),
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
                                                  child: Center(child: CircularProgressIndicator())
                                              );
                                            } else {
                                              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                                              return ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                controller: _scrollController,
                                                // reverse: true,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext ctxt, int index) {
                                                  return _buildHospitalsListItem(
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
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.8,
                                            child: Text(
                                              languageData[languageProvider
                                                  .langOPT]
                                              [
                                              'Nearby Diagnostics'] ??
                                                  "Nearby Diagnostics",
                                              textAlign: TextAlign.left,
                                              textScaleFactor: 1.7,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    // height: 190.0,
                                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child: FutureBuilder<UserLocation>(
                                          future: diagnosticsProvider.getCurrentLocation(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.none &&
                                                snapshot.hasData == null) {
                                              return CircularProgressIndicator();
                                            }
                                            return FutureBuilder<List<Diagnostics>>(
                                                future: diagnosticsProvider
                                                    .fetchNearByDiagnostic(snapshot.data),
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
                                                        child: Center(child: CircularProgressIndicator())
                                                    );
                                                  } else {
                                                    return GridView.builder(
                                                      gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent: 160,
                                                          childAspectRatio:
                                                          (MediaQuery.of(context)
                                                              .orientation ==
                                                              Orientation.portrait)
                                                              ? 2 / 3.5
                                                              : 2 / 2.5,
                                                          crossAxisSpacing: 0,
                                                          mainAxisSpacing: 0),
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      scrollDirection: Axis.vertical,
                                                      itemBuilder:
                                                          (BuildContext ctxt, int index) {
                                                        return _buildHospitalsListItem(
                                                            snapshot.data[index], ctxt);
                                                      },
                                                      itemCount: snapshot.data.length,
                                                    );
                                                  }
                                                });
                                          }))
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }
              })
      ),
    );

  }

  _buildHospitalsListItem(var hospital, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DiagnosticDetail(
                    title: hospital.name??"",
                    info: hospital.createdAt.toString()??"",
                    phone: hospital.phone??"",
                    locationName: hospital.locationName??"",
                    latitude: hospital.latitude.toString()??"",
                    longtude: hospital.longitude.toString()??"",
                    email: hospital.email??"",
                    images: hospital.images??[],
                    image: hospital.image??"",
                    name: hospital.name??"",
                    description: hospital.description??"",
                    location: hospital.latitude.toString()??"",
                    services: hospital.services??[],
                    newservices:hospital.services??[],
                    officeHours: hospital.officehours.toString()??"",
                    hospitalId: hospital.Id??"",
                  )));
        },
        child: Card(
          // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Color(0xFFEBEBEB),
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
                      child: hospital.image != null
                          ? Image.network(hospital.image,
                          width: 120, height: 120, fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                            return Image.asset("assets/images/hos1.jpg",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,);
                          }
                      )
                          : Container(
                        child: Center(
                          child: Text('Image'),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  hospital.name??"",
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  hospital.locationName??"",
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  _buildTopServicesListItem(
      Hospitals hospitalService, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: hospitalService.name,
                    description: hospitalService.description,
                    imageUrl: hospitalService.image,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 147,
                      child: SizedBox(
                        height: 147,
                        width: 120,
                        child: Image.network(hospitalService.image,
                            width: 120, height: 147, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }
}
