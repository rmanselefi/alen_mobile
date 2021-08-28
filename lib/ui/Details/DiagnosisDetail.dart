import 'package:alen/models/diagnostic.dart';
import 'package:alen/models/importer.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Forms/LoginForm.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Edit/DiagnosisEdit.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AppColors.dart';
import '../DetailForService.dart';

class DiagnosisDetail extends StatelessWidget {
  HospitalLabDiagnosis diagnosis;

  final List<String> imageList = [
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
    'assets/images/hos3.jpg',
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
  ];

  static const myCustomColors = AppColors();


  DiagnosisDetail(
      {Key key,
         this.diagnosis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    var diagnosisProvider = Provider.of<DiagnosticProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var hosProvider = Provider.of<HospitalProvider>(context, listen: false);
    String hospitalId;
    UserPreferences().getId().then((value) => hospitalId=value);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground,
            appBarTheme: AppBarTheme(
              color: myCustomColors.loginBackgroud,
            )),
        home: FutureBuilder<Diagnostics>(
            future: diagnosisProvider.fetchDiagnostics(hospitalId),
            builder: (context , snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.none &&
                  snapshot.hasData == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              print(
                  'project snapshot data is: ${snapshot.data}');
              if (snapshot.data == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(diagnosis.title),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.only(right: 15),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiagnosisEdit(
                                    diagnosis: diagnosis,)));
                        },
                        icon: Icon(
                            Icons.edit
                        ),
                      ),

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
                                accountName: Text(snapshot.data.name),
                                accountEmail: Text(snapshot.data.email),
                                currentAccountPicture: CircleAvatar(
                                  //backgroundColor: myCustomColors.loginButton,
                                  // child: Text(
                                  //   "A",
                                  //   style: TextStyle(
                                  //       fontSize: 40.0, color: myCustomColors.loginBackgroud),
                                  // ),
                                  backgroundImage: NetworkImage(snapshot.data.image),
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
                              ListTile(
                                leading: Icon(Icons.credit_card_rounded),
                                title: Text("Credit"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text("Log Out"),
                                onTap: () {
                                  authProvider.signOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => LoginForm(),
                                    ),
                                        (route) => false,
                                  );
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Swiper(
                                  itemCount: snapshot.data.images.length,
                                  layout: SwiperLayout.STACK,
                                  scrollDirection: Axis.horizontal,
                                  autoplay: true,
                                  pagination: SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      snapshot.data.images[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  itemHeight: MediaQuery.of(context).size.width * 0.40,
                                  itemWidth: MediaQuery.of(context).size.width,
                                ),
                                // Container(
                                //     padding: EdgeInsets.only(left:30,top: 30),
                                //     width: MediaQuery.of(context).size.width,
                                //     child:Text(
                                //       'Services',
                                //       textScaleFactor: 1.5,
                                //       textAlign: TextAlign.left,
                                //       overflow: TextOverflow.ellipsis,
                                //       style: const TextStyle(fontWeight: FontWeight.bold),
                                //     )
                                //
                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      30,
                                      MediaQuery.of(context).size.width * 0.03,
                                      5),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Services',
                                        textScaleFactor: 1.5,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      // GestureDetector(
                                      //     onTap: (){
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) => SeeAllServices()
                                      //           ));
                                      //     },
                                      //   child: Text(
                                      //     'See All',
                                      //     textScaleFactor: 1.3,
                                      //     textAlign: TextAlign.left,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: const TextStyle(fontWeight: FontWeight.bold,
                                      //     color: Colors.blueAccent),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                FutureBuilder<List<HospServicesTypes>>(
                                    future: hosProvider.getAllHospServiceTypes(),
                                    builder: (context , hospServSnapshot) {
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
                                      }
                                      else {
                                        return Container(
                                            height: 110.0,
                                            margin: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context).size.width * 0.07,
                                                5,
                                                MediaQuery.of(context).size.width * 0.07,
                                                30),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext ctxt, int index) {
                                                return _buildHopitalServicesListItem(
                                                    hospServSnapshot.data[index], ctxt);
                                              },
                                              itemCount: hospServSnapshot.data.length,
                                            ));
                                      }
                                    }),
                                Container(
                                    padding: EdgeInsets.only(top:10,bottom: 30),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child:Text(
                                          snapshot.data.name,
                                          textAlign: TextAlign.left,
                                          textScaleFactor: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        )
                                    )
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        snapshot.data.description,
                                        textDirection: TextDirection.ltr,
                                        maxLines: 10,
                                      ),
                                    )
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 30, top: 10),
                                        child: Text(
                                          'Office Hours',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 30, top: 10),
                                        child: Text(
                                          snapshot.data.officehours,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                    GestureDetector(
                                        onTap: () => launch("tel://${snapshot.data.phone}"),
                                        child: Column(children: [
                                          Container(
                                            padding: EdgeInsets.only(right: 30, top: 10),
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
                                            padding: EdgeInsets.only(right: 30, top: 10),
                                            child: Text(
                                              snapshot.data.phone,
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
                                        padding: EdgeInsets.only(left: 30, top: 10),
                                        child: Text(
                                          'Latitude',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 30, top: 10),
                                        child: Text(
                                          snapshot.data.latitude.toString(),
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                    Column(children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 30, top: 10),
                                        child: Text(
                                          'Longtude',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 30, top: 10),
                                        child: Text(
                                          snapshot.data.longitude.toString(),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
            }),);
  }
  _buildHopitalServicesListItem(var hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailsForService(name: hospitalServices.name, imageUrl: hospitalServices.image, description: hospitalServices.description, services: [],id:hospitalServices.id,)
              ));
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
                      hospitalServices.image,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
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
