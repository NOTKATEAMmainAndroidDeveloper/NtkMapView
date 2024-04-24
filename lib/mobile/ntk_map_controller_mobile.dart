import '../interfaces/ntk_map_controller_interface.dart';
import '../mobile/ntk_map_view_state_mobile.dart';
import 'package:latlong2/latlong.dart';

class NtkMapController extends NtkMapControllerInterface {
  NtkMapController({required super.viewId});

  @override
  addMarker(LatLng point, Function(LatLng point)? callback){
    if(callback != null){
      super.markers[point] = callback;
    }

    NtkMapViewState.controller.runJavaScript("_addMarker(${point.latitude}, ${point.longitude})");
  }

  @override
  goToPoint(LatLng point){
    NtkMapViewState.controller.runJavaScript("_goToPoint(${point.latitude}, ${point.longitude})");
  }

  @override
  goToPointThenZoom(LatLng point, double zoom){
    NtkMapViewState.controller.runJavaScript("_goToPointThenZoom(${point.latitude}, ${point.longitude}, $zoom)");
  }

  @override
  addCustomMarker(LatLng point, String title, List<String> names, List<Function> acts) {
    // TODO: implement addCustomMarker
    throw UnimplementedError();
  }

  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap = points.map((e) => [e.latitude, e.longitude]).toList();

    NtkMapViewState.controller.runJavaScript("_createPolyline(${[pointsForMap]})");
  }
}