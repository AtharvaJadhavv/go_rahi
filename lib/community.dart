import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _activeBottomNavIndex = 3; // Community active

  final List<CommunityPost> _posts = [
    CommunityPost(
      username: 'rajesh_kumar_delivery',
      timeAgo: '2 hours ago',
      achievement: 'Speed Demon',
      description: 'Certificate of Achievement',
      details: '50 deliveries completed\nAvg time: 18 minutes',
      likes: 24,
      comments: [
        'priya_singh_courier: Congratulations! 🎉 Well deserved!',
        'manish_express: You’re an inspiration! 💪'
      ],
      caption:
      '🎉 Just earned my Speed Demon badge! Completed 50 deliveries this week with an average time of 18 minutes. Feeling proud to serve our community efficiently! 📦 #SpeedDemon #DeliveryHero #Achievement',
      avatarColor: Colors.green,
    ),
    CommunityPost(
      username: 'neha_patil_rider',
      timeAgo: '5 hours ago',
      achievement: 'Top Performer',
      description: 'Star Performer of the Month',
      details: '120 successful deliveries\nCustomer rating: 4.9⭐',
      likes: 45,
      comments: [
        'sunil_driver: You inspire us all 👏🔥',
        'aarti_deshmukh: Well done Neha! 🌟'
      ],
      caption:
      '✨ Feeling proud to be recognized as the Top Performer this month! Hard work always pays off 💪 #TopPerformer #CourierPride',
      avatarColor: Colors.purple,
    ),
  ];

  final Set<int> _likedPosts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildShareAchievementCard(),
                        const SizedBox(height: 16),
                        ..._posts.asMap().entries.map(
                              (entry) => _buildPostCard(entry.key, entry.value),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.people, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Courier Community',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 24,
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildShareAchievementCard() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.celebration, color: Colors.yellow, size: 26),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '🎉 Your achievement has been shared successfully!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.blueAccent,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.emoji_events, color: Colors.white, size: 36),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Share Your Achievement',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.blue, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(int index, CommunityPost post) {
    bool isLiked = _likedPosts.contains(index);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: post.avatarColor,
                  radius: 24,
                  child: Text(
                    post.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(post.timeAgo,
                          style:
                          const TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Certificate section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.yellow.shade700, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.emoji_events,
                    color: Colors.orange, size: 40),
                const SizedBox(height: 16),
                Text(post.achievement,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 8),
                Text(post.description,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 12),
                Text(post.details,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.shade700)),
              ],
            ),
          ),

          // Reaction buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Text(isLiked ? '❤️' : '🤍',
                          style: const TextStyle(fontSize: 24)),
                      onPressed: () {
                        setState(() {
                          if (isLiked) {
                            _likedPosts.remove(index);
                            post.likes--;
                          } else {
                            _likedPosts.add(index);
                            post.likes++;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Text('💬', style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        _openCommentsModal(post);
                      },
                    ),
                    IconButton(
                      icon: const Text('👍', style: TextStyle(fontSize: 24)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You appreciated this post! 👍'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Text('📌', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Post pinned successfully 📌'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Likes count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${post.likes} likes',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          const SizedBox(height: 8),
          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                      text: '${post.username} ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: post.caption),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          // Comments preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'View all ${post.comments.length} comments',
              style:
              TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: post.comments.first.split(':')[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${post.comments.first.split(':')[1]}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // COMMENT MODAL
  void _openCommentsModal(CommunityPost post) {
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Comments',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) {
                        final comment = post.comments[index];
                        final parts = comment.split(':');
                        return ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              children: [
                                TextSpan(
                                    text: '${parts[0]}: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: parts[1]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          final newComment =
                              'you: ${commentController.text.trim()}';
                          if (commentController.text.isNotEmpty) {
                            setState(() {
                              post.comments.add(newComment);
                            });
                            setModalState(() {});
                            commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        );
      },
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
        setState(() => _activeBottomNavIndex = index);

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/homepage');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/support');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/support-help');
            break;
          case 3:
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;

        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: isActive ? const Color(0xFF00D2FF) : Colors.grey, size: 24),
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

class CommunityPost {
  String username;
  String timeAgo;
  String achievement;
  String description;
  String details;
  int likes;
  List<String> comments;
  String caption;
  Color avatarColor;

  CommunityPost({
    required this.username,
    required this.timeAgo,
    required this.achievement,
    required this.description,
    required this.details,
    required this.likes,
    required this.comments,
    required this.caption,
    required this.avatarColor,
  });
}
