import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  bool _isHostMode = true;
  late AnimationController _animationController;
  final List<bool> _itemsVisible = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animateItems();
  }

  Future<void> _animateItems() async {
    for (int i = 0; i < _itemsVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _itemsVisible[i] = true;
        });
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isHostMode = !_isHostMode;
      // Reset animations
      for (int i = 0; i < _itemsVisible.length; i++) {
        _itemsVisible[i] = false;
      }
      _animationController.reset();
      _animationController.forward();
    });
    _animateItems();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A148C),
              Color(0xFF5E35B1),
              Color(0xFF00BCD4),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),

              // App Name
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Collabify',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Toggle Switch between Host and Join
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!_isHostMode) _toggleMode();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: _isHostMode
                                ? const LinearGradient(
                                    colors: [Color(0xFFFB923C), Color(0xFFF97316)],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.rocket_launch,
                                color: Colors.white,
                                size: _isHostMode ? 24 : 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Host',
                                style: TextStyle(
                                  fontSize: _isHostMode ? 18 : 16,
                                  fontWeight: _isHostMode ? FontWeight.bold : FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_isHostMode) _toggleMode();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: !_isHostMode
                                ? const LinearGradient(
                                    colors: [Color(0xFF6B2FD9), Color(0xFF4A148C)],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.handshake,
                                color: Colors.white,
                                size: !_isHostMode ? 24 : 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Join',
                                style: TextStyle(
                                  fontSize: !_isHostMode ? 18 : 16,
                                  fontWeight: !_isHostMode ? FontWeight.bold : FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Subtitle
                      Text(
                        _isHostMode ? 'Host Your Project 🚀' : 'Join a project 🤝',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isHostMode
                            ? 'Start a project and bring your team together!'
                            : 'Join a team that matches your skills',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Project Cards
                      _buildAnimatedCard(
                        index: 0,
                        icon: Icons.palette,
                        title: _isHostMode
                            ? 'Host Graphic Design\nProject'
                            : 'Join graphic design',
                      ),
                      const SizedBox(height: 16),
                      _buildAnimatedCard(
                        index: 1,
                        icon: Icons.computer,
                        title: _isHostMode
                            ? 'Host Programming\nProject'
                            : 'Join Programming',
                      ),
                      const SizedBox(height: 16),
                      _buildAnimatedCard(
                        index: 2,
                        icon: Icons.videocam,
                        title: _isHostMode
                            ? 'Host Video Editing\nProject'
                            : 'Join video editing',
                      ),
                      const SizedBox(height: 16),
                      _buildAnimatedCard(
                        index: 3,
                        icon: Icons.lightbulb,
                        title: _isHostMode
                            ? 'Host Innovation project'
                            : 'Join innovation',
                      ),
                      const SizedBox(height: 16),
                      _buildAnimatedCard(
                        index: 4,
                        icon: _isHostMode ? Icons.add_circle : Icons.explore,
                        title: _isHostMode
                            ? 'Create New Project'
                            : 'Explore all projects',
                        showIcon: false,
                      ),

                      const SizedBox(height: 30),

                      // Footer text
                      const Center(
                        child: Text(
                          'Every big idea starts with one clicks!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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

  Widget _buildAnimatedCard({
    required int index,
    required IconData icon,
    required String title,
    bool showIcon = true,
  }) {
    final gradient = _isHostMode
        ? const LinearGradient(
            colors: [Color(0xFFFB923C), Color(0xFFF97316)],
          )
        : const LinearGradient(
            colors: [Color(0xFF6B2FD9), Color(0xFF4A148C)],
          );

    return AnimatedOpacity(
      opacity: _itemsVisible[index] ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: AnimatedSlide(
        offset: _itemsVisible[index] ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              if (showIcon)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              if (showIcon) const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  textAlign: showIcon ? TextAlign.left : TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}