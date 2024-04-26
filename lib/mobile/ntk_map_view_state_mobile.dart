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

  @override
  void initState() {
    if (mounted) {
      setState(() {});
    }

    viewID = widget.controller!.viewId;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset(widget.mapPath).then((value) => {
            controller.runJavaScript("console.log('HELLO From Flutter!!')"),
            widget.onCreateEnd!(widget.controller! as NtkMapController),
            controller.setOnConsoleMessage((message) {
              if (message.message.toString().contains('point')) {
                var cor = message.message.split(' ');
                increment(double.parse(cor[1]), double.parse(cor[2]));
              }

              //print("rec mes ${message.message.toString()}");
            })
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        child: WebViewWidget(
          controller: controller,
        ));
  }
}
