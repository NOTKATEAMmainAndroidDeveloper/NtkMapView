import 'package:flutter/material.dart';


import '../modules/create_unique_uid.dart';
import "../web/ntk_map_view_state_web.dart"
if(dart.library.io) "../mobile/ntk_map_view_state_mobile.dart" as st;

import "../web/ntk_map_controller_web.dart"
if(dart.library.io) "../mobile/ntk_map_controller_mobile.dart" as cont;
import 'package:latlong2/latlong.dart';

import 'ntk_map_controller_interface.dart';

class NtkMapViewInterface extends StatefulWidget {
  NtkMapViewInterface({super.key, this.onCreateStart, this.onCreateEnd, this.onMapClick, this.mapPath = "assets/assets/map.html", NtkMapControllerInterface? mapController}){
    if(mapController == null){
        controller = cont.NtkMapController(viewId: createUniqueUid(count: 6));
    }else{
      controller = mapController;
    }

    state = st.NtkMapViewState();
  }

  final Function()? onCreateStart;
  final Function(NtkMapControllerInterface)? onCreateEnd;
  final Function(LatLng)? onMapClick;

  late final NtkMapControllerInterface? controller;
  late final State<NtkMapViewInterface> state;

  final String mapPath;

  @override
  State<NtkMapViewInterface> createState() => state;
}