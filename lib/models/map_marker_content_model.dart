class MapMarkerContentModel{
  MapMarkerContentModel({required this.title, this.description, this.hexColor = "#000000"});

  String title;
  String? description;
  String? hexColor;

  String toMapJs(){
    var map = '{';
    map += '"title": "$title"';
    if(description != null) map += ', "description": "$description"';
    if(hexColor != null) map += ', "hexColor": "$hexColor"';
    map += '}';

    return map;
  }
}