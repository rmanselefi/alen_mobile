import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

import 'AcceptanceOfTerms.dart';
import 'AccountRegistration.dart';
import 'Contact.dart';
import 'Fees.dart';
import 'MiscellaneousProvisions.dart';
import 'PostingOfAnnouncementsByUsers.dart';
import 'Service.dart';
import 'UserRepresentationAndWarranties.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
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
                                      "TERMS OF USE",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 2,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "1. ACCEPTANCE OF THE TERMS",
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
                                            builder: (context) => AcceptanceOfTerms()));
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "2. ACCOUNT REGISTRATION",
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
                                            builder: (context) => AccountRegistration()));
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "3. SERVICE",
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
                                            builder: (context) => Service()));
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "4. POSTING OF ANNOUNCEMENTS BY USERS",
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
                                            builder: (context) => PostingOfAnnouncementsByUser()));
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "5. FEES",
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
                                            builder: (context) => Fees()));
                                  },
                                )
                            ),

                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "6. USER REPRESENTATIONS AND WARRANTIES",
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
                                            builder: (context) => UserRepresentationAndWarranties()));
                                  },
                                )
                            ),

                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "7. MISCELLANEOUS PROVISIONS",
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
                                            builder: (context) => MiscellaneousProvisions()));
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  child: Text(
                                    "8. CONTACT",
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
                                            builder: (context) => Contact()));
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
                                    "Last updated: 31 August 2021",
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
        });
  }
}
