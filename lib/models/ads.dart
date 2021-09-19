class Ads {
  String Id;
  String title;
  String image;
  String description;
  Size size;


  Ads({this.Id, this.title, this.description, this.image, this.size});
}

enum Size{
  Small,
  Main
}