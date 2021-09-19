import 'package:alen/ui/Models/MainAd.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/DetailsPage.dart';

class SeeAllMainAds extends StatefulWidget {

  @override
  _SeeAllMainAdsState createState() => _SeeAllMainAdsState();
}

class _SeeAllMainAdsState extends State<SeeAllMainAds> {

  static const myCustomColors = AppColors();
  List<MainAd> mainAds = MainAd.mainAds;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
                backgroundColor: myCustomColors.loginBackgroud,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Container(
                          child: mainAds.length == 0
                              ? Center(
                            child: Text(
                              "No Health Articles Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.6,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildMainAdsListItem(
                                  mainAds[index], ctxt);
                            },
                            itemCount: mainAds.length,
                          )),
                    ]))
        );

  }
  _buildMainAdsListItem(MainAd mainAd, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: mainAd.name,
                    description: mainAd.detail,
                    imageUrl: mainAd.imagePath,
                  )));
        },
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
                width: 150,
                height: 180,
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: Image.asset(mainAd.imagePath,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              mainAd.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
