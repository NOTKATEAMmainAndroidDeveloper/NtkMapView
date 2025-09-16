import 'package:flutter/foundation.dart';

import '../interfaces/ntk_view_interface.dart';
import '../mobile/ntk_map_controller_mobile.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

///Mobile state for widget
class NtkMapViewState extends State<NtkMapViewInterface> {
  ///[viewID] to view
  late String viewID;

  ///[controller] of map widget
  static late WebViewController controller;

  ///This a internal callback when user click on marker
  ///
  /// param:
  /// [lat] - latitude on point
  /// [lon] - longitude of point
  void increment(var lat, var lon) {
    try {
      LatLng point = LatLng(lat, lon);
      if (widget.controller!.markers.containsKey(point)) {
        widget.controller!.markers[point]!(point);
      } else {
        //widget.controller?.markers.keys.map((e) => print(e.longitude));
      }
    } catch (_) {}
  }

  ///This a internal callback when user click on button in custom marker
  ///
  /// param:
  /// [buttonId] - id of button
  void customMarkerTapButton(var buttonId) {
    try {
      if (widget.controller!.markersAction.containsKey(buttonId)) {
        widget.controller!.markersAction[buttonId]!();
      } else {
        //widget.controller?.markers.keys.map((e) => print(e.longitude));
      }
    } catch (_) {}
  }

  ///TCallback when user click on map
  ///
  /// param:
  /// [lat] - latitude of click
  /// [lon] - longitude of click
  void onMapClicked(var lat, var lon) {
    try {
      if (widget.onMapClick != null) {
        widget.onMapClick!(LatLng(lat, lon));
      }
    } catch (_) {}
  }

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    }

    viewID = widget.controller!.viewId;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset(
          kIsWeb ?
          kReleaseMode
              ? "assets/packages/ntk_map_view/assets/map_mobile.html"
              : "packages/ntk_map_view/assets/map_mobile.html"

              : "packages/ntk_map_view/assets/map_mobile.html"
      )
          .then((value) => {
                controller.runJavaScript("console.log('HELLO From Flutter!!')"),
                widget.onCreateEnd!(widget.controller! as NtkMapController),
                controller.setOnConsoleMessage((message) {
                  if (message.message.toString().contains('click')) {
                    var cor = message.message.split(' ');
                    onMapClicked(double.parse(cor[1]), double.parse(cor[2]));
                  } else if (message.message.toString().contains('point')) {
                    var cor = message.message.split(' ');
                    increment(double.parse(cor[1]), double.parse(cor[2]));
                  } else if (message.message
                      .toString()
                      .contains('custommarker')) {
                    var cor = message.message.split(' ');
                    customMarkerTapButton(cor[1].toString());
                  }

                  print("rec mes ${message.message.toString()}");
                })
              });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.width,
        child: WebViewWidget(
          controller: controller,
        ));
  }
}
