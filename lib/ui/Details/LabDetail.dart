import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/ui/Details/DetailForService.dart';
import 'package:alen/ui/ListInCategoryService/ListInService.dart';
import 'package:alen/ui/Models/Services.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../utils/AppColors.dart';
import 'HospitalDetail.dart';

class LabDetail extends StatelessWidget {
  String name;
  String title;
  String image;
  String officeHours;
  List<dynamic> services;
  String info;
  String location;
  String description;
  String phone;
  String longtude;
  String latitude;
  String email;
  List<dynamic> images;
  List<dynamic> newservices;
  String hospitalId;
  String locationName;

  static const myCustomColors = AppColors();

  LabDetail(
      {this.name,
        this.title,
        this.description,
        this.image,
        this.images,
        this.services,
        this.locationName,
        this.info,
        this.location,
        this.phone,
        this.longtude,
        this.email,
        this.latitude,
        this.officeHours,this.newservices, this.hospitalId});
  double screenWidth;
  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    var labProvider = Provider.of<LaboratoryProvider>(context, listen: false);
    screenWidth = MediaQuery.of(context).size.width;
    // final names = services.map((e) => e['name']).toSet();
    // services.retainWhere((x) => names.remove(x['name']));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(title),

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
                    FutureBuilder<List<dynamic>>(
                        future: labProvider
                            .fetchImages(hospitalId),
                        builder: (context, imageSnapshot) {
                          if (imageSnapshot.connectionState ==
                              ConnectionState.none &&
                              imageSnapshot.hasData == null) {
                            return Container(
                              height: 110,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          print(
                              'project snapshot data is: ${imageSnapshot.data}');
                          if (imageSnapshot.data == null) {
                            return Container(
                              height: 110,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Swiper(
                              itemCount: imageSnapshot.data.length ?? 0,
                              layout: SwiperLayout.STACK,
                              scrollDirection: Axis.horizontal,
                              autoplay: true,
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                              ),
                              itemBuilder: (context, index) {
                                return Image.network(
                                  imageSnapshot.data[index],
                                  fit: BoxFit.cover,
                                );
                              },
                              itemHeight:
                              MediaQuery.of(context).size.width * 0.40,
                              itemWidth: MediaQuery.of(context).size.width,
                            );
                          }
                        }),
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
                        ],
                      ),
                    ),
                    FutureBuilder<List<HLDServices>>(
                        future: labProvider
                            .getLabServicesByHospitalId(hospitalId),
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
                                    return _buildHopitalServicesListItem(
                                        hospServSnapshot.data[index], ctxt);
                                  },
                                  itemCount: hospServSnapshot.data.length,
                                ));
                          }
                        }),
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
                            padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Text(
                              'Office Hours',
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Text(
                              officeHours??"Office Hours",
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        GestureDetector(
                            onTap: () =>
                                launch("tel://$phone"),
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                width: screenWidth*0.4,
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
                                padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                                width: screenWidth*0.4,
                                child: Text(
                                  phone??"0900000000",
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
                            padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Text(
                              'Email',
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Text(
                              email??"Email",
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                        Column(children: [
                          Container(
                            padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Text(
                              'Our Location',
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // width: 150,
                            padding: EdgeInsets.only(right: screenWidth*0.05, top: 10),
                            width: screenWidth*0.4,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: ()async{
                                      final coords = Coords(
                                        double.parse(latitude),
                                        double.parse(longtude),
                                      );
                                      final availableMaps = await MapLauncher.installedMaps;
                                      print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                      await availableMaps.first.showMarker(
                                        coords: coords,
                                        title: name,
                                        description: description,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.location_pin,
                                      color: myCustomColors.loginBackgroud,
                                    ),
                                  ),
                                ),
                                Text(
                                  locationName,
                                  // "${double.parse(latitude).toStringAsFixed(3)} - ${double.parse(longtude).toStringAsFixed(3)}"??"-",
                                  maxLines: 3,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
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

  _buildHopitalServicesListItem(var hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsForService(
                    name: hospitalServices.name,
                    imageUrl: hospitalServices.image,
                    description: hospitalServices.detail,
                    services: [],
                    id: hospitalServices.id,
                    role: Roles.Lab,
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