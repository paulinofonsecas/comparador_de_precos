// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapControllerWidget extends StatefulWidget {
  const MapControllerWidget({
    required this.localizacao,
    this.width = 250,
    this.height = 250,
    this.initialZoom = 17,
    super.key,
  });

  final LatLng localizacao;
  final double width;
  final double height;
  final double initialZoom;

  @override
  MapControllerWidgetState createState() => MapControllerWidgetState();
}

class MapControllerWidgetState extends State<MapControllerWidget> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.localizacao,
                initialZoom: widget.initialZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.localizacao,
                      child: Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
