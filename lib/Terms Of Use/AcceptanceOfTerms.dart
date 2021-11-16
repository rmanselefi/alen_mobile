import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class AcceptanceOfTerms extends StatelessWidget {
  const AcceptanceOfTerms({Key key}) : super(key: key);

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
                                      "Acceptance Of The Terms",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1.6,
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
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                        "1.1. These Terms of Use (the ",
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '“Terms”',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                        TextSpan(
                                          text: ") constitute "
                                  "a binding and enforceable legal contract between "
                                  "Hyssop Pharma Trading P.L.C and you. Please "
                                  "read these Terms carefully.\n\n"
                                    "1.2. Your access and use of the “Alen” call"
                                    " center and mobile application, as well"
                                    " as any service, content, and data available"
                                    " via them (together, the ",
                                        ),
                                        TextSpan(
                                          text: '“Service”',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                        TextSpan(
                                          text: ' or the ',
                                        ),
                                        TextSpan(
                                          text: '“Platform”',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                        TextSpan(
                                          text: ") are governed by these Terms.\n\n"
                                        "1.3. If you do not agree with any part of these"
                                        " Terms, or if you are not eligible or "
                                        "authorized to be bound by the Terms, "
                                        "then do not access or use the Service.\n\n"
                                        "1.4. Please also review our Privacy Policy."
                                        " The terms of the Privacy Policy and other "
                                        "supplemental terms, rules, policies, or"
                                          " documents that may be posted on the "
                                          "Platform from time to time are hereby "
                                          "expressly incorporated herein by reference. "
                                          "We reserve the right, in our sole discretion, "
                                        "to make changes or modifications to these Terms "
                                        "at any time and for any reason with or without"
                                        " prior notice. without prior notice.",
                                        ),
                                      ]
                                    ),
                                  )
                                  ,
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