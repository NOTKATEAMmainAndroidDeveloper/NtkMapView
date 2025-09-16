class MapMarkerIconModel{
  MapMarkerIconModel({required this.iconPath, required this.width, required this.height});

  String iconPath;
  double width;
  double height;

  String toMapJs() =>
      '{"iconPath": "$iconPath", '
          '"height": "$height", '
          '"width": "$width"}';
}