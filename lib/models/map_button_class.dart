class MapButtonClass {
  MapButtonClass({
    required this.name,
    required this.act,
    this.height,
    this.width,
    this.borderRadius,
    this.colorHex,
    this.textColorHex
  });

  final String name;
  final Function act;

  int? height;
  int? width;
  int? borderRadius;

  String? colorHex;
  String? textColorHex;

  String? id;

  Map<String, dynamic> toMap() => {
    'name': name,
    'id': id,
    'act': act,
    'height': height,
    'width': width,
    'borderRadius': borderRadius,
    'colorHex': colorHex,
    'textColorHex': textColorHex
  };

  String toMapJs(){
    var map = '{';
      map += '"name": "$name"';
      if(id != null) map += ', "id": "$id"';
      if(height != null) map += ', "height": "$height"';
      if(width != null) map += ', "width": "$width"';
      if(borderRadius != null) map += ', "borderRadius": "$borderRadius"';
      if(colorHex != null) map += ', "colorHex": "$colorHex"';
      if(textColorHex != null) map += ', "textColorHex": "$textColorHex"';
    map += '}';

    return map;
  }
}
