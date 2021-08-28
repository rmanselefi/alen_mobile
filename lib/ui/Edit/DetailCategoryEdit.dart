import 'package:alen/ui/DetailForPha.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:flutter/material.dart';
import '../AppColors.dart';

class DetailCategoryEdit extends StatefulWidget {
  final PharmacyServices pharmacyServices;
  final ImporterPharmacy importerPharmacy;
  const DetailCategoryEdit({Key key, this.pharmacyServices,  this.importerPharmacy}) : super(key: key);

  @override
  _DetailCategoryEditState createState() => _DetailCategoryEditState();
}

class _DetailCategoryEditState extends State<DetailCategoryEdit> {
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
                          child: Image.asset(widget.pharmacyServices.imagePath,
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
                                'Products',
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // SizedBox(width: 10,),
                              // IconButton(
                              //     onPressed: (){
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => AddTypePharmacy( importerPharmacy: widget.importerPharmacy,pharmacyService: widget.pharmacyServices,)
                              //           ));
                              //     },
                              //     icon: Icon(
                              //       Icons.add,
                              //       size: 30,
                              //     )
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
                                    widget.pharmacyServices.categores[index], ctxt);
                              },
                              itemCount: widget.pharmacyServices.categores.length,
                            )),
                        Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  widget.pharmacyServices.name,
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
                                      _messageControler.text = widget.pharmacyServices.detail;
                                      editMessageDescription(context, "Description", widget.pharmacyServices.detail);
                                    },
                                    icon: Icon(
                                        Icons.edit_outlined
                                    ))),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                width: MediaQuery.of(context).size.width*0.85,
                                child: Center(
                                  child: Text(
                                    widget.pharmacyServices.detail,
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
  _buildHopitalServicesListItem(Category category, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailForPha(name: category.name, imageUrl: category.imagePath, description: category.detail, price: category.price,)
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
                      category.imagePath,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  category.name,
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
                                                      widget.pharmacyServices.detail=value;
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
                            widget.importerPharmacy.services.remove(widget.pharmacyServices);
                            widget.importerPharmacy.services.add(widget.pharmacyServices);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCategoryEdit(pharmacyServices: widget.pharmacyServices, importerPharmacy: widget.importerPharmacy,)));
                          }
                        }),
                  ],
                );
              });
        });
  }
}


