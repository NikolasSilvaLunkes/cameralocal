import 'package:app/components/es_container.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage(
      {Key? key,
      required this.title,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  final String title;
  final double latitude;
  final double longitude;

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(widget.latitude, widget.longitude),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ESContainer(
        widgets: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 11.0,
              ),
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
