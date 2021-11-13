import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class Service extends StatelessWidget {
  const Service({Key key}) : super(key: key);

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
                                      "Service",
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
                                    "3.1. The Platform is an online service that "
                                        "allows service providers to create and "
                                        "publish announcements, users use to view "
                                        "announcements published by service"
                                        " providers, to communicate with service"
                                        " providers using the contact details"
                                        " provided in the announcements.\n\n"
                                        "3.2. The Administrator itself is not an"
                                        " importer, manufacturer, distributor, "
                                        "or seller of any item, as well as not "
                                        "a provider of any service posted by"
                                        " users on the Platform. In addition, "
                                        "the Administrator is neither a marketer"
                                        " nor a person acting on user's behalf"
                                        " with respect to the marketing of any "
                                        "goods or services posted on the Platform. "
                                        "The Administrator provides users with an "
                                        "opportunity to communicate.\n\n"
                                        "3.3. The Administrator reserves a right "
                                        "to delete or block access to announcements "
                                        "posted by service providers with a notice"
                                        " (1) if payment is not issued accordingly "
                                        " (2) if the service provider doesn't serve "
                                        "as the agreement . \n\n"
                                        "3.4. Each Service provider is solely responsible"
                                        " for any and all his or her services.\n\n"
                                        "3.5. You hereby release us, our employees, from "
                                        "claims, demands any and all losses, damages,"
                                        " rights, claims, and actions of any kind "
                                        "including personal injuries, death, and"
                                        " property damage, that is either directly "
                                        "or indirectly related to or arises from any"
                                        " interactions with or conduct of any"
                                        " Service users .\n\n",
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
