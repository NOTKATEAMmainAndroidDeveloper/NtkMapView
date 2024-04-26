import '../interfaces/ntk_map_controller_interface.dart';
import '../mobile/ntk_map_view_state_mobile.dart';
import 'package:latlong2/latlong.dart';

///NtkMapController for mobile versions of app
class NtkMapController extends NtkMapControllerInterface {

  ///NtkMapController for mobile versions of app
  NtkMapController({required super.viewId});

  ///Add a marker on the map [point] and returned [callback] when you clicked on it
  @override
  addMarker(LatLng point, Function(LatLng point)? callback){
    if(callback != null){
      super.markers[point] = callback;
    }

    NtkMapViewState.controller.runJavaScript("_addMarker(${point.latitude}, ${point.longitude})");
  }

  ///Move center camera on [point] (like panTo in leaflet)
  @override
  goToPoint(LatLng point){
    NtkMapViewState.controller.runJavaScript("_goToPoint(${point.latitude}, ${point.longitude})");
  }

  ///Move camera to [point] and [zoom] (like flyTo in leaflet)
  @override
  goToPointThenZoom(LatLng point, double zoom){
    NtkMapViewState.controller.runJavaScript("_goToPointThenZoom(${point.latitude}, ${point.longitude}, $zoom)");
  }

  ///For now not implemented on mobile, we create this method for new platform as soon as posible
  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on [point]
  ///with [title]
  ///buttons with [names]
  ///and callbacks [acts]
  @override
  addCustomMarker(LatLng point, String title, List<String> names, List<Function> acts) {
    // TODO: implement addCustomMarker
    throw UnimplementedError();
  }

  ///Create polyline on List of [points] (also clear all previous polyline)
  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap = points.map((e) => [e.latitude, e.longitude]).toList();

    NtkMapViewState.controller.runJavaScript("_createPolyline(${[pointsForMap]})");
  }
}