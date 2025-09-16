import 'dart:js_interop_unsafe';

import 'package:latlong2/latlong.dart';
import 'package:ntk_map_view/models/map_button_class.dart';
import 'package:ntk_map_view/models/map_filter_class.dart';
import 'package:ntk_map_view/models/map_marker_content_model.dart';
import 'package:ntk_map_view/models/map_marker_icon_model.dart';
import 'dart:js_interop' if (dart.library.io) '' as js_util;

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

    js_util.globalContext.callMethodVarArgs('_addMarker'.toJS, [point.latitude.toJS, point.longitude.toJS]);
  }

  ///Move center camera on **[point]** (like panTo in leaflet)
  @override
  goToPoint(LatLng point) {
    js_util.globalContext.callMethodVarArgs('_goToPoint'.toJS, [point.latitude.toJS, point.longitude.toJS]);
    // js_util.callMethod<void>(
    //     js_util.globalThis, '_goToPoint', [point.latitude, point.longitude]);
  }

  ///Move camera to **[point]** and **[zoom]** (like flyTo in leaflet)
  @override
  goToPointThenZoom(LatLng point, double zoom) {
    js_util.globalContext.callMethodVarArgs('_goToPointThenZoom'.toJS, [point.latitude.toJS, point.longitude.toJS, zoom.toJS]);
  }

  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on **[point]**
  ///with **[title]**
  ///buttons with **[names]**
  ///and callbacks **[acts]**

  @override
  addCustomMarker(
      {required LatLng point,
      required String title,
        MapMarkerIconModel? icon,
      required List<MapButtonClass> buttons,
      List<String>? images,
      List<MapMarkerContentModel>? content}) {
    List<String> buttIds = [];

    for (int index = 0; index < buttons.length; index++) {
      String id = createUniqueUid(count: 6, isNumberEnabled: false);
      buttIds.add(id);

      buttons[index] = buttons[index]..id = id;

      //print(id);
      super.markersAction[id] = buttons[index].act;
    }

    js_util.globalContext.callMethodVarArgs('_addMarkerCustom'.toJS, [
      point.latitude.toJS,
      point.longitude.toJS,
      title.toJS,
      icon != null ? icon.toMapJs().toJS : "none".toJS,
      [...buttons.map((e) => e.toMapJs().toJS)].toJS,
      images != null ? [...images.map((e) => e.toJS)].toJS : null,
      content != null ? [...content.map((e) => e.toMapJs().toJS)].toJS : null,
    ]);
  }

  ///Create polyline on List of **[points]** (also clear all previous polyline)
  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap = points.map((e) => [e.latitude, e.longitude]).toList();

    js_util.globalContext.callMethodVarArgs('_createPolyline'.toJS, [
      [
        ...pointsForMap.map((e) => [...e.map((last) => last.toJS)].toJS)
      ].toJS
    ]);

    // js_util.callMethod<void>(
    //     js_util.globalThis, '_createPolyline', [pointsForMap]);
  }

  ///Update **[filter]** map
  @override
  applyNewFilter(MapFilter filter) {
    js_util.globalContext.callMethodVarArgs('_updateFilter'.toJS, [
      [...filter.toParameterString().map((e) => e.toJS)].toJS
    ]);
    // js_util.callMethod<void>(
    //     js_util.globalThis, '_updateFilter', [filter.toParameterString()]);
  }

  ///Update current position on map
  ///This create a circle and marker with center in **[point]**
  ///Radius of circle is **[accuracy]**
  @override
  updateCurrentPosition(LatLng point, double accuracy) {
    js_util.globalContext.callMethodVarArgs('_updateCurrentPosition'.toJS, [point.latitude.toJS, point.longitude.toJS, accuracy.toJS]);

    // js_util.callMethod<void>(js_util.globalThis, '_updateCurrentPosition',
    //     [point.latitude, point.longitude, accuracy]);
  }

  @override
  clearAllMarkers() {
    js_util.globalContext.callMethod(
      '_clearAllMarkers'.toJS,
    );
  }
}
