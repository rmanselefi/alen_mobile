
import 'package:alen/ui/Cart/ImportCart.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:alen/ui/ListInCategoryService/ListImporter.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';


class ImporterDetail extends StatelessWidget {
  String name;
  String title;
  List<String> imagesList;
  String officeHours;
  List<PharmacyServices> services;
  String info;
  String location;
  String description;
  String phone;

  final List<String> imageList = [
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
    'assets/images/hos3.jpg',
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
  ];

  static const myCustomColors = AppColors();

  ImporterDetail(
      {
         this.name,
         this.title,
         this.description,
         this.imagesList,
         this.services,
         this.info,
         this.location,
         this.phone,
         this.officeHours})
      ;

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
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
            title: Text(title),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => ListInServices()
                          builder: (context) => ImportCart()
                      ));
                },
                icon: Icon(
                    Icons.shopping_cart
                ),
              ),
              //       Container(
              //           child: CircleAvatar(
              //   backgroundImage: AssetImage('assets/images/alen_no_name.png'),
              // )
              //           ),

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
                          itemCount: imagesList.length,
                          layout: SwiperLayout.STACK,
                          scrollDirection: Axis.horizontal,
                          autoplay: true,
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                          ),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              imagesList[index],
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
                                MediaQuery.of(context).size.width * 0.07,
                                30,
                                MediaQuery.of(context).size.width * 0.07,
                                5),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Categories',
                                  textScaleFactor: 1.5,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // GestureDetector(
                                //   onTap: (){
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => SeeAllCategories()
                                //         ));
                                //   },
                                //   child: Text(
                                //     'See All',
                                //     textScaleFactor: 1.3,
                                //     textAlign: TextAlign.left,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: const TextStyle(fontWeight: FontWeight.bold,
                                //         color: Colors.blueAccent),
                                //   ),
                                // )
                              ],
                            )),
                        Container(
                            height: 110.0,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.03,
                                5,
                                MediaQuery.of(context).size.width * 0.03,
                                30),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _buildPharmacyServicesListItem(
                                    services[index], ctxt);
                              },
                              itemCount: services.length,
                            )),
                        Container(
                            padding: EdgeInsets.only(top:10,bottom: 30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  name,
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
                                description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(left:30,top: 10),
                                    child:Text(
                                      'Office Hours',
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left:30,top: 10),
                                    child:Text(
                                      officeHours,
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  ),
                                ]),
                            Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(right:30,top: 10),
                                    child:Text(
                                      'Additional Info.',
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right:30,top: 10),
                                    child:Text(
                                      info,
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
                            Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(left:30,top: 10),
                                    child:Text(
                                      'Location',
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left:30,top: 10),
                                    child:Text(
                                      location,
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  ),
                                ]),
                            GestureDetector(
                                onTap: () => launch("tel://$phone"),
                                child:Column(
                                    children:[
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 10),
                                        child:Text(
                                          'Phone Number',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(left:20,top: 10),
                                              child:
                                              Icon(
                                                Icons.phone,
                                                color: Colors.black,
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(left:20,right: 50, top: 10),
                                            child:Text(
                                              phone,
                                              maxLines: 3,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                          ),
                                        ],
                                      )
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
  _buildPharmacyServicesListItem(PharmacyServices pharmacyServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => ListImporter()
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
                    child: Image.asset(
                      pharmacyServices.imagePath,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  pharmacyServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
