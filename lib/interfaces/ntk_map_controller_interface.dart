


import '../mobile/ntk_map_controller_mobile.dart'
if(dart.library.html)'../web/ntk_map_controller_web.dart';


import 'package:latlong2/latlong.dart';

import '../modules/create_unique_uid.dart';

///Interface to Ntk map controller
abstract class NtkMapControllerInterface{
  ///Interface to Ntk map controller
  ///
  ///We need to put [viewId] to avoid unhandled error when init

  NtkMapControllerInterface({required this.viewId});
  String viewId;

  Map<String, Function> markersAction = {};

  Map<LatLng, Function(LatLng point)> markers = {};

  addMarker(LatLng point, Function(LatLng point)? callback);
  goToPoint(LatLng point);
  goToPointThenZoom(LatLng point, double zoom);
  addCustomMarker(LatLng point, String title, List<String> names, List<Function> acts);

  addPolyline(List<LatLng> points);

  static NtkMapControllerInterface init(String? viewId){
    return NtkMapController(viewId: viewId ?? createUniqueUid(count: 6));
  }
}