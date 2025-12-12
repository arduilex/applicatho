import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class Church {
  final String id;
  final String name;
  final String address;
  final LatLng location;
  final String phone;
  final String description;

  Church({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    this.phone = '',
    this.description = '',
  });

  factory Church.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Church(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      location: LatLng(
        data['latitude'] ?? 0.0,
        data['longitude'] ?? 0.0,
      ),
      phone: data['phone'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'phone': phone,
      'description': description,
    };
  }
}
