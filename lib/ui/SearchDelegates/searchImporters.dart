import 'package:alen/models/importer.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';

import '../../utils/DetailsPage.dart';

class ImporterSearch extends SearchDelegate<Importers> {
  static const myCustomColors = AppColors();
  Importers result;
  final List<Importers> importers;

  ImporterSearch({this.importers});

  @override
  String get searchFieldLabel => 'Search Importers...';

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
    final suggestions = importers.where((importer) {
      return importer.name.toLowerCase().contains((query.toLowerCase()));
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
                          builder: (context) => ImporterDetail(
                            id: result.Id,
                            title: result.name,
                            phone: result.phone,
                            imagesList: result.image,
                            name: result.name,
                            images: result.images,
                            description:result.description,
                            latitude: result.latitude.toStringAsFixed(3),
                            longtude: result.longitude.toStringAsFixed(3),
                            email: result.email,
                            officeHours: result.officehours,
                          )));
                },
                title: Text(suggestions.elementAt(index).name),
                subtitle: Text(
                  suggestions.elementAt(index).description,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    suggestions.elementAt(index).images.first,
                  ),
                )),
            Divider(color: Colors.black38)
          ]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = importers.where((importer) {
      return importer.name.toLowerCase().contains((query.toLowerCase()));
    });
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
              tileColor: myCustomColors.mainBackground,
              title: Text(suggestions.elementAt(index).name),
              subtitle: Text(
                suggestions.elementAt(index).description,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                suggestions.elementAt(index).images.first,
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
