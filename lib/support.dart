import 'package:flutter/material.dart';

enum DeliveryStatus { Pending, InProgress, Completed }

class DeliveryTask {
  final String location;
  final String subLocation;
  final String time;
  final double distance;
  final int packages;
  final DeliveryStatus status;

  DeliveryTask({
    required this.location,
    required this.subLocation,
    required this.time,
    required this.distance,
    required this.packages,
    required this.status,
  });
}

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _activeTabIndex = 0;
  int _activeBottomNavIndex = 1;

  final List<DeliveryTask> _todayDeliveries = [
    DeliveryTask(
        location: 'Tech Park Plaza',
        subLocation: 'Sector 18',
        time: '09:30 AM',
        distance: 2.5,
        packages: 3,
        status: DeliveryStatus.Pending),
    DeliveryTask(
        location: 'Cyber Hub Mall',
        subLocation: 'DLF Cyber City',
        time: '11:15 AM',
        distance: 4.2,
        packages: 2,
        status: DeliveryStatus.InProgress),
    DeliveryTask(
        location: 'Office Building',
        subLocation: 'Udyog Vihar',
        time: '04:30 PM',
        distance: 5.1,
        packages: 1,
        status: DeliveryStatus.Completed),
  ];

  final List<DeliveryTask> _weekDeliveries = [
    DeliveryTask(
        location: 'Corporate Tower',
        subLocation: 'Gurgaon Sector 32',
        time: 'Mon 10:00 AM',
        distance: 12.3,
        packages: 5,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Residential Complex',
        subLocation: 'South City 1',
        time: 'Tue 02:30 PM',
        distance: 8.7,
        packages: 4,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Shopping Mall',
        subLocation: 'MG Road',
        time: 'Wed 11:00 AM',
        distance: 6.2,
        packages: 3,
        status: DeliveryStatus.InProgress),
    DeliveryTask(
        location: 'Hospital',
        subLocation: 'Sector 14',
        time: 'Thu 09:15 AM',
        distance: 4.5,
        packages: 2,
        status: DeliveryStatus.Pending),
    DeliveryTask(
        location: 'University Campus',
        subLocation: 'DLF Phase 3',
        time: 'Fri 03:00 PM',
        distance: 10.1,
        packages: 6,
        status: DeliveryStatus.Pending),
    DeliveryTask(
        location: 'IT Park',
        subLocation: 'Cyber City Phase 2',
        time: 'Sat 10:30 AM',
        distance: 7.8,
        packages: 4,
        status: DeliveryStatus.Pending),
  ];

  final List<DeliveryTask> _monthDeliveries = [
    DeliveryTask(
        location: 'Business Hub',
        subLocation: 'Udyog Vihar Phase 5',
        time: 'Oct 1 - 09:00 AM',
        distance: 15.2,
        packages: 8,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Tech Valley',
        subLocation: 'Sector 18',
        time: 'Oct 3 - 11:30 AM',
        distance: 9.5,
        packages: 5,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Medical Center',
        subLocation: 'Golf Course Road',
        time: 'Oct 5 - 02:00 PM',
        distance: 11.3,
        packages: 3,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Luxury Apartments',
        subLocation: 'Sohna Road',
        time: 'Oct 7 - 10:15 AM',
        distance: 13.7,
        packages: 7,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Corporate Plaza',
        subLocation: 'MG Road Metro',
        time: 'Oct 9 - 04:30 PM',
        distance: 6.8,
        packages: 4,
        status: DeliveryStatus.Completed),
    DeliveryTask(
        location: 'Shopping District',
        subLocation: 'Sector 29',
        time: 'Oct 10 - 01:00 PM',
        distance: 8.2,
        packages: 6,
        status: DeliveryStatus.InProgress),
    DeliveryTask(
        location: 'Tech Park Plaza',
        subLocation: 'Sector 18',
        time: 'Oct 11 - 09:30 AM',
        distance: 2.5,
        packages: 3,
        status: DeliveryStatus.Pending),
    DeliveryTask(
        location: 'Cyber Hub Mall',
        subLocation: 'DLF Cyber City',
        time: 'Oct 11 - 11:15 AM',
        distance: 4.2,
        packages: 2,
        status: DeliveryStatus.InProgress),
    DeliveryTask(
        location: 'Office Building',
        subLocation: 'Udyog Vihar',
        time: 'Oct 11 - 04:30 PM',
        distance: 5.1,
        packages: 1,
        status: DeliveryStatus.Pending),
  ];

  List<DeliveryTask> get _currentDeliveries {
    switch (_activeTabIndex) {
      case 0:
        return _todayDeliveries;
      case 1:
        return _weekDeliveries;
      case 2:
        return _monthDeliveries;
      default:
        return _todayDeliveries;
    }
  }

  Map<String, int> get _currentStats {
    final deliveries = _currentDeliveries;
    final total = deliveries.length;
    final completed = deliveries.where((d) => d.status == DeliveryStatus.Completed).length;
    final pending = deliveries.where((d) => d.status == DeliveryStatus.Pending).length;

    return {
      'total': total,
      'completed': completed,
      'pending': pending,
    };
  }

  String get _deliveryTitle {
    switch (_activeTabIndex) {
      case 0:
        return "Today's Deliveries";
      case 1:
        return "This Week's Deliveries";
      case 2:
        return "This Month's Deliveries";
      default:
        return "Deliveries";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStats(),
                        const SizedBox(height: 24),
                        _buildDeliveriesList(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF3A57E8),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GOराही',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Delivery Schedule',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildTabs(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem(text: 'Today', index: 0),
          _buildTabItem(text: 'This Week', index: 1),
          _buildTabItem(text: 'This Month', index: 2),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String text, required int index}) {
    final bool isActive = _activeTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 2) {
            Navigator.pushNamed(context, '/deliver');
          } else {
            setState(() => _activeTabIndex = index);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? const Color(0xFF3A57E8) : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    final stats = _currentStats;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(value: '${stats['total']}', label: 'Total Tasks'),
        _buildStatCard(value: '${stats['completed']}', label: 'Completed'),
        _buildStatCard(value: '${stats['pending']}', label: 'Pending'),
      ],
    );
  }

  Widget _buildStatCard({required String value, required String label}) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Text(value,
              style:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDeliveriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _deliveryTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          itemCount: _currentDeliveries.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildDeliveryTaskTile(_currentDeliveries[index]);
          },
        ),
      ],
    );
  }

  Widget _buildDeliveryTaskTile(DeliveryTask task) {
    Color statusColor;
    String statusText;

    switch (task.status) {
      case DeliveryStatus.Pending:
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      case DeliveryStatus.InProgress:
        statusColor = Colors.blue;
        statusText = 'In progress';
        break;
      case DeliveryStatus.Completed:
        statusColor = Colors.green;
        statusText = 'Completed';
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/route-details',
          arguments: {
            'location': task.location,
            'subLocation': task.subLocation,
          },
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.location,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(task.subLocation,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A57E8).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.map_outlined, color: Color(0xFF3A57E8)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                Text(task.time,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${task.distance} km   •   ${task.packages} pkg',
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
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
        setState(() {
          _activeBottomNavIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/homepage');
            break;
          case 1:
          // Already on schedule
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/support-help');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/community');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;

        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF3A57E8) : Colors.grey, size: 24),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              color: isActive ? const Color(0xFF3A57E8) : Colors.grey,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}