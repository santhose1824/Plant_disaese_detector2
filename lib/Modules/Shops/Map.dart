import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double startLat;
  final double startLong;
  final double endLat;
  final double endLong;

  MapScreen({
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = Set();
  Set<Polyline> polylines = Set();

  @override
  void initState() {
    super.initState();
    _addMarkersAndPolylines();
  }

  void _addMarkersAndPolylines() {
    final startLocation = LatLng(widget.startLat, widget.startLong);
    final endLocation = LatLng(widget.endLat, widget.endLong);

    // Add markers for start and end locations
    markers.add(
      Marker(
        markerId: MarkerId('start_marker'),
        position: startLocation,
        infoWindow: InfoWindow(title: 'Start Location'),
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId('end_marker'),
        position: endLocation,
        infoWindow: InfoWindow(title: 'End Location'),
      ),
    );

    // Define the polyline between start and end locations
    polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: [startLocation, endLocation],
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Route'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.startLat, widget.startLong), // Initial map location
          zoom: 15.0, // Initial zoom level
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}
