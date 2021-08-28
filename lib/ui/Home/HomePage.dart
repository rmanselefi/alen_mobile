// import 'dart:io';
//
// import 'package:alen_client/Details/ImporterDetail.dart';
// import 'package:alen_client/Details/PharmacyDetail.dart';
// import 'package:alen_client/Pages/Pharmacy.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:alen_client/DetailsPage.dart';
// import 'package:alen_client/Models/HealthArticles.dart';
// import 'package:alen_client/Models/MainAd.dart';
// import 'package:alen_client/Models/Services.dart';
// import 'package:alen_client/Models/SmallAd.dart';
// import 'package:alen_client/Models/Trending.dart';
// import 'package:alen_client/mainPages/DiagnosisesPage.dart';
// import 'package:alen_client/mainPages/HospitalsPage.dart';
// import 'package:alen_client/mainPages/ImportersPage.dart';
// import 'package:alen_client/mainPages/LabsPage.dart';
// import 'package:alen_client/mainPages/PharmaciesPage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../AppColors.dart';
// import '../SearchDelegates/searchTrending.dart';
//
// //https://www.youtube.com/watch?v=CSa6Ocyog4U
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final imageList = [
//     'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
//     'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
//     'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
//     'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Swiper(
//           layout: SwiperLayout.STACK,
//           itemCount: imageList.length,
//           itemBuilder: (context, index) {
//             return Image.network(
//               imageList[index],
//               fit: BoxFit.cover,
//             );
//           },
//           itemWidth: 300.0,
//           itemHeight: 300.0,
//         ),
//       ),
//     );
//   }
// } //release/flutter deligate
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<SmallAd> smallAds = SmallAd.smallAds;
//   List<MainAd> mainAds = MainAd.mainAds;
//   List<Services> services = Services.services;
//   List<Trending> trendings = Trending.trendings;
//   List<HealthArticle> healthArticles = HealthArticle.healthArticles;
//   File? imageFile;
//
//   static const myCustomColors = AppColors();
//
//   File? _image;
//   final picker = ImagePicker();
//
//   Future getImage(BuildContext ctxt) async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//
//     }
//     );
//     _getPresreption(ctxt);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final PageController controller = PageController(initialPage: 0);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           fontFamily: 'Ubuntu',
//           scaffoldBackgroundColor: myCustomColors.mainBackground,
//           appBarTheme: AppBarTheme(
//             color: myCustomColors.loginBackgroud,
//           )),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Alen"),
//           actions: [
//             Container(
//                 child: IconButton(
//               onPressed: () {
//                 print("hello");
//                 // getImage();
//                 _getPresreption(context);
//               },
//               icon: Icon(Icons.attach_file),
//             )),
//             Container(
//                 child: IconButton(
//                     onPressed: () => launch("tel://0910111213"),
//                     icon: Icon(
//                       Icons.call,
//                     ))),
//             Container(
//                 margin: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                     onPressed: () {
//                       showSearch<Trending>(
//                           context: context,
//                           delegate: TrendingSearch(trendings));
//                     },
//                     icon: Icon(
//                       Icons.search,
//                     )))
//           ],
//         ),
//         drawer: Drawer(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children:<Widget>[
//               Expanded(
//           // width: MediaQuery.of(context).size.width,
//           child:ListView(
//                 // Important: Remove any padding from the ListView.
//                 padding: EdgeInsets.zero,
//                 children: <Widget>[
//                   //new Container(child: new DrawerHeader(child: new CircleAvatar()),color: myCustomColors.loginBackgroud,),
//                   UserAccountsDrawerHeader(
//                     decoration: BoxDecoration(color: myCustomColors.loginBackgroud),
//                     accountName: Text("User Name"),
//                     accountEmail: Text("abhishekm977@gmail.com"),
//                     currentAccountPicture: CircleAvatar(
//                       //backgroundColor: myCustomColors.loginButton,
//                       // child: Text(
//                       //   "A",
//                       //   style: TextStyle(
//                       //       fontSize: 40.0, color: myCustomColors.loginBackgroud),
//                       // ),
//                       backgroundImage: AssetImage('assets/images/alen_no_name.png'),
//                     ),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.contacts),
//                     title: Text("Contact Us"),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.rate_review),
//                     title: Text("Rate Us"),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.lock),
//                     title: Text("Privacy Policy"),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.shield),
//                     title: Text("Terms & Conditions"),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.flag),
//                     title: Text("Transactions"),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Divider(),
//                 ],
//
//               ),
//               ),
//               Divider(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: (){},
//                         icon: Icon(MdiIcons.telegram),
//                       ),
//                       IconButton(
//                         onPressed: (){},
//                         icon: Icon(MdiIcons.gmail),
//                       ),
//                       IconButton(
//                         onPressed: (){},
//                         icon: Icon(Icons.facebook_outlined),
//                       ),
//                     ],
//                   )
//                 ],
//
//
//           ),
//         ),
//         body: SingleChildScrollView(
//             child: Stack(
//           children: <Widget>[
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     height: MediaQuery.of(context).size.width * 0.4,
//                     child: Swiper(
//                       autoplayDelay: 6000,
//                       itemCount: mainAds.length,
//                       layout: SwiperLayout.DEFAULT,
//                       scrollDirection: Axis.horizontal,
//                       autoplay: true,
//                       pagination: SwiperPagination(),
//                       itemBuilder: (context, index) {
//                         return _buildMainAdsListItem(mainAds[index], context);
//                       },
//                       itemHeight: MediaQuery.of(context).size.width * 0.38,
//                       itemWidth: MediaQuery.of(context).size.width,
//                     ),
//                     // child:mainAds.length==0? Center(
//                     //   child: Text(
//                     //     "No main Ads Available",
//                     //   ),)
//                     //     : ListView.builder(
//                     //   scrollDirection: Axis.horizontal,
//                     //   itemBuilder: (BuildContext ctxt, int index) {
//                     //     return _buildMainAdsListItem(mainAds[index], ctxt);
//                     //   },
//                     //   itemCount: mainAds.length-2,
//                     // )
//                   ),
//                   Container(
//                       margin: EdgeInsets.symmetric(vertical: 7.0),
//                       height: 90.0,
//                       child: smallAds.length == 0
//                           ? Center(
//                               child: Text(
//                                 "No small Ads Available",
//                               ),
//                             )
//                           : ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (BuildContext ctxt, int index) {
//                                 return _buildSmallAdsListItem(
//                                     smallAds[index], ctxt);
//                               },
//                               itemCount: smallAds.length,
//                             )),
//                   Text(
//                     "  Services",
//                     textAlign: TextAlign.left,
//                     textScaleFactor: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: MediaQuery.of(context).size.width * 0.07),
//                       height: 100.0,
//                       child: ListView(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => HospitalsPage()));
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.02),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[
//                                     Icon(
//                                       MdiIcons.hospital,
//                                       size: 40,
//                                       color: myCustomColors.loginBackgroud,
//                                     ),
//                                     Text(
//                                       'Hospitals',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 )),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PharmaciesPage()));
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.02),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[
//                                     Icon(
//                                       MdiIcons.pharmacy,
//                                       size: 40,
//                                       color: myCustomColors.loginBackgroud,
//                                     ),
//                                     Text(
//                                       "Pharmacies",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 )),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LabsPage()));
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.02),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[
//                                     Icon(
//                                       MdiIcons.microscope,
//                                       size: 40,
//                                       color: myCustomColors.loginBackgroud,
//                                     ),
//                                     Text(
//                                       "Labs",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 )),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DiagnosisesPage()));
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.02),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[
//                                     Icon(
//                                       MdiIcons.diabetes,
//                                       size: 40,
//                                       color: myCustomColors.loginBackgroud,
//                                     ),
//                                     Text(
//                                       "Diagnosises",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 )),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ImportersPage()));
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.02),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[
//                                     Icon(
//                                       MdiIcons.import,
//                                       size: 40,
//                                       color: myCustomColors.loginBackgroud,
//                                     ),
//                                     Text(
//                                       "Importers",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 )),
//                           ),
//                         ],
//                         scrollDirection: Axis.horizontal,
//                       )),
//                   Container(
//                       margin: EdgeInsets.fromLTRB(
//                           MediaQuery.of(context).size.width * 0.05,
//                           0,
//                           MediaQuery.of(context).size.width * 0.05,
//                           0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Trending",
//                             textAlign: TextAlign.left,
//                             textScaleFactor: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           // GestureDetector(
//                           //   onTap: (){
//                           //     Navigator.push(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (context) => SeeAllTrendings()
//                           //         ));
//                           //   },
//                           //   child: Text(
//                           //     "See All",
//                           //     textAlign: TextAlign.left,
//                           //     textScaleFactor: 1.5,
//                           //     overflow: TextOverflow.ellipsis,
//                           //     style: const TextStyle(fontWeight: FontWeight.bold,color: const Color(0xFF9516B6)),
//                           //   ),
//                           // )
//                         ],
//                       )),
//                   Container(
//                       // height: 180.0,
//                       child: trendings.length == 0
//                           ? Center(
//                               child: Text(
//                                 "No Trendings Available",
//                               ),
//                             )
//                           : GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithMaxCrossAxisExtent(
//                                       maxCrossAxisExtent: 160,
//                                       childAspectRatio:
//                                           (MediaQuery.of(context).orientation ==
//                                                   Orientation.portrait)
//                                               ? 2 / 3.65
//                                               : 2 / 3.2,
//                                       crossAxisSpacing: 0,
//                                       mainAxisSpacing: 0),
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               itemBuilder: (BuildContext ctxt, int index) {
//                                 return _buildTrendingsListItem(
//                                     trendings[index], ctxt);
//                               },
//                               itemCount: trendings.length,
//                             )),
//                   Container(
//                       margin: EdgeInsets.fromLTRB(
//                           MediaQuery.of(context).size.width * 0.05,
//                           0,
//                           MediaQuery.of(context).size.width * 0.05,
//                           0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Health Articles",
//                             textAlign: TextAlign.left,
//                             textScaleFactor: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           // GestureDetector(
//                           //   onTap: (){
//                           //     Navigator.push(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (context) => SeeAllHealthArticles()
//                           //         ));
//                           //   },
//                           //   child: Text(
//                           //     "See All",
//                           //     textAlign: TextAlign.left,
//                           //     textScaleFactor: 1.3,
//                           //     overflow: TextOverflow.ellipsis,
//                           //     style: const TextStyle(fontWeight: FontWeight.bold,color: const Color(0xFF9516B6)),
//                           //   ),
//                           // )
//                         ],
//                       )),
//                   Container(
//                       height: 158.5,
//                       child: healthArticles.length == 0
//                           ? Center(
//                               child: Text(
//                                 "No Health Articles Available",
//                               ),
//                             )
//                           : ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (BuildContext ctxt, int index) {
//                                 return _buildHealthArticlesListItem(
//                                     healthArticles[index], ctxt);
//                               },
//                               itemCount: healthArticles.length,
//                             )),
//                 ],
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }
//
//   _buildSmallAdsListItem(SmallAd smallAd, BuildContext ctxt) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               ctxt,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(
//                         name: smallAd.name,
//                         description: smallAd.detail,
//                         imageUrl: smallAd.imagePath,
//                       )));
//         },
//         child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             clipBehavior: Clip.hardEdge,
//             elevation: 8,
//             child: Container(
//               // margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
//               width: 160.0,
//               child: SizedBox(
//                 height: 90,
//                 width: 160,
//                 child: Image.asset(smallAd.imagePath,
//                     width: 200, height: 120, fit: BoxFit.fill),
//               ),
//             )));
//   }
//
//   _buildMainAdsListItem(MainAd mainAd, BuildContext ctxt) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               ctxt,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(
//                         name: mainAd.name,
//                         description: mainAd.detail,
//                         imageUrl: mainAd.imagePath,
//                       )));
//         },
//         child: Card(
//           elevation: 15,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           clipBehavior: Clip.hardEdge,
//           child: SizedBox(
//             height: MediaQuery.of(context).size.width * 0.38,
//             width: MediaQuery.of(context).size.width,
//             child: Image.asset(mainAd.imagePath,
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.width * 0.38,
//                 fit: BoxFit.fill),
//           ),
//         ));
//   }
//
//   _buildTrendingsListItem(Trending trending, BuildContext ctxt) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               ctxt,
//               MaterialPageRoute(
//                   builder: (context) => (trending.importerPharmacy is Pharmacy)
//                       ? PharamacyDetail(
//                     pharmacy: trending.importerPharmacy,
//                         )
//                       : ImporterDetail(
//                           importer: trending.importerPharmacy,
//                         )));
//         },
//         child: Card(
//             // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             color: myCustomColors.cardBackgroud,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18.0),
//             ),
//             clipBehavior: Clip.hardEdge,
//             elevation: 0,
//             // elevation: 14,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                   ),
//                   clipBehavior: Clip.hardEdge,
//                   // child: Container(
//                   //   width: 90,
//                   //   height: 110,
//                   //   child: SizedBox(
//                   //     height: 110,
//                   //     width: 90,
//                   //     child: Image.asset(trending.imagePath,
//                   //         width: 90, height: 110, fit: BoxFit.fill),
//                   //   ),
//                   // ),
//                   child: Container(
//                     width: 120,
//                     height: 150,
//                     child: SizedBox(
//                       height: 150,
//                       width: 120,
//                       child: Image.asset(trending.imagePath,
//                           width: 120, height: 150, fit: BoxFit.fill),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   trending.name,
//                   maxLines: 2,
//                   textScaleFactor: 1.1,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   trending.importerPharmacy.name,
//                   maxLines: 2,
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   trending.category.name,
//                   maxLines: 2,
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 )
//               ],
//             )));
//   }
//
//   _buildHealthArticlesListItem(HealthArticle healthArticle, BuildContext ctxt) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               ctxt,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(
//                         name: healthArticle.name,
//                         description: healthArticle.detail,
//                         imageUrl: healthArticle.imagePath,
//                       )));
//         },
//         child: Card(
//             elevation: 14,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             clipBehavior: Clip.antiAlias,
//             child: Container(
//                 width: 120.0,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       width: 120,
//                       height: 150,
//                       child: SizedBox(
//                         height: 150,
//                         width: 120,
//                         child: Image.asset(healthArticle.imagePath,
//                             width: 120, height: 150, fit: BoxFit.fill),
//                       ),
//                     ),
//                   ],
//                 ))));
//   }
//
//   _getPresreption(BuildContext ctxt) async {
//     return showDialog(
//         context: ctxt,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Search by Prescription?'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Add image of your prescription from your Gallery."),
//                 Container(
//                   padding: EdgeInsets.only(top: 30),
//                     child:SizedBox(
//                   height: 250,
//                   width: MediaQuery.of(context).size.width,
//                   child: (_image==null)?Image.asset(
//                     'assets/images/addPrescription.jpg',
//                     fit: BoxFit.fill,
//                   ):Image.file(
//                     (_image!),
//                     fit: BoxFit.fill,
//                   ),
//                 ))
//               ],
//             ),
//             actions: <Widget>[
//               new ElevatedButton(
//                   child: new Center(
//                     child: Container(
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                           Icon(Icons.attach_file_outlined),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text('Add')
//                         ])),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                     getImage(ctxt);
//
//                   })
//             ],
//           );
//         });
//   }
// }
