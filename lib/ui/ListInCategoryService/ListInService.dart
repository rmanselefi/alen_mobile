import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:alen/ui/ServiceCategory/Service.dart';
import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
import '../../utils/DetailsPage.dart';


class ListInServices extends StatefulWidget {

  @override
  _ListInServicesState createState() => _ListInServicesState();
}

class _ListInServicesState extends State<ListInServices> {

  static const myCustomColors = AppColors();
  List<Service> services = Service.services;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground),
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: myCustomColors.loginBackgroud,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Container(
                          child: services.length == 0
                              ? Center(
                            child: Text(
                              "No Health Articles Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.6,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildServicesListItem(
                                  services[index], ctxt);
                            },
                            itemCount: services.length,
                          )),
                    ]))
        )
    );
  }
  _buildServicesListItem(Service service, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: service.name,
                    description: service.detail,
                    imageUrl: service.imagePath,
                  )));
        },
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
                width: 150,
                height: 180,
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: Image.asset(service.imagePath,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              service.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
