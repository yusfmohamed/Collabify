import 'package:collabify/screens/join_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A148C), // gradientTop
              Color(0xFF5E35B1), // gradientMiddle
              Color(0xFF00BCD4), // gradientBottom
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with icons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side - Settings and Tasks
                    Row(
                      children: [
                        _buildTopIcon(Icons.settings, Colors.white, () {
                          // Navigate to settings
                        }),
                        const SizedBox(width: 12),
                        _buildTopIcon(Icons.assignment, Colors.white, () {
                          // Navigate to tasks
                        }),
                      ],
                    ),
                    // Right side - Notifications icon
                    _buildTopIcon(Icons.notifications, Colors.white, () {
                      // Navigate to notifications
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Welcome message with username
              Text(
                'Hello ${widget.username}',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Choose Role text
              const Text(
                'Choose Role',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFBBF24),
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Host button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildRoleButton(
                  icon: Icons.rocket_launch,
                  title: 'Host',
                  subtitle: 'Post your project and find collaborators',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFB923C), Color(0xFFF97316)],
                  ),
                  onTap: () {
                    // Navigate to post project screen
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Join button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildRoleButton(
                  icon: Icons.handshake,
                  title: 'Join',
                  subtitle: 'Join projects based on your skills',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A148C), Color(0xFF6B2FD9)],
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return JoinScreen();
                    }));
                    // Navigate to join project screen
                  },
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
