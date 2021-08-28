import 'package:alen/ui/Edit/AddType.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/ServiceCategory/Service.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import '../AppColors.dart';
import '../DetailsPage.dart';

class DetailServiceEdit extends StatefulWidget {
  final HospitalServices hospitalServices;
  final HospitalLabDiagnosis hospitalLabDiagnosis;
  const DetailServiceEdit({Key key, this.hospitalServices,  this.hospitalLabDiagnosis}) : super(key: key);

  @override
  _DetailServiceEditState createState() => _DetailServiceEditState();
}

class _DetailServiceEditState extends State<DetailServiceEdit> {
  static const myCustomColors = AppColors();


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
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                icon: Icon(
                    Icons.done_all_outlined
                ),
              ),
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
                        SizedBox(
                          height: 200,
                          width: 350,
                          child: Image.asset(widget.hospitalServices.imagePath,
                              width: 200, height: 120, fit: BoxFit.fill),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.03,
                              30,
                              MediaQuery.of(context).size.width * 0.03,
                              5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Types',
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddType(hospitalLabDiagnosis: widget.hospitalLabDiagnosis,hospitalService: widget.hospitalServices,)
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 30,
                                  )
                              )
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
                                    widget.hospitalServices.services[index], ctxt);
                              },
                              itemCount: widget.hospitalServices.services.length,
                            )),
                        Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  widget.hospitalServices.name,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            )
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top:10,bottom: 30),
                                child:IconButton(
                                    onPressed: (){
                                      _messageControler.text = widget.hospitalServices.detail;
                                      editMessageDescription(context, "Description", widget.hospitalServices.detail);
                                    },
                                    icon: Icon(
                                        Icons.edit_outlined
                                    ))),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                width: MediaQuery.of(context).size.width*0.85,
                                child: Center(
                                  child: Text(
                                    widget.hospitalServices.detail,
                                    textDirection: TextDirection.ltr,
                                    maxLines: 15,
                                  ),
                                )
                            ),


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
  _buildHopitalServicesListItem(Service service, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailsPage(name: service.name, imageUrl: service.imagePath, description: service.detail, )
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
                      service.imagePath,
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

  final _messageControler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  editMessageDescription(BuildContext context, String title, String message){
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit $title?'),
                  content: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                  children:[
                                    Container(
                                        child: Center(
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(10,5,10,25),
                                                width: MediaQuery.of(context).size.width * 0.90,
                                                child: TextFormField(
                                                  controller: _messageControler,
                                                  autocorrect: true,
                                                  maxLines: 15,
                                                  keyboardType: TextInputType.name,
                                                  validator: (String value){
                                                    if (value==null){
                                                      return '$title is required!';
                                                    }
                                                    if (value==''){
                                                      return '$title is required!';
                                                    }
                                                    if (value.length<4){
                                                      return "Has to be at least 4 letters";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String value){
                                                    setState(() {
                                                      widget.hospitalServices.detail=value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: '$title',
                                                    hintText: title,
                                                    labelStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    prefixIcon: Icon(
                                                      Icons.edit,
                                                      color: myCustomColors.loginBackgroud,
                                                    ),
                                                    counterStyle: TextStyle(color: Colors.white54),
                                                    hintStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: const BorderRadius.all(
                                                        const Radius.circular(40.0),
                                                      ),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                  ),
                                                )))),
                                  ]
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    new ElevatedButton(
                        child: new Center(
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.done),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Save')
                                  ])),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            widget.hospitalLabDiagnosis.services.remove(widget.hospitalServices);
                            widget.hospitalLabDiagnosis.services.add(widget.hospitalServices);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailServiceEdit(hospitalServices: widget.hospitalServices, hospitalLabDiagnosis: widget.hospitalLabDiagnosis,)));
                          }
                        }),
                  ],
                );
              });
        });
  }
}


