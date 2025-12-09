import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A148C),
              Color(0xFF6B2FD9),
              Color(0xFF00BCD4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'About Collabify',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // App Logo/Icon
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // App Name
                      const Text(
                        'Collabify',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
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

                      const SizedBox(height: 8),

                      // Version
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A148C),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Main Description Card
                      _buildInfoCard(
                        icon: Icons.info_outline,
                        title: 'What is Collabify?',
                        description:
                            'Collabify is a collaborative platform designed to connect talented creators and bring innovative ideas to life. Whether you\'re a designer, developer, video editor, or innovator, Collabify helps you find the perfect team to work with.',
                      ),

                      const SizedBox(height: 20),

                      // Features Card
                      _buildInfoCard(
                        icon: Icons.star,
                        title: 'Key Features',
                        description: '',
                        child: Column(
                          children: [
                            _buildFeatureRow(
                              Icons.rocket_launch,
                              'Host Projects',
                              'Create and manage your own projects',
                            ),
                            const SizedBox(height: 12),
                            _buildFeatureRow(
                              Icons.handshake,
                              'Join Teams',
                              'Find projects that match your skills',
                            ),
                            const SizedBox(height: 12),
                            _buildFeatureRow(
                              Icons.chat_bubble,
                              'Real-time Chat',
                              'Communicate with your team instantly',
                            ),
                            const SizedBox(height: 12),
                            _buildFeatureRow(
                              Icons.people,
                              'Build Network',
                              'Connect with talented collaborators',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Mission Card
                      _buildInfoCard(
                        icon: Icons.track_changes,
                        title: 'Our Mission',
                        description:
                            'To empower creators worldwide by providing a seamless platform for collaboration, innovation, and turning great ideas into reality through teamwork.',
                      ),

                      const SizedBox(height: 20),

                      // Categories Card
                      _buildInfoCard(
                        icon: Icons.category,
                        title: 'Project Categories',
                        description: '',
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildCategoryChip(Icons.palette, 'Graphic Design'),
                            _buildCategoryChip(Icons.computer, 'Programming'),
                            _buildCategoryChip(Icons.videocam, 'Video Editing'),
                            _buildCategoryChip(Icons.lightbulb, 'Innovation'),
                            _buildCategoryChip(Icons.music_note, 'Music'),
                            _buildCategoryChip(Icons.draw, 'Animation'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Contact Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Get in Touch',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildContactRow(Icons.email, 'support@collabify.com'),
                            const SizedBox(height: 10),
                            _buildContactRow(Icons.language, 'www.collabify.com'),
                            const SizedBox(height: 10),
                            _buildContactRow(Icons.location_on, 'Global Platform'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Footer
                      Center(
                        child: Text(
                          '© 2025 Collabify. All rights reserved.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    Widget? child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF4A148C),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ],
          if (child != null) ...[
            const SizedBox(height: 16),
            child,
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFBBF24),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFFFBBF24),
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFFBBF24),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }
}