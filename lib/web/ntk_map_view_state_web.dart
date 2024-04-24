import '../interfaces/ntk_view_interface.dart';
import '../web/ntk_map_controller_web.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;


import 'dart:ui_web'
if (dart.library.io) '' as ui;

import 'package:js/js.dart'
if (dart.library.io) '' as js;

import 'package:latlong2/latlong.dart';
import 'package:universal_html/js_util.dart' as js_util;


@js.JSExport()
class NtkMapViewState extends State<NtkMapViewInterface> {
  late String viewID;

  @js.JSExport()
  void onMapCl(lat, lon) {
    if(widget.onMapClick != null){
      widget.onMapClick!(LatLng(lat, lon));
    }
  }

  @js.JSExport()
  void customCl(buttonId){
    print("Вы нажали на ${buttonId.id}");
    widget.controller!.markersAction[buttonId.id]!();
  }

  @js.JSExport()
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

    print("check that act is allowed");
    print(widget.onMapClick != null);

    print("check that act is allowed");
    print(widget.onCreateEnd != null);

    if(widget.onCreateStart != null)widget.onCreateStart!();
    final export = js_util.createDartExport(this);

    ui.platformViewRegistry.registerViewFactory(
        viewID, (int id){
          js_util.setProperty(js_util.globalThis, '_appState', export);

          return html.IFrameElement()
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
        onPlatformViewCreated: (e){
          widget.onCreateEnd!(widget.controller! as NtkMapController);

          print("VIEW $viewID CREATED");
        },
      ),
    );
  }
}
