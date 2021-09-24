import 'package:alen/models/drugs.dart';
import 'package:alen/models/hospital.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Details/CompanyDetail.dart';
import 'package:alen/ui/Details/DiagnosticDetail.dart';
import 'package:alen/ui/Details/HomeCareDetail.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Details/LabDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';

import '../../utils/DetailsPage.dart';

class TrendingSearch extends SearchDelegate<HospitalsLabsDiagnostics> {
  static const myCustomColors = AppColors();
  HospitalsLabsDiagnostics result;
  final List<HospitalsLabsDiagnostics> trendings;

  TrendingSearch({this.trendings});

  @override
  String get searchFieldLabel => 'Search Everything...';

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
          color: myCustomColors.loginBackgroud
      ),
      scaffoldBackgroundColor: myCustomColors.mainBackground,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
      // cursor color
      hintColor: Colors.white,
      //hint text color
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      //icons color
      primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(
            fontWeight: FontWeight.normal, color: Colors.white), // query Color
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = trendings.where((trending) {
      return trending.name.toLowerCase().contains((query.toLowerCase()));
    });

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
                onTap: () {
                  result = suggestions.elementAt(index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          (result.type==Type.Hospital)
                              ?
                          HospitalDetail(
                            title: result.name,
                            phone: result.phone,
                            image: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            locationName: result.locationName,
                            hospitalId: result.Id,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                              :(result.type==Type.Lab)
                              ?
                          LabDetail(
                            title: result.name,
                            phone: result.phone,
                            image: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            locationName: result.locationName,
                            hospitalId: result.Id,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                              :(result.type==Type.Diagnosis)
                              ?
                          DiagnosticDetail(
                            title: result.name,
                            phone: result.phone,
                            image: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            locationName: result.locationName,
                            hospitalId: result.Id,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                              :(result.type==Type.Pharmacy)
                              ?
                          PharamacyDetail(
                            title: result.name,
                            phone: result.phone,
                            imagesList: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            id: result.Id,
                            locationName: result.locationName,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                              :(result.type==Type.Importer)
                              ?
                          ImporterDetail(
                            title: result.name,
                            phone: result.phone,
                            imagesList: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            id: result.Id,
                            locationName: result.locationName,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          ):(result.type==Type.HomeCare)
                              ?
                          HomeCareDetail(
                            title: result.name,
                            phone: result.phone,
                            image: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            hospitalId: result.Id,
                            locationName: result.locationName,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                              :CompanyDetail(
                            title: result.name,
                            phone: result.phone,
                            image: result.image,
                            name: result.name,
                            images: result.images,
                            email: result.email,
                            locationName: result.locationName,
                            hospitalId: result.Id,
                            description: result.description,
                            latitude: result.latitude.toString(),
                            longtude: result.longitude.toString(),
                            officeHours: result.officehours,
                          )
                      ));
                },
                title: Text(suggestions.elementAt(index).name),
                subtitle: Text(
                  (suggestions.elementAt(index).description!=null)?
                  suggestions.elementAt(index).description:
                  "",
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: (suggestions.elementAt(index).image!=null)?NetworkImage(
                    suggestions.elementAt(index).image,
                  ):AssetImage(
                    'assets/images/alen_no_name.png',
                  ),
                )),
            Divider(color: Colors.black38)
          ]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = trendings.where((trending) {
      return trending.name.toLowerCase().contains((query.toLowerCase()));
    });
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
              tileColor: myCustomColors.mainBackground,
              title: Text(suggestions.elementAt(index).name),
              subtitle: Text(
                (suggestions.elementAt(index).description!=null)?
                suggestions.elementAt(index).description:
                "",
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundImage: (suggestions.elementAt(index).image!=null)?NetworkImage(
                  suggestions.elementAt(index).image,
                ):AssetImage(
                  'assets/images/alen_no_name.png',
                ),
              ),
              onTap: () {
                query = suggestions.elementAt(index).name;
              },
            ),
            Divider(
              color: Colors.black38,
            )
          ]);
        });
  }
}
