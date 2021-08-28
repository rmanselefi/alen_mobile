import 'dart:io';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../AppColors.dart';

class MultiImagePharmacy extends StatefulWidget {
  final ImporterPharmacy importerPharmacy;
  const MultiImagePharmacy({Key key, this.importerPharmacy,}) : super(key: key);

  @override
  _MultiImagePharmacyState createState() => new _MultiImagePharmacyState();
}

class _MultiImagePharmacyState extends State<MultiImagePharmacy> {

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        // height: 180.0,
                          child: widget.importerPharmacy.imagesList.length == 0
                              ? Center(
                            child: Text(
                              "No Trendings Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 160,
                                childAspectRatio:
                                (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                    ? 2 / 3.65
                                    : 2 / 3.2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildTrendingsListItem(
                                  widget.importerPharmacy.imagesList[index], ctxt, index);
                            },
                            itemCount: widget.importerPharmacy.imagesList.length,
                          )),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
  _buildTrendingsListItem(String imagePath,BuildContext ctxt, int index) {
    File _image7;
    switch(index){
      case 0: _image7= _image2;
      break;
      case 1: _image7= _image3;
      break;
      case 2: _image7= _image4;
      break;
      case 3: _image7= _image5;
      break;
      case 4: _image7= _image6;
      break;
      default:
        break;

    }
    return GestureDetector(
        onTap: () {
          _getPresreption(ctxt, index);
        },
        child: Card(
            color: myCustomColors.cardBackgroud,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 0,
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
                    height: 150,
                    child: SizedBox(
                      height: 150,
                      width: 120,
                      child: (_image7==null)?
                      Image.asset(imagePath,
                          width: 120, height: 150, fit: BoxFit.fill)
                          :
                      Image.file(_image7,
                          width: 120, height: 150, fit: BoxFit.fill),

                    ),
                  ),
                ),
              ],
            )));
  }

  File _image;
  final picker = ImagePicker();

  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;

  @override
  void initState() {
    super.initState();
  }
  Future getImage(BuildContext ctxt, int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }
    );
    _getPresreption(ctxt, index);
  }
  _getPresreption(BuildContext ctxt,int index) async {
    return showDialog(
        context: ctxt,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Image?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child:SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: (_image==null)?Image.asset(
                        'assets/images/addPrescription.jpg',
                        fit: BoxFit.fill,
                      ):Image.file(
                        (_image),
                        fit: BoxFit.fill,
                      ),
                    ))
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new ElevatedButton(
                      child: new Center(
                        child: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(Icons.attach_file_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Add')
                                ])),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ctxt, index);

                      }),
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
                                  Text('Done')
                                ])),
                      ),
                      onPressed: () {

                        setState(() {
                          if(_image!=null){
                            switch(index){
                              case 0: _image2 = _image;
                              if(_image!=null){
                                print(_image.uri.toString());
                              }
                              break;
                              case 1: _image3 = _image;
                              if(_image!=null){
                                print(_image.uri.toString());
                              }
                              break;
                              case 2: _image4 = _image;
                              if(_image!=null){
                                print(_image.uri.toString());
                              }
                              break;
                              case 3: _image5 = _image;
                              if(_image!=null){
                                print(_image.uri.toString());
                              }
                              break;
                              case 4: _image6 = _image;
                              if(_image!=null){
                                print(_image.uri.toString());
                              }
                              break;
                              default:
                                break;
                            }
                          }
                          else {
                            print('No image selected.');
                          }
                        });
                        // Navigator.pop(context);
                        Navigator.pop(context);
                        MultiImagePharmacy(importerPharmacy: widget.importerPharmacy,);

                      })
                ],
              )
            ],
          );
        });
  }
}