import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final String username;
  
  const OnboardingScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Collabify! 🎉',
      description: 'Connect with talented individuals and bring your creative projects to life together',
      icon: Icons.groups,
      gradient: const LinearGradient(
        colors: [Color(0xFF6B2FD9), Color(0xFF4A148C)],
      ),
    ),
    OnboardingPage(
      title: 'Host Your Projects 🚀',
      description: 'Start your own projects and gather a team of skilled collaborators to make your vision a reality',
      icon: Icons.rocket_launch,
      items: [
        OnboardingItem(text: 'Graphic Design', icon: Icons.palette),
        OnboardingItem(text: 'Programming', icon: Icons.computer),
        OnboardingItem(text: 'Video Editing', icon: Icons.videocam),
        OnboardingItem(text: 'Innovation Projects', icon: Icons.lightbulb),
      ],
      gradient: const LinearGradient(
        colors: [Color(0xFFFB923C), Color(0xFFF97316)],
      ),
    ),
    OnboardingPage(
      title: 'Join Amazing Teams 🤝',
      description: 'Discover projects that match your skills and interests. Collaborate with passionate creators',
      icon: Icons.handshake,
      items: [
        OnboardingItem(text: 'Find projects you love', icon: Icons.search),
        OnboardingItem(text: 'Contribute your talents', icon: Icons.star),
        OnboardingItem(text: 'Build your portfolio', icon: Icons.work),
        OnboardingItem(text: 'Grow your network', icon: Icons.people),
      ],
      gradient: const LinearGradient(
        colors: [Color(0xFF6B2FD9), Color(0xFF4A148C)],
      ),
    ),
    OnboardingPage(
      title: 'Let\'s Get Started! ✨',
      description: 'Complete your profile and start your collaboration journey today',
      icon: Icons.celebration,
      gradient: const LinearGradient(
        colors: [Color(0xFFFB923C), Color(0xFFF97316)],
      ),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToProfile();
    }
  }

  void _skipToProfile() {
    _navigateToProfile();
  }

  void _navigateToProfile() {
    Navigator.pushReplacementNamed(
      context,
      '/profile-info',
      arguments: {'username': widget.username},
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use AboutScreen gradient colors
    Gradient backgroundGradient;
    if (_currentPage == 1) {
      // Host page - Orange gradient background (from AboutScreen)
      backgroundGradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4A148C),
          Color(0xFF5E35B1),
          Color(0xFF00BCD4),
        ],
        stops: [0.0, 0.5, 1.0],
      );
    } else if (_currentPage == 2) {
      // Join page - Purple gradient background (from AboutScreen)
      backgroundGradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4A148C),
          Color(0xFF5E35B1),
          Color(0xFF00BCD4),
        ],
        stops: [0.0, 0.5, 1.0],
      );
    } else {
      // Default gradient for Welcome and Get Started pages (from AboutScreen)
      backgroundGradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4A148C),
          Color(0xFF5E35B1),
          Color(0xFF00BCD4),
        ],
        stops: [0.0, 0.5, 1.0],
      );
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _skipToProfile,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPageContent(_pages[index]);
                  },
                ),
              ),

              // Page Indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
              ),

              // Bottom Navigation
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button (hidden on first page)
                    SizedBox(
                      width: 60,
                      child: _currentPage > 0
                          ? IconButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 28,
                              ),
                            )
                          : const SizedBox(),
                    ),

                    // Next/Get Started Button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4A148C),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentPage == _pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Placeholder for symmetry
                    const SizedBox(width: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Icon
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: page.gradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              page.icon,
              size: 80,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 50),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 20),

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 40),

          // Items (if any)
          if (page.items != null && page.items!.isNotEmpty)
            ...page.items!.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildFeatureItem(entry.value, entry.key, page.gradient),
              );
            }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(OnboardingItem item, int index, Gradient gradient) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500 + (index * 100)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
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
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.text,
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
      },
    );
  }

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: _currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.white
            : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final List<OnboardingItem>? items;
  final Gradient gradient;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    this.items,
    required this.gradient,
  });
}

class OnboardingItem {
  final String text;
  final IconData icon;

  OnboardingItem({
    required this.text,
    required this.icon,
  });
}