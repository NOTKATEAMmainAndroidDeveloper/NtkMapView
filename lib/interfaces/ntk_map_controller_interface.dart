import 'package:ntk_map_view/models/map_button_class.dart';
import 'package:ntk_map_view/models/map_filter_class.dart';
import 'package:ntk_map_view/models/map_marker_content_model.dart';
import 'package:ntk_map_view/models/map_marker_icon_model.dart';

import '../mobile/ntk_map_controller_mobile.dart' if (dart.library.html) '../web/ntk_map_controller_web.dart';

import 'package:latlong2/latlong.dart';

import '../modules/create_unique_uid.dart';

///Interface to Ntk map controller
abstract class NtkMapControllerInterface {
  ///Interface to Ntk map controller
  ///
  ///We need to put [viewId] to avoid unhandled error when init
  NtkMapControllerInterface({required this.viewId});

  ///viewId of frame
  String viewId;

  ///Markers id and callbacks(for custom markers)
  Map<String, Function> markersAction = {};

  ///Markers point and callback
  Map<LatLng, Function(LatLng point)> markers = {};

  ///Add a marker on the map [point] and returned [callback] when you clicked on it
  addMarker(LatLng point, Function(LatLng point)? callback);

  ///Move center camera on [point] (like panTo in leaflet)
  goToPoint(LatLng point);

  ///Move camera to [point] and [zoom] (like flyTo in leaflet)
  goToPointThenZoom(LatLng point, double zoom);

  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on [point]
  ///with [title]
  ///buttons with [names]
  ///and callbacks [acts]
  addCustomMarker({
    required LatLng point,
    required String title,
    MapMarkerIconModel? icon,
    required List<MapButtonClass> buttons,
    List<String>? images,
    List<MapMarkerContentModel>? content
  });

  ///Create polyline on List of [points] (also clear all previous polyline)
  addPolyline(List<LatLng> points);

  ///Apply a new map **[filter]**
  applyNewFilter(MapFilter filter);

  ///Create a controller for platform
  static NtkMapControllerInterface init(String? viewId) {
    return NtkMapController(viewId: viewId ?? createUniqueUid(count: 6));
  }

  ///Update current position on map
  ///This create a circle and marker with center in **[point]**
  ///Radius of circle is **[accuracy]**
  updateCurrentPosition(LatLng point, double accuracy);

  ///Remove all Markers
  clearAllMarkers();
}
