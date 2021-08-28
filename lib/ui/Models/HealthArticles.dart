import '../MyImagesList.dart';

class HealthArticle {
  String name;
  String imagePath;
  String detail;

  HealthArticle(this.name, this.imagePath, this.detail);

  static List<HealthArticle> healthArticles = [
    HealthArticle(
        "HealthArticle 1",
        MyImagesList.healhtArthiclesImages.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum."),
    HealthArticle(
        "HealthArticle 2",
        MyImagesList.healhtArthiclesImages.elementAt(1),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum."),
    HealthArticle(
        "HealthArticle 3",
        MyImagesList.healhtArthiclesImages.elementAt(2),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum."),
    HealthArticle(
        "HealthArticle 4",
        MyImagesList.healhtArthiclesImages.elementAt(3),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum."),
    HealthArticle(
        "HealthArticle 5",
        MyImagesList.healhtArthiclesImages.elementAt(4),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.")
  ];
}
