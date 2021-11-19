import 'package:alen/providers/language.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUs extends StatelessWidget {
  const ContactUs({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder<dynamic>(
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
                title: Text("Contact Us"),
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
                            Card(
                              elevation: 4,
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "Alen",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 40, bottom: 30),
                                  ),
                                  Container(
                                    child: Text(
                                      "Alen is created and Owned by alen call center and mobile application and developed by Qemer Software Technology.",
                                      textAlign: TextAlign.center,
                                      maxLines: 4,
                                    ),
                                    margin: EdgeInsets.fromLTRB(30, 0, 30, 70),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Card(
                              elevation: 4,
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                        "Contact Us",
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(top: 30)
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () => launch("tel://9484"),
                                              icon: Icon(
                                                MdiIcons.phone,
                                                color: myCustomColors.loginBackgroud,
                                              ),
                                            ),
                                            Text("Call Us")
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                launch("http://t.me/alen9484");
                                              },
                                              icon: Icon(
                                                MdiIcons.telegram,
                                                color: myCustomColors.loginBackgroud,
                                              ),
                                            ),
                                            Text("Telegram")
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final coords = Coords(
                                                    9.068365128410308, 38.71896070648838
                                                );
                                                final availableMaps = await MapLauncher.installedMaps;
                                                print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                                await availableMaps.first.showMarker(
                                                  coords: coords,
                                                  title: "Hyssop pharma Trading PLC",
                                                  description: "Alen Headquarters",
                                                );
                                              },
                                              icon: Icon(
                                                Icons.location_on_outlined,
                                                color: myCustomColors.loginBackgroud,
                                              ),
                                            ),
                                            Text("Office")
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
