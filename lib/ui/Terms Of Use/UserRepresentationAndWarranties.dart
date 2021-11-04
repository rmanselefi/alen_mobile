import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepresentationAndWarranties extends StatelessWidget {
  const UserRepresentationAndWarranties({Key key}) : super(key: key);

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
                                      "USER REPRESENTATIONS AND WARRANTIES",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1.6,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                )
                            ),

                            Container(
                                padding: EdgeInsets.only(left: 10, right: 30, bottom: 30),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child:Text(
                                      "6.1. By using the Service, "
                                          "service providers must represent "
                                          "and warrant that:",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1.3,
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
                                    "6.1.1. You have the legal capacity and you"
                                        " agree to comply with the Terms;\n\n"
                                        "6.1.2. If you register yourself as a"
                                        " representative of a legal entity,"
                                        " you are authorized by the company "
                                        "to enter into an agreement with us "
                                        "and with users of the Platform;\n\n"
                                        "6.1.3. You will or have provided true,"
                                        " accurate, and complete information "
                                        "in your Account;\n\n"
                                        "6.1.4. You will update your information "
                                        "on your Account to maintain its"
                                        " truthfulness, accuracy, and completeness;\n\n"
                                        "6.1.5. You will immediately change data for access"
                                        " to the Platform if you have a suspicion "
                                        "that your Account access details were disclosed "
                                        "or probably used by the third parties;\n\n"
                                        "6.1.6. You will notify the Administrator"
                                        " of any unauthorized access to your Account;\n\n"
                                        "6.1.7. You will not provide any false or misleading"
                                        " information about your identity or location "
                                        "in your Account;\n\n"
                                        "6.1.8. You will use the Service in strict abidance "
                                        "by applicable laws, regulations, rules, "
                                        "guidelines;\n\n"
                                        "6.1.9. You will not use the Service for any"
                                        " illegal or unauthorized purpose;\n\n"
                                        "6.1.10. You will not post on the "
                                        "Platform announcements that include: \n\n",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "> False, misleading or deceptive statements\n\n"
                                        "> You will not copy, modify, distribute any"
                                        " other service provider Content without "
                                        "consent of    the respective provider \n\n"
                                        "> You have the necessary license or are"
                                        " otherwise authorized, as required by"
                                        " applicable law, to offer for service,"
                                        " to advertise and distribute items "
                                        "described in your announcement.\n\n",
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
