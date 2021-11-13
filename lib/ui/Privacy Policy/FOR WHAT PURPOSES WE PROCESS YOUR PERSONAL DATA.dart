import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class ForWhatPurposeWeProcessYourPersonalData extends StatelessWidget {
  const ForWhatPurposeWeProcessYourPersonalData({Key key}) : super(key: key);

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
                                      "3. FOR WHAT PURPOSES WE PROCESS YOUR PERSONAL DATA",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2,
                                      maxLines: 3,
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
                                    "We process your personal data:",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.1. To provide our Service",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "This includes enabling you to use the Service "
                                        "in a seamless manner and preventing or"
                                        " addressing Service errors or technical issues.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.2. To customize your experience",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We process your personal data to adjust"
                                        " the content of the Service and make"
                                        " offers tailored to your personal "
                                        "preferences and interests.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.3. To manage your account and "
                                      "provide you with customer support",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We process your personal data to respond"
                                        " to your requests for technical support, "
                                        "Service information or to any other "
                                        "communication you initiate. This includes"
                                        " accessing your account to address "
                                        "technical support requests. For this "
                                        "purpose, we may send you, for example,"
                                        " notifications or emails about the "
                                        "performance of our Service, security,"
                                        " notices regarding our Terms of Use or "
                                        "this Privacy Policy.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.4. To communicate with you regarding your use of our Service",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We communicate with you, for example, "
                                        "by push notifications. As a result,"
                                        " you may, for example, receive a"
                                        " notification whether on the Website"
                                        " or via email that you received a new"
                                        " message on “Alen”. To opt out of "
                                        "receiving push notifications, you need "
                                        "to change the settings on your browser "
                                        "or mobile device.\n\n"
                                        "The services that we use for these purposes"
                                        " may collect data concerning the date and "
                                        "time when the message was viewed by our users,"
                                        " as well as when they interacted with it, such"
                                        " as by clicking on links included in the message.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.5. To research and analyze your use of the Service",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "This helps us to better understand our service,"
                                        " analyze our operations, maintain, improve,"
                                        " innovate, plan, design, and develop “Alen” "
                                        "and our new products. We also use such data "
                                        "for statistical analysis purposes, to test and"
                                        " improve our offers. This enables us to "
                                        "better understand what features and sections"
                                        " of “Alen” our users like more, what categories"
                                        " of users use our Service. As a consequence,"
                                        " we often decide how to improve “Alen”  based"
                                        " on the results obtained from this processing. ",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.6. To enforce our Terms of Use and to prevent and combat fraud",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We use personal data to enforce our agreements "
                                        "and contractual commitments, to detect, "
                                        "prevent, and combat fraud. As a result of"
                                        " such processing, we may share your "
                                        "information with others, including law"
                                        " enforcement agencies (in particular,"
                                        " if a dispute arises in connection with "
                                        "our Terms of Use).",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "3.7. To comply with legal obligations",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We may process, use, or share your data"
                                        " when the law requires it, in particular, "
                                        "if a law enforcement agency requests your"
                                        " data by available legal means.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            SizedBox(
                              height: 30,
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
