import 'dart:io';
import 'dart:math';
import 'package:alen/models/hospital.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../AppColors.dart';
import 'package:path/path.dart';

class MultipleImageDemo extends StatefulWidget {
  final HospitalLabDiagnosis hospital;
  const MultipleImageDemo({Key key,this.hospital,}) : super(key: key);

  @override
  _MultipleImageDemoState createState() => new _MultipleImageDemoState();
}

class _MultipleImageDemoState extends State<MultipleImageDemo> {

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var hosProvider = Provider.of<HospitalProvider>(context, listen: false);
    String hospitalId;
    UserPreferences().getId().then((value) => hospitalId=value);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          scaffoldBackgroundColor: myCustomColors.mainBackground,
          appBarTheme: AppBarTheme(
            color: myCustomColors.loginBackgroud,
          )),
      home: FutureBuilder<Hospitals>(
          future: hosProvider.fetchHospital('3nPWouBvXSjpDLwbXXER'),
          builder: (context , snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.none &&
                snapshot.hasData == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            print(
                'project snapshot data is: ${snapshot.data}');
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  actions: [
                    IconButton(
                      padding: EdgeInsets.only(right: 15),
                      onPressed: (){
                        _getPresreption(context,snapshot.data.images);
                      },
                      icon: Icon(
                          Icons.add
                      ),
                    ),
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
                                  child: (snapshot.data.images== null || snapshot.data.images.length==0)
                                      ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    child:Center(
                                      child: Text(
                                        "No Images Available",
                                      ),
                                    )
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
                                          snapshot.data.images[index], ctxt, index);
                                    },
                                    itemCount: snapshot.data.images.length,
                                  )),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            }
          }),

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
          //_updateImage(ctxt, index,imagePath);
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
                      child: (imagePath!=null)?
                      Image.network(imagePath,
                          width: 120, height: 150, fit: BoxFit.fill)
                          :
                      Image.file(_image,
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
  Future getImage(BuildContext ctxt, List<dynamic> imagesList) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }
    );
    _getPresreption(ctxt, imagesList);
  }
  bool isUploaded=false;
  Future<void> uploadFile(File file) async {
    String token= await UserPreferences().getUser();
    print('token : $token');
    // await FirebaseAuth.instance.signInWithEmailAndPassword(email: "asdfasdf@gmail.com", password: "asdfasdf");
    // await FirebaseAuth.instance.signInAnonymously();
    Random random = new Random();
    int index= random.nextInt(10000);
    final filename= basename(file.path);
    try {
      final ref=firebase_storage.FirebaseStorage.instance
          .ref('uploads/$filename.png');
      firebase_storage.UploadTask task= ref.putFile(file);
          // .ref('uploads/$filename.png')
          // .putFile(file);
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      // String downloadURL = await firebase_storage.FirebaseStorage.instance
      //     .ref('uploads/$filename.png')
      //     .getDownloadURL();

      setState(() {
        if(urlDownload!=null){
          isUploaded=true;
        }
        imagetoUpload=urlDownload;
      });
      print(urlDownload);
      print(urlDownload);
      print(urlDownload);
      print(imagetoUpload);
      print(imagetoUpload);
      print(imagetoUpload);


    } on Exception catch (exception) {
      print("Failed to upload! : $exception");
    }
  }
  String imagetoUpload;
  // Future<void> downloadURL() async {
  //   await FirebaseAuth.instance.signInAnonymously();
  //   String downloadURL = await firebase_storage.FirebaseStorage.instance
  //       .ref('uploads/new_image.png')
  //       .getDownloadURL();
  //   print(imagetoUpload);
  //   print(imagetoUpload);
  //   print(imagetoUpload);
  //   print(imagetoUpload);
  //   print(imagetoUpload);
  //   print(imagetoUpload);
  //
  //   setState(() {
  //     imagetoUpload=downloadURL;
  //   });
  //   // Within your widgets:
  //   // Image.network(downloadURL);
  // }
  String _uploadedFileURL;
  _getPresreption(BuildContext ctxt, List<dynamic> imagesList) async {
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
                        getImage(ctxt, imagesList);

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
                            Navigator.pop(context);
                           uploadFile(_image);
                           imagesList.add(imagetoUpload);
                           // imagesList.forEach((element) {
                           //   print('-----------This is the address $element-------------');
                           // });
                           //downloadURL();
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                            print(isUploaded);
                           if(isUploaded){
                             FirebaseFirestore.instance.collection('hospital')
                                 .doc('3nPWouBvXSjpDLwbXXER')
                                 .update({'images': imagesList})
                                 .then((value) => print("Detail Updated"))
                                 .catchError((error) => print("Failed to add image: $error"));
                             Navigator.pop(ctxt);

                             MultipleImageDemo(hospital: widget.hospital,);
                           }
                           else{
                             showDialog(
                                 context: ctxt,
                                 builder: (context) {
                                   return AlertDialog(
                                     title: Text('Upload Failed'),
                                     content: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Text("Couldn't upload image, Please check your internet connection.  Failed", maxLines: 5,),
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
                                                           Text('Ok')
                                                         ])),
                                               ),
                                               onPressed: () {

                                                 getImage(ctxt, imagesList);

                                               }),
                                         ],
                                       )
                                     ],
                                   );
                                 });
                           }
                          }
                          else {
                            print('No image selected.');
                          }
                          });


                      })
                ],
              )
            ],
          );
        });
  }
  //
  // _updateImage(BuildContext ctxt,int index, String img) async {
  //   return showDialog(
  //       context: ctxt,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Add Image?'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                   padding: EdgeInsets.only(top: 30),
  //                   child:SizedBox(
  //                     height: 250,
  //                     width: MediaQuery.of(context).size.width,
  //                     child: (_image==null)?Image.network(
  //                       img,
  //                       fit: BoxFit.fill,
  //                     ):Image.file(
  //                       (_image),
  //                       fit: BoxFit.fill,
  //                     ),
  //                   ))
  //             ],
  //           ),
  //           actions: <Widget>[
  //             Row(
  //               mainAxisSize: MainAxisSize.max,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 new ElevatedButton(
  //                     child: new Center(
  //                       child: Container(
  //                           child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               mainAxisSize: MainAxisSize.max,
  //                               children: [
  //                                 Icon(Icons.attach_file_outlined),
  //                                 SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Text('Select')
  //                               ])),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       getImage(ctxt);
  //
  //                     }),
  //                 new ElevatedButton(
  //                     child: new Center(
  //                       child: Container(
  //                           child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               mainAxisSize: MainAxisSize.max,
  //                               children: [
  //                                 Icon(Icons.done),
  //                                 SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Text('Done')
  //                               ])),
  //                     ),
  //                     onPressed: () {
  //
  //                       setState(() {
  //                         if(_image!=null){
  //                           switch(index){
  //                             case 0: _image2 = _image;
  //                             if(_image!=null){
  //                               print(_image.uri.toString());
  //                             }
  //                             break;
  //                             case 1: _image3 = _image;
  //                             if(_image!=null){
  //                               print(_image.uri.toString());
  //                             }
  //                             break;
  //                             case 2: _image4 = _image;
  //                             if(_image!=null){
  //                               print(_image.uri.toString());
  //                             }
  //                             break;
  //                             case 3: _image5 = _image;
  //                             if(_image!=null){
  //                               print(_image.uri.toString());
  //                             }
  //                             break;
  //                             case 4: _image6 = _image;
  //                             if(_image!=null){
  //                               print(_image.uri.toString());
  //                             }
  //                             break;
  //                             default:
  //                               break;
  //                           }
  //                         }
  //                         else {
  //                           print('No image selected.');
  //                         }
  //                       });
  //                       // Navigator.pop(context);
  //                       Navigator.pop(context);
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => MultipleImageDemo(hospital: widget.hospital,)
  //                           ));
  //
  //                     })
  //               ],
  //             )
  //           ],
  //         );
  //       });
  // }
}