import 'package:ntk_map_view/models/map_button_class.dart';
import 'package:ntk_map_view/models/map_filter_class.dart';
import 'package:ntk_map_view/models/map_marker_content_model.dart';
import 'package:ntk_map_view/models/map_marker_icon_model.dart';

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

    NtkMapViewState.controller.runJavaScript("L.marker(L.latLng(${point.latitude}, ${point.longitude})).addTo(map);");
  }

  ///Move center camera on [point] (like panTo in leaflet)
  @override
  goToPoint(LatLng point) {
    NtkMapViewState.controller.runJavaScript("map.panTo(L.latLng(${point.latitude}, ${point.longitude}));");
  }

  ///Move camera to [point] and [zoom] (like flyTo in leaflet)
  @override
  goToPointThenZoom(LatLng point, double zoom) {
    NtkMapViewState.controller.runJavaScript("map.flyTo(L.latLng(${point.latitude}, ${point.longitude}), $zoom, { animate: true, duration: 1 });");
  }

  ///Create marker on point with title, in this marker you may configure a button and its callback
  ///on [point]
  ///with [title]
  ///buttons with [names]
  ///and callbacks [acts]

  @override
  addCustomMarker(
      {required LatLng point,
      required String title,
      MapMarkerIconModel? icon,
      required List<MapButtonClass> buttons,
      List<String>? images,
      List<MapMarkerContentModel>? content}) {

    // String buttIdsString = "[";
    // String namesStr = "[";
    //
    // List<String> buttIds = [];
    // for (var act in buttons) {
    //   String id = createUniqueUid(count: 6, isNumberEnabled: false);
    //
    //   buttIds.add(id);
    //   buttIdsString += '"$id", ';
    //   //print(id);
    //   super.markersAction[id] = act.act;
    //
    //   namesStr += '"${act.name}", ';
    // }
    //
    // buttIdsString += "]";
    // namesStr += "]";

    List<String> buttIds = [];

    for (int index = 0; index < buttons.length; index++) {
      String id = createUniqueUid(count: 6, isNumberEnabled: false);
      buttIds.add(id);

      buttons[index] = buttons[index]..id = id;

      //print(id);
      super.markersAction[id] = buttons[index].act;
    }

    String iconString = "'none', ";

    if(icon != null){
      iconString = "'";
      iconString += icon.toMapJs();

      iconString += "', ";
    }

    String buttonString = "'none', ";

    if(buttons.isNotEmpty){
      buttonString = "[";

      for(var but in buttons){
        buttonString += "'${but.toMapJs()}', ";
      }

      buttonString.substring(0, buttonString.length - 2);

      buttonString += "]";
    }


    String imagesString = "";

    if(images != null){
      imagesString = ", [";

      for(var img in images){
        imagesString += '"$img", ';
      }

      imagesString.substring(0, imagesString.length - 2);

      imagesString += "]";
    }


    String contentString = "";

    if(content != null){
      contentString = ", [";

      for(var cont in content){
        contentString += "'${cont.toMapJs()}', ";
      }

      contentString.substring(0, contentString.length - 2);

      contentString += "]";
    }


    print(
        "$buttonString"
        "$imagesString"
        "$contentString");


    NtkMapViewState.controller.runJavaScript("_addMarkerCustom("
        "${point.latitude}, "
        "${point.longitude}, "
        "'$title', "
        "$iconString"
        "$buttonString"
        "$imagesString"
        "$contentString"
    ")");
  }

  ///Create polyline on List of [points] (also clear all previous polyline)
  @override
  addPolyline(List<LatLng> points) {
    List<List<double>> pointsForMap = points.map((e) => [e.latitude, e.longitude]).toList();

    NtkMapViewState.controller.runJavaScript("_createPolyline(${[pointsForMap]})");
  }

  ///Update **[filter]** map
  @override
  applyNewFilter(MapFilter filter) {
    var list = filter.toParameterString();

    NtkMapViewState.controller.runJavaScript(
        "newFilter = [ `blur:${list[0]}`, `invert:${list[1]}`, `grayscale:${list[2]}`, `bright:${list[3]}`, `contrast:${list[4]}`, `hue:${list[5]}`, `opacity:${list[6]}`, `saturate:${list[7]}`, `sepia:${list[8]}`, ]; console.log('APPLYING NEW FILTER'); tileLayer.updateFilter(newFilter);");
  }

  ///Update current position on map
  ///This create a circle and marker with center in **[point]**
  ///Radius of circle is **[accuracy]**
  @override
  updateCurrentPosition(LatLng point, double accuracy) {
    NtkMapViewState.controller.runJavaScript("_updateCurrentPosition(${point.latitude}, ${point.longitude}, $accuracy)");
  }

  @override
  clearAllMarkers() {
    NtkMapViewState.controller.runJavaScript("_clearAllMarkers()");
  }
}
