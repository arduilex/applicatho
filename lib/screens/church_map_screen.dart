import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../models/church.dart';
import '../services/firebase_service.dart';
import '../widgets/app_drawer.dart';
import '../utils/constants.dart';

class ChurchMapScreen extends StatefulWidget {
  const ChurchMapScreen({super.key});

  @override
  State<ChurchMapScreen> createState() => _ChurchMapScreenState();
}

class _ChurchMapScreenState extends State<ChurchMapScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final MapController _mapController = MapController();
  LatLng? _userLocation;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() => _isLoadingLocation = false);
    }
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, from, to);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.churchMap),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder<List<Church>>(
        stream: _firebaseService.getChurches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final churches = snapshot.data ?? [];
          if (churches.isEmpty) {
            return const Center(
              child: Text('Aucune église disponible'),
            );
          }

          final center = _userLocation ?? churches.first.location;

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.applicatho',
                  ),
                  MarkerLayer(
                    markers: [
                      if (_userLocation != null)
                        Marker(
                          point: _userLocation!,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ...churches.map((church) => Marker(
                        point: church.location,
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () => _showChurchDetails(church),
                          child: const Icon(
                            Icons.church,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
              if (_isLoadingLocation)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: _buildChurchList(churches),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChurchList(List<Church> churches) {
    final sortedChurches = List<Church>.from(churches);
    if (_userLocation != null) {
      sortedChurches.sort((a, b) {
        final distanceA = _calculateDistance(_userLocation!, a.location);
        final distanceB = _calculateDistance(_userLocation!, b.location);
        return distanceA.compareTo(distanceB);
      });
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortedChurches.length,
        itemBuilder: (context, index) {
          final church = sortedChurches[index];
          final distance = _userLocation != null
              ? _calculateDistance(_userLocation!, church.location)
              : null;

          return GestureDetector(
            onTap: () {
              _mapController.move(church.location, 15.0);
              _showChurchDetails(church);
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    church.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (distance != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${distance.toStringAsFixed(1)} km',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChurchDetails(Church church) {
    final distance = _userLocation != null
        ? _calculateDistance(_userLocation!, church.location)
        : null;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.church, color: AppColors.primary, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    church.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (distance != null)
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Distance: ${distance.toStringAsFixed(1)} km',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.place, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    church.address,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            if (church.phone.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    church.phone,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
            if (church.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                church.description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
