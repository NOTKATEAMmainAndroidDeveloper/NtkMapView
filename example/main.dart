import 'package:flutter/material.dart';
import 'package:ntk_map_view/interfaces/ntk_view_interface.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: NtkMapViewInterface(),
    );
  }
}
