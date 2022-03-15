import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

import '2. CATEGORIES OF PERSONAL DATA WE COLLECT.dart';
import 'CHANGES TO THIS PRIVACY POLICY.dart';
import 'CONTACT US.dart';
import 'DATA RETENTION.dart';
import 'FOR WHAT PURPOSES WE PROCESS YOUR PERSONAL DATA.dart';
import 'HOW YOU CAN EXCERSISE YOUR RIGHTS.dart';
import 'Personal Data Controller.dart';
import 'UNDER WHAT LEGAL BASES WE PROCESS YOUR PERSONAL DATA.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    Future<dynamic> handleExitApp() async{
      Navigator.pop(context, false);
    }
    return WillPopScope(
      onWillPop:() async => handleExitApp(),
      child: LoaderOverlay(
          overlayOpacity: 0.8,
          child: FutureBuilder<dynamic>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  return CircularProgressIndicator();
                }
                print('project snapshot data is: ${snapshot.data}');
                if (snapshot.data == null) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  var _myLanguage = snapshot.data.getString("lang");
                  var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
                  languageProvider.langOPT = _myLanguage;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Alen"),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context, false),
                      ),
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
                                  SizedBox(height: 30,),
                                  SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                        'assets/images/alen_no_name.png',
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(30),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child:Text(
                                            "Privacy Policy",
                                            textAlign: TextAlign.left,
                                            textScaleFactor: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          )
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          "This privacy policy explains what personal data "
                                              "is collected when you use “Alen” mobile application"
                                              " and the service provided through it, how such "
                                              "personal data will be used, shared. By using"
                                              " the service, you promise us (1) that you "
                                              "have read, understand and agree to this privacy"
                                              " policy. (2) you are over 18 years of age or "
                                              "(half had your parent or guardian read and"
                                              " agree to this privacy policy for you). If"
                                              " you do not agree, or are unable to make "
                                              "this promise, you must not use the Service. "
                                              "In such case, you must contact the support"
                                              " team via email to request deletion of your"
                                              " account and data.",
                                          textDirection: TextDirection.ltr,

                                          maxLines: 20,
                                        ),
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 20, top: 30),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "1. PERSONAL DATA CONTROLLER",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => PersonalDataController()));
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "2. CATEGORIES OF PERSONAL DATA WE COLLECT",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CategoriesOfPersonalDataWeCollect()));
                                        },
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "3. FOR WHAT PURPOSES WE PROCESS PERSONAL DATA",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ForWhatPurposeWeProcessYourPersonalData()));
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "4. UNDER WHAT LEGAL BASES WE PROCESS YOUR PERSONAL DATA",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UnderWhatLegalBasesWeProcessOurPersonalData()));
                                        },
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "5. HOW YOU CAN EXERCISE YOUR PRIVACY RIGHTS",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HowCanYouExerciseYourRights()));
                                        },
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "6. CHANGES TO THIS PRIVACY POLICY",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChangesToThisPrivacyPolicy()));
                                        },
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "7. DATA RETENTION",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DataRetention()));
                                        },
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: FlatButton(
                                        child: Text(
                                          "8. CONTACT US",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.blueAccent
                                          ),
                                          maxLines: 10,
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ContactUs()));
                                        },
                                      )
                                  ),

                                  Divider(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          "Effective as of 30 August 2022 ",
                                          textScaleFactor: 1.2,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }
              })
      ),
    );
  }
}
