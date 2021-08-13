import 'package:alen/models/user_location.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/SeeAllPages/CategoryServices/SeeAllServices.dart';
import 'package:alen/ui/SeeAllPages/SecondPage/SeeAllLabs.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///D:/Personal/Workspace/flutter_projects/alen/lib/utils/DetailsPage.dart';
import 'package:alen/ui/Models/Trending.dart';
import 'package:alen/ui/Pages/Lab.dart';
import 'package:alen/ui/SearchDelegates/searchLabs.dart';
import 'package:provider/provider.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/models/laboratory.dart';

import '../../utils/AppColors.dart';

class LabsPage extends StatefulWidget {
  @override
  _LabsPageState createState() => _LabsPageState();
}

class _LabsPageState extends State<LabsPage> {
  List<HospitalServices> hospitalServices = HospitalServices.hospitalServices;
  List<Lab> labs = Lab.labs;
  static const myCustomColors = AppColors();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var labProvider = Provider.of<LaboratoryProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEBEBEB),
          fontFamily: 'Ubuntu',
          appBarTheme: AppBarTheme(
            color: myCustomColors.loginBackgroud,
          )),
      home: Scaffold(
        appBar: AppBar(
            elevation: 2,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text("Labs", textAlign: TextAlign.center)),
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
                        showSearch<Lab>(
                            context: context, delegate: LabSearch(labs));
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
                                                'Search',
                                                style: TextStyle(
                                                  color: myCustomColors
                                                      .loginBackgroud,
                                                ),
                                              ),
                                            ),
                                          ))))))),
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
                            "Top Labs",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                        ],
                      )),
                  Container(
                      height: 150.0,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return _buildTopServicesListItem(
                              hospitalServices[index], ctxt);
                        },
                        itemCount: hospitalServices.length,
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
                            "Nearby Labs",
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.7,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Container(
                      height: 190.0,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: FutureBuilder<UserLocation>(
                          future: labProvider.getCurrentLocation(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                snapshot.hasData == null) {
                              return CircularProgressIndicator();
                            }
                            return FutureBuilder<List<Laboratories>>(
                                future: labProvider
                                    .fetchNearByLaboratories(snapshot.data),
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
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return _buildLabsListItem(
                                            snapshot.data[index], ctxt);
                                      },
                                      itemCount: snapshot.data.length,
                                    );
                                  }
                                });
                          })),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  _buildLabsListItem(Laboratories lab, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //     ctxt,
          //     MaterialPageRoute(
          //         builder: (context) => HospitalDetail(
          //           title: lab.title,
          //           phone: lab.phone,
          //           imagesList: lab.imagesList,
          //           name: lab.name,
          //           description:lab.detail,
          //           location: lab.location,
          //           info: lab.info,
          //           officeHours: lab.officeHours,
          //           services: lab.services,
          //         )
          //     ));
        },
        child: Card(
            // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            clipBehavior: Clip.antiAlias,
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
                    width: 120,
                    height: 120,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: lab.image != null
                          ? Image.network(lab.image,
                              width: 120, height: 120, fit: BoxFit.fill)
                          : Container(
                              child: Center(
                                child: Text('Image'),
                              ),
                            ),
                    ),
                  ),
                ),
                Text(
                  lab.name,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  lab.latitude.toString(),
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  lab.phone,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  _buildTopServicesListItem(
      HospitalServices hospitalService, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        name: hospitalService.name,
                        description: hospitalService.detail,
                        imageUrl: hospitalService.imagePath,
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
                margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 140,
                      child: SizedBox(
                        height: 140,
                        width: 120,
                        child: Image.asset(hospitalService.imagePath,
                            width: 120, height: 140, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ))));
  }
}
