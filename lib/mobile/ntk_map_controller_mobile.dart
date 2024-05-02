import 'package:ntk_map_view/models/map_filter_class.dart';

import '../interfaces/ntk_map_controller_interface.dart';
import '../mobile/ntk_map_view_state_mobile.dart';
import 'package:latlong2/latlong.dart';

import '../modules/create_unique_uid.dart';

///NtkMapController for mobile versions of app
class NtkMapController extends NtkMapControllerInterface {
  ///NtkMapController for mobile versions of app
  NtkMapController({required super.viewId});

  ///Add a marker on the map [point] and returned [callback] when you clicked on it
  @override
  addMarker(LatLng point, Function(LatLng point)? callback) {
    if (callback != null) {
      super.markers[point] = callback;
    }

    NtkMapViewState.controller
        .runJavaScript("_addMarker(${point.latitude}, ${point.longitude})");
  }

  ///Move center camera on [point] (like panTo in leaflet)
  @override
  goToPoint(LatLng point) {
    NtkMapViewState.controller
        .runJavaScript("_goToPoint(${point.latitude}, ${point.longitude})");
  }

  ///Move camera to [point] and [zoom] (like flyTo in leaflet)
  @override
  goToPointThenZoom(LatLng point, double zoom) {
    NtkMapViewState.controller.runJavaScript(
        "_goToPointThenZoom(${point.latitude}, ${point.longitude}, $zoom)");
  }

  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on [point]
  ///with [title]
  ///buttons with [names]
  ///and callbacks [acts]
  @override
  addCustomMarker(
      LatLng point, String title, List<String> names, List<Function> acts) {
    String buttIdsString = "[";

    List<String> buttIds = [];
    for (var act in acts) {
      String id = createUniqueUid(count: 6, isNumberEnabled: false);

      buttIds.add(id);
      buttIdsString += '"$id", ';
      //print(id);
      super.markersAction[id] = act;
    }

    buttIdsString += "]";

    String namesStr = "[";
    for (var name in names) {
      namesStr += '"$name", ';
    }
    namesStr += "]";

    NtkMapViewState.controller.runJavaScript(
        "_addMarkerCustom(${point.latitude}, ${point.longitude}, '$title', $namesStr, $buttIdsString)");
  }

  ///Create polyline on List of [points] (also clear all previous polyline)
  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap =
        points.map((e) => [e.latitude, e.longitude]).toList();

    NtkMapViewState.controller
        .runJavaScript("_createPolyline(${[pointsForMap]})");
  }

  ///Update **[filter]** map
  @override
  applyNewFilter(MapFilter filter) {
    var list = filter.toParameterString();

    NtkMapViewState.controller.runJavaScript(
        '_updateFilter("${list[0]}", "${list[1]}", "${list[2]}", "${list[3]}", "${list[4]}", "${list[5]}", "${list[6]}", "${list[7]}", "${list[8]}")');
  }

  ///FOR NOW NOT IMPLEMENTED ON MOBILE
  ///Update current position on map
  ///This create a circle and marker with center in **[point]**
  ///Radius of circle is **[accuracy]**
  @override
  updateCurrentPosition(LatLng point, double accuracy) {
    // TODO: implement updateCurrentPosition
    throw UnimplementedError();
  }
}
