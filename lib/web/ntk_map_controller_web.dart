import 'package:latlong2/latlong.dart';
import 'package:universal_html/js_util.dart'
if (dart.library.io) '' as js_util;

import '../interfaces/ntk_map_controller_interface.dart';
import '../modules/create_unique_uid.dart';

class NtkMapController extends NtkMapControllerInterface {
  NtkMapController({required super.viewId});

  @override
  addMarker(LatLng point, Function(LatLng point)? callback){
    if(callback != null){
      super.markers[point] = callback;
      print("add new point");
      print(super.markers.containsKey(point));
    }

    js_util.callMethod<void>(js_util.globalThis, '_addMarker', [point.latitude, point.longitude]);
  }

  @override
  goToPoint(LatLng point){
    js_util.callMethod<void>(js_util.globalThis, '_goToPoint', [point.latitude, point.longitude]);
  }

  @override
  goToPointThenZoom(LatLng point, double zoom){
    js_util.callMethod<void>(js_util.globalThis, '_goToPointThenZoom', [point.latitude, point.longitude, zoom]);
  }

  @override
  addCustomMarker(LatLng point, String title, List<String> names, List<Function> acts) {
    List<String> buttIds = [];
    for(var act in acts){
      String id = createUniqueUid(count: 6, isNumberEnabled: false);

      buttIds.add(id);
      //print(id);
      super.markersAction[id] = act;
    }

    js_util.callMethod<void>(js_util.globalThis, '_addMarkerCustom', [point.latitude, point.longitude, title, names, buttIds]);
  }

  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap = points.map((e) => [e.latitude, e.longitude]).toList();

    js_util.callMethod<void>(js_util.globalThis, '_createPolyline', [pointsForMap]);
  }
}