import 'package:flutter/material.dart';
import '../modules/create_unique_uid.dart';
import "../web/ntk_map_view_state_web.dart"
    if (dart.library.io) "../mobile/ntk_map_view_state_mobile.dart" as st;
import "../web/ntk_map_controller_web.dart"
    if (dart.library.io) "../mobile/ntk_map_controller_mobile.dart" as cont;
import 'package:latlong2/latlong.dart';
import 'ntk_map_controller_interface.dart';

///Widget to display a map this have a **[onCreateStart]**, **[onCreateEnd]**, **[onMapClick]** callbacks
///Also may configure path to map in **[mapPath]**
///And add a **[controller]**
class NtkMapViewInterface extends StatefulWidget {
  ///Widget to display a map this have a **[onCreateStart]**, **[onCreateEnd]**, **[onMapClick]** callbacks
  ///Also may configure path to map in **[mapPath]**
  ///And add a **[controller]**
  NtkMapViewInterface(
      {super.key,
      this.onCreateStart,
      this.onCreateEnd,
      this.onMapClick,
      this.mapPath = "packages/ntk_map_view/assets/map.html",
      NtkMapControllerInterface? mapController}) {
    if (mapController == null) {
      controller = cont.NtkMapController(viewId: createUniqueUid(count: 6));
    } else {
      controller = mapController;
    }

    state = st.NtkMapViewState();
  }

  ///**[onCreateStart]** Callback when map start create
  final Function()? onCreateStart;

  /// **[onCreateEnd]** Callback when map create end(remember that callback for create, this not show end of full init map)
  ///
  /// returned a **[NtkMapControllerInterface]** map controller
  final Function(NtkMapControllerInterface)? onCreateEnd;

  /// **[onMapClick]** Callback when user click on map, returned a point [LatLng]
  final Function(LatLng)? onMapClick;

  ///**[controller]** for this map
  late final NtkMapControllerInterface? controller;

  /// Widget **[state]** for this map
  late final State<NtkMapViewInterface> state;

  /// **[mapPath]** Map path
  final String mapPath;

  @override
  State<NtkMapViewInterface> createState() => state;
}
