import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteDetailsScreen extends StatefulWidget {
  final String location;
  final String subLocation;

  const RouteDetailsScreen({
    super.key,
    required this.location,
    required this.subLocation,
  });

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  // Delivery data based on the location
  final List<DeliveryItem> _deliveries = [
    DeliveryItem(
      id: 'HUB001',
      title: 'Main Hub',
      address: 'Delhi Distribution Center',
      type: 'Pickup Point',
      status: DeliveryItemStatus.pickup,
      color: Colors.blue,
    ),
    DeliveryItem(
      id: 'PKG001',
      title: 'Electronics',
      address: '123 MG Road, Bangalore',
      type: 'Pending - ETA 2:30 PM',
      status: DeliveryItemStatus.pending,
      color: Colors.orange,
    ),
    DeliveryItem(
      id: 'PKG002',
      title: 'Medical Supplies',
      address: '456 Park Street, Kolkata',
      type: 'Completed',
      status: DeliveryItemStatus.completed,
      color: Colors.green,
    ),
    DeliveryItem(
      id: 'PKG003',
      title: 'Documents',
      address: '789 Brigade Road, Bangalore',
      type: 'Urgent',
      status: DeliveryItemStatus.urgent,
      color: Colors.red,
    ),
  ];

  // Route points for the map
  final List<LatLng> _routePoints = [
    const LatLng(28.6139, 77.2090), // Delhi (Blue)
    const LatLng(28.5355, 77.3910), // Point 1 (Red)
    const LatLng(28.4595, 77.0266), // Point 2 (Orange)
    const LatLng(28.7041, 77.1025), // Point 3 (Orange)
    const LatLng(28.5355, 77.3910), // Point 4 (Green)
    const LatLng(28.7041, 77.1025), // Point 5 (Green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Route",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'India Map View',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '15-01-2024',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 3,
            child: _buildMap(),
          ),
          // Stats Section
          _buildStats(),
          // Action Buttons
          _buildActionButtons(),
          // Deliveries List
          Expanded(
            flex: 2,
            child: _buildDeliveriesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      color: Colors.grey[50],
      child: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(28.6139, 77.2090),
          initialZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.go_rahi',
          ),
          // Route polygon
          PolygonLayer(
            polygons: [
              Polygon(
                points: _routePoints,
                color: Colors.blue.withOpacity(0.1),
                borderColor: Colors.blue,
                borderStrokeWidth: 2,
                isFilled: true,
              ),
            ],
          ),
          // Markers
          MarkerLayer(
            markers: [
              // Blue marker (You/Pickup)
              Marker(
                point: const LatLng(28.6139, 77.2090),
                width: 60,
                height: 60,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Text(
                        'You',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.location_on, color: Colors.blue, size: 30),
                  ],
                ),
              ),
              // Red marker
              Marker(
                point: const LatLng(28.5355, 77.3910),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.red, size: 30),
              ),
              // Orange markers
              Marker(
                point: const LatLng(28.4595, 77.0266),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.orange, size: 30),
              ),
              Marker(
                point: const LatLng(28.7041, 77.1025),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.orange, size: 30),
              ),
              // Green markers
              Marker(
                point: const LatLng(28.6500, 77.3500),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.green, size: 30),
              ),
              Marker(
                point: const LatLng(28.5700, 77.2500),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.green, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('2', 'Pickup', Colors.blue),
          _buildStatItem('3', 'Pending', Colors.orange),
          _buildStatItem('2', 'Completed', Colors.green),
          _buildStatItem('1', 'Urgent', Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('NFC Scan initiated')),
                );
              },
              icon: const Icon(Icons.nfc, size: 20),
              label: const Text('NFC Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Route optimized')),
                );
              },
              icon: const Icon(Icons.route, size: 20),
              label: const Text('Optimize Route'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "Today's Deliveries",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _deliveries.length,
            itemBuilder: (context, index) {
              return _buildDeliveryItem(_deliveries[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryItem(DeliveryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: item.color, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForStatus(item.status),
              color: item.color,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.id} - ${item.title}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.address,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.type,
                  style: TextStyle(
                    color: item.color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
      ),
    );
  }

  IconData _getIconForStatus(DeliveryItemStatus status) {
    switch (status) {
      case DeliveryItemStatus.pickup:
        return Icons.warehouse;
      case DeliveryItemStatus.pending:
        return Icons.schedule;
      case DeliveryItemStatus.completed:
        return Icons.check_circle;
      case DeliveryItemStatus.urgent:
        return Icons.priority_high;
    }
  }
}

enum DeliveryItemStatus { pickup, pending, completed, urgent }

class DeliveryItem {
  final String id;
  final String title;
  final String address;
  final String type;
  final DeliveryItemStatus status;
  final Color color;

  DeliveryItem({
    required this.id,
    required this.title,
    required this.address,
    required this.type,
    required this.status,
    required this.color,
  });
}

