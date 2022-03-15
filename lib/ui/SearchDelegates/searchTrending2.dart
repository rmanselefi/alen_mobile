import 'package:alen/models/TrendingSearchable.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/SearchDelegates/Details/CompanyDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/DiagnosisDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/EmergencyMSDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/HomeCareDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/HospitalDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/ImporterDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/LabDetail.dart';
import 'package:alen/ui/SearchDelegates/Details/PharmacyDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';


class TrendingSearch2 extends SearchDelegate<TrendingSearchable> {
  static const myCustomColors = AppColors();
  TrendingSearchable result;
  final List<TrendingSearchable> trendings;
  final String searchFor;

  TrendingSearch2({this.trendings, this.searchFor});


  @override
  String get searchFieldLabel => searchFor;

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
      return trending.title.toLowerCase().contains((query.toLowerCase()));
    });

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
                onTap: () {
                  result = suggestions.elementAt(index);
                  // result.searchType==SearchType.ServiceProvider?
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          (result.type==Type.Hospital)
                              ?
                          HospitalDetail(
                              hospitalId: result.id
                          )
                              :(result.type==Type.Pharmacy)
                              ?
                          PharmacyDetail(
                              pharmacyId: result.id
                          )
                              :(result.type==Type.Importer)
                              ?
                          ImporterDetail(
                              importerId: result.id
                          )
                              :(result.type==Type.HomeCare)
                              ?
                          HomeCareDetail(
                              homeCareId: result.id
                          )
                              :(result.type==Type.Diagnosis)
                              ?
                          DiagnosisDetail(
                              diagnosisId: result.id
                          )
                              :(result.type==Type.EmergencyMS)
                              ?
                          EmergencyMSDetail(
                              emergencyMSId: result.id
                          )
                              :(result.type==Type.Lab)
                              ?
                          LabDetail(
                              labId: result.id
                          )
                              :CompanyDetail(
                              companyId: result.id
                          )
                      ));
                },
                title: Text(suggestions.elementAt(index).title),
                subtitle: Text(
                  // (suggestions.elementAt(index).searchType==SearchType.Drug
                  //     || suggestions.elementAt(index).searchType==SearchType.Service)?
                  // suggestions.elementAt(index).hospitalsLabsDiagnostics.name??""
                  //     :
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
      return trending.title.toLowerCase().contains((query.toLowerCase()));
    });

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(
                onTap: () {
                  result = suggestions.elementAt(index);
                  // result.searchType==SearchType.ServiceProvider?
                  print("/*/*/*/*/*/*/*/*/*/*/*/*/*/");
                  print(result.title);
                  print(result.id);
                  print(result.type);
                  print(result.searchType);
                  print(result.image);
                  print(result.description);
                  print("/*/*/*/*/*/*/*/*/*/*/*/*/*/");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          (result.type==Type.Hospital)
                              ?
                          HospitalDetail(
                              hospitalId: result.id
                          )
                              :(result.type==Type.Pharmacy)
                              ?
                          PharmacyDetail(
                              pharmacyId: result.id
                          )
                              :(result.type==Type.Importer)
                              ?
                          ImporterDetail(
                              importerId: result.id
                          )
                              :(result.type==Type.HomeCare)
                              ?
                          HomeCareDetail(
                              homeCareId: result.id
                          )
                              :(result.type==Type.Diagnosis)
                              ?
                          DiagnosisDetail(
                              diagnosisId: result.id
                          )
                              :(result.type==Type.EmergencyMS)
                              ?
                          EmergencyMSDetail(
                              emergencyMSId: result.id
                          )
                              :(result.type==Type.Lab)
                              ?
                          LabDetail(
                              labId: result.id
                          )
                              :CompanyDetail(
                              companyId: result.id
                          )
                      ));
                },
                title: Text(suggestions.elementAt(index).title),
                subtitle: Text(
                  // (suggestions.elementAt(index).searchType==SearchType.Drug
                  //     || suggestions.elementAt(index).searchType==SearchType.Service)?
                  // suggestions.elementAt(index).hospitalsLabsDiagnostics.name??""
                  //     :
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
}
