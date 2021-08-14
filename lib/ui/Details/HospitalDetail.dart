import 'package:alen/ui/Details/DetailForService.dart';
import 'package:alen/ui/ListInCategoryService/ListInService.dart';
import 'package:alen/ui/Models/Services.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/AppColors.dart';

class HospitalDetail extends StatelessWidget {
  String name;
  String title;
  String image;
  String officeHours;
  List<dynamic> services;
  String info;
  String location;
  String description;
  String phone;
  List<dynamic> newservices;

  final List<String> imageList = [
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
    'assets/images/hos3.jpg',
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
  ];

  static const myCustomColors = AppColors();

  HospitalDetail(
      {this.name,
      this.title,
      this.description,
      this.image,
      this.services,
      this.info,
      this.location,
      this.phone,
      this.officeHours,
      this.newservices});
  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);

    final names = services.map((e) => e['name']).toSet();
    services.retainWhere((x) => names.remove(x['name']));
    print("services $services");
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text(name),
            actions: [
              Container(
                  child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/alen_no_name.png'),
              )),
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
                    Swiper(
                      itemCount: imageList.length,
                      layout: SwiperLayout.STACK,
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                      ),
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imageList[index],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service',
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeeAllServices()));
                            },
                            child: Text(
                              'See All',
                              textScaleFactor: 1.3,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
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
                                services[index], ctxt);
                          },
                          itemCount: services.length,
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          name,
                          textAlign: TextAlign.left,
                          textScaleFactor: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            description,
                            textDirection: TextDirection.ltr,
                            maxLines: 10,
                          ),
                        )),

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
                              officeHours,
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
                              'Additional Info.',
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
                              "info",
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Container(
                            padding: EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              'Location',
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
                              location,
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        GestureDetector(
                            onTap: () => launch("tel://$phone"),
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
                                  phone,
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]))
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
        ));
  }

  _buildHopitalServicesListItem(var hospitalServices, BuildContext ctxt) {
    print("object ${hospitalServices}");
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsForService(
                        id: hospitalServices['service_id'],
                        name: hospitalServices['name'],
                        imageUrl: hospitalServices['service_image'],
                        description: hospitalServices['detail'],
                        services: newservices,
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
                      hospitalServices['service_image'],
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  hospitalServices['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
