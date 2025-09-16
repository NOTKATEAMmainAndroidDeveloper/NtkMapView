import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../interfaces/ntk_view_interface.dart';
import '../web/ntk_map_controller_web.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as html;

import 'dart:ui_web' if (dart.library.io) '' as ui;

import 'package:latlong2/latlong.dart';

///Web state for widget
@JSExport()
class NtkMapViewState extends State<NtkMapViewInterface> {
  late String viewID;

  ///Internal callback when user click on map
  ///
  /// param:
  /// **[lat]** - latitude on point
  /// **[lon]** - longitude of point
  @JSExport()
  void onMapCl(double lat, double lon) {
    if (widget.onMapClick != null) {
      widget.onMapClick!(LatLng(lat, lon));
    }
  }

  ///Internal callback when user click on markers button
  ///
  /// param:
  /// **[buttonId]** - id of clicked button
  @JSExport()
  void customCl(String buttonId) {
    widget.controller!.markersAction[buttonId]!();
  }

  @JSExport()
  void onCreatedEnd() {
    widget.onCreateEnd!(widget.controller! as NtkMapController);
  }

  ///This a internal callback when user click on marker
  ///
  /// param:
  /// **[lat]** - latitude on point
  /// **[lon]** - longitude of point
  @JSExport()
  void increment(var lat, var lon) {
    try {
      LatLng point = LatLng(lat, lon);

      if (widget.controller!.markers.containsKey(point)) {
        widget.controller!.markers[point]!(point);
      } else {}
    } catch (_) {}
  }

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    }

    viewID = widget.controller!.viewId;

    if (widget.onCreateStart != null) widget.onCreateStart!();

    ui.platformViewRegistry.registerViewFactory(viewID, (int id) {
      globalContext.setProperty("onMapCl".toJS, onMapCl.toJS);
      globalContext.setProperty("customCl".toJS, customCl.toJS);
      globalContext.setProperty("onCreatedEnd".toJS, onCreatedEnd.toJS);

      return html.HTMLIFrameElement()
        ..id = viewID
        ..width = MediaQuery.of(context).size.width.toString()
        ..height = MediaQuery.of(context).size.height.toString()
        ..src = widget.mapPath
        ..style.border = 'none';
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: HtmlElementView(
        viewType: viewID,
      ),
    );
  }
}
