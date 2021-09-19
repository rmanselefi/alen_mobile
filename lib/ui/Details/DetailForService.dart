import 'package:alen/models/hospital.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/ServiceCategory/Service.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:alen/utils/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HospitalDetail.dart';

class DetailsForService extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final List<Service> services;
  final String id;
  final String price;
  final Roles role;
  final String hospitalId;

  DetailsForService({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.services,
    this.id,
    this.price,
    this.role,
    this.hospitalId
  }) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var hosProvider = Provider.of<HospitalProvider>(context, listen: false);
    var diagnosisProvider = Provider.of<DiagnosticProvider>(context, listen: false);
    var labProvider = Provider.of<LaboratoryProvider>(context, listen: false);
    return Scaffold(
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
                      child: (imageUrl==null)?Text("Image not available"):
                      Image.network(imageUrl,
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
                    FutureBuilder<List<HLDServiceTypes>>(
                        future: (role==Roles.Hospital)?
                        hosProvider.getHospServiceTypesByHospitalId(id, hospitalId)
                            :(role==Roles.Diagnosis)?
                        diagnosisProvider.getDiagnosticsServiceTypesByDiagnosticsId(id, hospitalId):
                        labProvider.getLabServiceTypesByLabId(id, hospitalId)
                        ,
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
                            for(int i=0; i<hospServSnapshot.data.length; i++){
                              var temp=hospServSnapshot.data[i];
                              if(temp.serviceId==id){
                                list.add(temp);
                              }
                            }
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
                                        list[index], ctxt, hospitalId,id, role);
                                  },
                                  itemCount: list.length,
                                ));
                          }
                        }),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              name??"Name",
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
                            description??"Description",
                            textDirection: TextDirection.ltr,
                            maxLines: 10,
                          ),
                        )
                    ),
                    SizedBox(
                      height: 20,
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
  _buildHopitalServicesListItem(HLDServiceTypes service, BuildContext ctxt, String hospitalId, String serviceID, Roles role) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailsPage(name: service.name, imageUrl: service.image, description: service.description,
                      price: service.price,colName: 'hospital',serviceId: service.id, hospitalId: hospitalId, role: role
                  )
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
                      service.image,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  service.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
