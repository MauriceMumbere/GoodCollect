// lib/pages/map_page.dart (Contenu de votre route /home)

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  // Coordonnées initiales (Exemple : Paris)
  final LatLng initialPoint = const LatLng(-4.4419, 15.2662);

  @override
  Widget build(BuildContext context) {
    // ⚠️ Cette page ne doit pas contenir de Scaffold pour éviter un Scaffold imbriqué,
    // car elle est déjà l'enfant du Scaffold de la HomePage.
    return FlutterMap(
      // 1. Options de la Carte
      options: MapOptions(
        initialCenter: initialPoint,
        initialZoom: 12.0,
        // Active le zoom avec deux doigts sur les appareils mobiles
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),

      // 2. Les Couches de la Carte
      children: [
        // La couche des tuiles (les images de la carte OpenStreetMap)
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.goodcollect', // Remplacez par votre package
          // Optionnel : Pour améliorer le rendu sur les écrans haute résolution
          maxZoom: 19.0,
        ),

        // 3. La Couche des Marqueurs (Markers)
        MarkerLayer(
          markers: [
            // Votre premier marqueur
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
            // Vous pouvez ajouter d'autres marqueurs ici...
          ],
        ),
      ],
    );
  }
}