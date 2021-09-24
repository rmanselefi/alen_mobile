import 'package:alen/models/homeCare.dart';
import 'package:alen/ui/Details/HomeCareDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';

class HomeCareSearch extends SearchDelegate<HomeCare> {
  static const myCustomColors = AppColors();
  HomeCare result;
  List<HomeCare> homeCare;

  HomeCareSearch({this.homeCare});

  @override
  String get searchFieldLabel => 'Search Home Care...';

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
    final suggestions = homeCare.where((hospital) {
      return hospital.name.toLowerCase().contains((query.toLowerCase()));
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
                          builder: (context) =>HomeCareDetail(
                            title: result.name,
                            info: result.createdAt.toString(),
                            phone: result.phone,
                            image: result.image,
                            images: result.images,
                            latitude: result.latitude.toStringAsFixed(3),
                            longtude: result.longitude.toStringAsFixed(3),
                            email: result.email,
                            name: result.name,
                            description: result.description,
                            location: result.latitude.toString(),
                            services: result.services,
                            newservices:result.services,
                            locationName:result.locationName,
                            officeHours: result.officehours.toString(),
                            hospitalId: result.Id,
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
    final suggestions = homeCare.where((hospital) {
      return hospital.name.toLowerCase().contains((query.toLowerCase()));
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
