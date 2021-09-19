import 'package:alen/models/drugs.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';

import '../../utils/DetailsPage.dart';

class TrendingSearch extends SearchDelegate<Drugs> {
  static const myCustomColors = AppColors();
  Drugs result;
  final List<Drugs> trendings;

  TrendingSearch({this.trendings});

  @override
  String get searchFieldLabel => 'Search Trendings...';

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
                          builder: (context) => (result.pharmacies.isPharma)
                              ?
                          PharamacyDetail(
                            title: result.pharmacies.name,
                            phone: result.pharmacies.phone,
                            imagesList: result.pharmacies.image,
                            name: result.pharmacies.name,
                            images: result.pharmacies.images,
                            email: result.pharmacies.email,
                            id: result.pharmacies.Id,
                            description: result.pharmacies.description,
                            latitude: result.pharmacies.latitude.toStringAsFixed(3),
                            longtude: result.pharmacies.longitude.toStringAsFixed(3),
                            officeHours: result.pharmacies.officehours,
                          )
                              :
                          ImporterDetail(
                            title: result.pharmacies.name,
                            phone: result.pharmacies.phone,
                            imagesList: result.pharmacies.image,
                            name: result.pharmacies.name,
                            images: result.pharmacies.images,
                            email: result.pharmacies.email,
                            id: result.pharmacies.Id,
                            description: result.pharmacies.description,
                            latitude: result.pharmacies.latitude.toStringAsFixed(3),
                            longtude: result.pharmacies.longitude.toStringAsFixed(3),
                            officeHours: result.pharmacies.officehours,
                          )
                      ));
                },
                title: Text(suggestions.elementAt(index).name),
                subtitle: Text(
                  suggestions.elementAt(index).category,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    suggestions.elementAt(index).image,
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
                suggestions.elementAt(index).category,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                suggestions.elementAt(index).image,
              )),
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
