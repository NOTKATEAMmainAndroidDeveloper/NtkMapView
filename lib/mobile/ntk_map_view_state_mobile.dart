import '../interfaces/ntk_view_interface.dart';
import '../mobile/ntk_map_controller_mobile.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NtkMapViewState extends State<NtkMapViewInterface> {
  late String viewID;

  static late WebViewController controller;

  void increment(var lat, var lon) {
    try{
      LatLng point = LatLng(lat, lon);

      if(widget.controller!.markers.containsKey(point)){
        widget.controller!.markers[point]!(point);
      }else{
        print("dont find this marker with lon:${point.longitude}");
        print("and all point in controller:");
        print("controller viewId ${widget.controller?.viewId}");
        widget.controller?.markers.keys.map((e) => print(e.longitude));
      }

    }catch(ex){
      print(ex.toString());
      print("To allow this action be sure you init controller");
    }
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
          if(message.message.toString().contains('point')){

            var cor = message.message.split(' ');
            increment(double.parse(cor[1]), double.parse(cor[2]));

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
      child: WebViewWidget(
        controller: controller,
      )
    );
  }
}
