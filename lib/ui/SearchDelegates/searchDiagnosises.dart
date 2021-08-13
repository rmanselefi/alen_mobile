import 'package:flutter/material.dart';
import 'file:///D:/Personal/Workspace/flutter_projects/alen/lib/utils/AppColors.dart';
import 'package:alen/ui/Pages/Diagnosis.dart';

import '../../utils/DetailsPage.dart';

class DiagnosisSearch extends SearchDelegate<Diagnosis> {
  static const myCustomColors = AppColors();
  Diagnosis result = Diagnosis.diagnosises.first;
  final List<Diagnosis> diagnosises;

  DiagnosisSearch(this.diagnosises);

  @override
  String get searchFieldLabel => 'Search Diagnosises...';

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
    final suggestions = diagnosises.where((diagnosis) {
      return diagnosis.name.toLowerCase().contains((query.toLowerCase()));
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
                          builder: (context) => DetailsPage(
                                name: result.name,
                                description: result.detail,
                                imageUrl: result.imagesList.first,
                              )));
                },
                title: Text(suggestions.elementAt(index).name),
                subtitle: Text(
                  suggestions.elementAt(index).detail,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    suggestions.elementAt(index).imagesList.first,
                  ),
                )),
            Divider(color: Colors.black38)
          ]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = diagnosises.where((diagnosis) {
      return diagnosis.name.toLowerCase().contains((query.toLowerCase()));
    });
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
              tileColor: myCustomColors.mainBackground,
              title: Text(suggestions.elementAt(index).name),
              subtitle: Text(
                suggestions.elementAt(index).detail,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                  backgroundImage: AssetImage(
                suggestions.elementAt(index).imagesList.first,
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
