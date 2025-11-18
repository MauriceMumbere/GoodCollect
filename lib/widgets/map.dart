import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  final LatLng initialPoint = const LatLng(-4.4419, 15.2662);

  @override
  Widget build(BuildContext context) {

    return FlutterMap(
      options: MapOptions(
        initialCenter: initialPoint,
        initialZoom: 12.0,

        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),

      children: [

        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.goodcollect',

          maxZoom: 19.0,
        ),

        MarkerLayer(
          markers: [
            Marker(
              point: initialPoint,
              width: 80,
              height: 80,
              child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40
              ),
            ),
          ],
        ),
      ],
    );
  }
}