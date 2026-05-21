import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Delivery {
  final String title;
  final String location;
  final String time;
  final double distance;
  final int duration;
  final bool isPriority;

  Delivery({
    required this.title,
    required this.location,
    required this.time,
    required this.distance,
    required this.duration,
    this.isPriority = false,
  });
}

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _activeBottomNavIndex = 0;

  final List<Delivery> _upcomingDeliveries = [
    Delivery(
        title: 'Electronics Package',
        location: 'Koregaon Park, Pune',
        time: '10:30 AM',
        distance: 2.5,
        duration: 15,
        isPriority: true),
    Delivery(
        title: 'Medical Supplies',
        location: 'Hinjewadi Phase 1, Pune',
        time: '11:15 AM',
        distance: 8.2,
        duration: 35),
    Delivery(
        title: 'Groceries',
        location: 'Viman Nagar, Pune',
        time: '12:00 PM',
        distance: 4.1,
        duration: 20),
    Delivery(
        title: 'Documents',
        location: 'Aundh, Pune',
        time: '01:30 PM',
        distance: 6.5,
        duration: 28),
  ];

  final List<LatLng> _nfcCheckpoints = [
    const LatLng(18.5303, 73.8997),
    const LatLng(18.5413, 73.9073),
    const LatLng(18.5204, 73.8567),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildStatsCards(),
                    const SizedBox(height: 24),
                    _buildRouteOverview(),
                    const SizedBox(height: 24),
                    _buildUpcomingDeliveries(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'GOराही',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00D2FF),
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Good Morning, Delivery Partner! 👋',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Saturday, October 11, 2025',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
            icon: Icons.inventory_2_outlined,
            iconColor: Colors.pink,
            value: '12',
            label: 'Total\nAssigned'),
        _buildStatCard(
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
            value: '7',
            label: 'Completed',
            isActive: true),
        _buildStatCard(
            icon: Icons.hourglass_empty_outlined,
            iconColor: Colors.orange,
            value: '1',
            label: 'Pending'),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    bool isActive = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: Colors.green, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRouteOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.route_outlined, color: Colors.grey[600]),
              const SizedBox(width: 8),
              const Text('Route Overview',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(18.5204, 73.8567),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.gorahi',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: const LatLng(18.5303, 73.8997),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                      Marker(
                        point: const LatLng(18.5413, 73.9073),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                          size: 40,
                        ),
                      ),
                      Marker(
                        point: const LatLng(18.5204, 73.8567),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.yellow,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Tap to view full route with NFC checkpoints',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendItem(color: Colors.green, label: 'Checkpoint A'),
              _LegendItem(color: Colors.orange, label: 'Checkpoint B'),
              _LegendItem(color: Colors.yellow, label: 'Checkpoint C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingDeliveries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_shipping_outlined, color: Colors.grey[600]),
            const SizedBox(width: 8),
            const Text('Upcoming Deliveries', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          itemCount: _upcomingDeliveries.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildDeliveryTile(_upcomingDeliveries[index]);
          },
        ),
      ],
    );
  }

  Widget _buildDeliveryTile(Delivery delivery) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/support');
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: Colors.pink.shade300, width: 4)),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(delivery.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(delivery.location, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text(delivery.time, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${delivery.distance} km  •  ${delivery.duration} min', style: const TextStyle(color: Colors.grey)),
                if (delivery.isPriority)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Priority', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(icon: Icons.home, text: 'Home', index: 0),
            _buildNavItem(icon: Icons.calendar_today, text: 'Schedule', index: 1),
            _buildNavItem(icon: Icons.support_agent, text: 'Support', index: 2),
            _buildNavItem(icon: Icons.people, text: 'Community', index: 3),
            _buildNavItem(icon: Icons.person, text: 'Profile', index: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String text, required int index}) {
    final bool isActive = _activeBottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        if (isActive) return;

        setState(() {
          _activeBottomNavIndex = index;
        });

        switch (index) {
          case 0:
          // Already on home
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/support');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/support-help');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/community');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile'); // FIXED
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF00D2FF) : Colors.grey, size: 24),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              color: isActive ? const Color(0xFF00D2FF) : Colors.grey,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}