import 'package:latlong2/latlong.dart';
import 'package:ntk_map_view/models/map_filter_class.dart';
import 'package:universal_html/js_util.dart' if (dart.library.io) '' as js_util;

import '../interfaces/ntk_map_controller_interface.dart';
import '../modules/create_unique_uid.dart';

///NtkMapController for web versions of app
class NtkMapController extends NtkMapControllerInterface {
  NtkMapController({required super.viewId});

  ///Add a marker on the map **[point]** and returned **[callback]** when you clicked on it
  @override
  addMarker(LatLng point, Function(LatLng point)? callback) {
    if (callback != null) {
      super.markers[point] = callback;
    }

    js_util.callMethod<void>(
        js_util.globalThis, '_addMarker', [point.latitude, point.longitude]);
  }

  ///Move center camera on **[point]** (like panTo in leaflet)
  @override
  goToPoint(LatLng point) {
    js_util.callMethod<void>(
        js_util.globalThis, '_goToPoint', [point.latitude, point.longitude]);
  }

  ///Move camera to **[point]** and **[zoom]** (like flyTo in leaflet)
  @override
  goToPointThenZoom(LatLng point, double zoom) {
    js_util.callMethod<void>(js_util.globalThis, '_goToPointThenZoom',
        [point.latitude, point.longitude, zoom]);
  }

  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on **[point]**
  ///with **[title]**
  ///buttons with **[names]**
  ///and callbacks **[acts]**
  @override
  addCustomMarker(
      LatLng point, String title, List<String> names, List<Function> acts) {
    List<String> buttIds = [];
    for (var act in acts) {
      String id = createUniqueUid(count: 6, isNumberEnabled: false);

      buttIds.add(id);
      //print(id);
      super.markersAction[id] = act;
    }

    js_util.callMethod<void>(js_util.globalThis, '_addMarkerCustom',
        [point.latitude, point.longitude, title, names, buttIds]);
  }

  ///Create polyline on List of **[points]** (also clear all previous polyline)
  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap =
        points.map((e) => [e.latitude, e.longitude]).toList();

    js_util.callMethod<void>(
        js_util.globalThis, '_createPolyline', [pointsForMap]);
  }

  @override
  applyNewFilter(MapFilter filter) {
    js_util.callMethod<void>(
        js_util.globalThis, '_updateFilter', [filter.toParameterString()]);
  }
}
