import 'package:alen/models/hospital.dart';
import 'package:alen/providers/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppColors.dart';
import 'ServiceCategory/Service.dart';
import 'DetailsPage.dart';

class DetailsForService extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final List<Service> services;
  final String id;

  DetailsForService({
    Key key,
     this.name,
     this.imageUrl,
     this.description,
     this.services,
    this.id
  }) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var hosProvider = Provider.of<HospitalProvider>(context, listen: false);
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
              )),
          body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 350,
                          child: Image.network(imageUrl,
                              width: 200, height: 120, fit: BoxFit.fill),
                        ),
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
                                'Types',
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<Hospitals>(
                            future: hosProvider.fetchHospital('3nPWouBvXSjpDLwbXXER'),
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
                                List<dynamic> list=[];
                                for(int i=0; i<hospServSnapshot.data.services.length; i++){
                                  var temp=hospServSnapshot.data.services[i];
                                  if(temp['service_type_id']==id){
                                    list.add(temp);
                                  }
                                }
                                print("Printing list size . . .");
                                print('The size is ${list.length}.');
                                print("Done");

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
                                            list[index], ctxt);
                                      },
                                      itemCount: list.length,
                                    ));
                              }
                            }),
                        //TODO future builder here

                        // Container(
                        //     height: 110.0,
                        //     margin: EdgeInsets.fromLTRB(
                        //         MediaQuery.of(context).size.width * 0.07,
                        //         5,
                        //         MediaQuery.of(context).size.width * 0.07,
                        //         30),
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (BuildContext ctxt, int index) {
                        //         return _buildHopitalServicesListItem(
                        //             services[index], ctxt);
                        //       },
                        //       itemCount: services.length,
                        //     )),
                        Container(
                            padding: EdgeInsets.all(30),
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
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
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
  _buildHopitalServicesListItem(var service, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailsPage(name: service['service_name'], imageUrl: service['service_image'], description: service['service_detail'], )
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
                      service['service_image'],
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  service['service_name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
