import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PostingOfAnnouncementsByUser extends StatelessWidget {
  const PostingOfAnnouncementsByUser({Key key}) : super(key: key);

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
                                      "POSTING OF ANNOUNCEMENTS BY USERS",
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
                                  child: Text(
                                    "4.1. A service provider shall provide"
                                        " to the Administrator any documents"
                                        " confirming the legitimacy of posting"
                                        " of announcements and identity documents"
                                        " upon the Administrator’s request.\n\n"
                                        "4.2. A service provider, who posts announcements "
                                        "with regard to their services on the Platform,"
                                        " shall provide precise and complete information"
                                        " about such items and services.\n\n"
                                        "4.3. The terms and conditions of services "
                                        "provision developed by the service"
                                        " provider shall not interfere with"
                                        " these Terms and applicable laws.",
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
