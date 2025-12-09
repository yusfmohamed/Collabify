import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/profile_service.dart';
import '../config/theme.dart';
import '../config/routes.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileData? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await ProfileService.getProfile(widget.username);
    setState(() {
      _profileData = profile;
      _isLoading = false;
    });
  }

  Future<void> _launchURL(String url) async {
    String finalUrl = url.startsWith('http') ? url : 'https://$url';
    final Uri uri = Uri.parse(finalUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Could not open $url', Colors.red);
      }
    } catch (e) {
      _showSnackBar('Error opening link: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
    }
  }

  void _showDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
    Color titleColor = const Color(0xFFFBBF24),
    IconData? icon,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D1B69),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: titleColor, size: 28),
              const SizedBox(width: 10),
            ],
            Text(title, style: TextStyle(color: titleColor, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(content, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signIn, (route) => false);
    _showSnackBar('Logged out successfully', Colors.green);
  }

  Future<void> _deleteProfile() async {
    final success = await ProfileService.deleteProfile(widget.username);
    if (mounted) {
      _showSnackBar(
        success ? 'Profile deleted successfully' : 'Failed to delete profile',
        success ? Colors.green : Colors.red,
      );
      if (success) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.signIn, (route) => false);
      }
    }
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF6B2FD9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Settings',
                style: TextStyle(color: Color(0xFFFBBF24), fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.orange),
                title: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _showDialog(title: 'Logout', content: 'Are you sure you want to logout?', onConfirm: _logout);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Delete Profile', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _showDialog(
                    title: 'Delete Profile',
                    content: 'Are you sure you want to delete your profile? This action cannot be undone.',
                    onConfirm: _deleteProfile,
                    titleColor: Colors.red,
                    icon: Icons.warning_amber_rounded,
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B2FD9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B2FD9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white, size: 28),
          onPressed: _showOptionsMenu,
        ),
        title: const Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _profileData == null
              ? _buildEmptyProfile()
              : _buildProfileContent(),
    );
  }

  Widget _buildEmptyProfile() {
    return Container(
      color: const Color(0xFFF5F5DC),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6B2FD9), width: 3),
                color: const Color(0xFF6B2FD9),
              ),
              child: const Center(
                child: Text('Y', style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.username, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 10),
            const Text('No profile data found', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/profile-info', arguments: {'username': widget.username})
                      .then((_) => _loadProfile()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD68A3B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Container(
      color: const Color(0xFFF5F5DC),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile-info', arguments: {'username': widget.username})
                    .then((_) => _loadProfile()),
                child: _buildAvatar(),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _profileData!.fullName,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.username,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/profile-info', arguments: {'username': widget.username})
                  .then((_) => _loadProfile()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD68A3B),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 2,
              ),
              child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 25),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildActivitySection(),
          const SizedBox(height: 20),
          _buildProjectsSection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final content = _profileData!.profilePhotoPath != null && _profileData!.profilePhotoPath!.isNotEmpty
        ? CircleAvatar(
            radius: 70,
            backgroundImage: FileImage(File(_profileData!.profilePhotoPath!)),
          )
        : Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6B2FD9),
            ),
            child: Center(
              child: Text(
                _profileData!.fullName.isNotEmpty ? _profileData!.fullName[0].toUpperCase() : 'Y',
                style: const TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF6B2FD9), width: 3),
      ),
      child: content,
    );
  }

  Widget _buildBadgesSection() {
    return const SizedBox.shrink(); // Hidden - not needed
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.info_outline, 'Bio', _profileData!.bio),
          const Divider(height: 25),
          _buildInfoRow(Icons.public, 'Nationality', _profileData!.nationality),
          const Divider(height: 25),
          _buildInfoRow(Icons.favorite_outline, 'Interest', _profileData!.interest),
          const SizedBox(height: 15),
                      Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _profileData!.hashtags.map((tag) {
              // Remove '#' if it already exists in the tag
              final cleanTag = tag.startsWith('#') ? tag.substring(1) : tag;
              return Chip(
                label: Text('#$cleanTag', style: const TextStyle(color: Color(0xFF6B2FD9), fontSize: 13, fontWeight: FontWeight.w500)),
                backgroundColor: const Color(0xFFE8DEF8),
                side: BorderSide.none,
              );
            }).toList(),
          ),
          const Divider(height: 25),
          _buildPortfolioLink(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF6B2FD9), size: 20),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: Color(0xFF6B2FD9), fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(color: Colors.black87, fontSize: 15, height: 1.5)),
      ],
    );
  }

  Widget _buildPortfolioLink() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.link, color: Color(0xFF6B2FD9), size: 20),
            SizedBox(width: 8),
            Text('Portfolio', style: TextStyle(color: Color(0xFF6B2FD9), fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _launchURL(_profileData!.portfolioLink),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2196F3).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _profileData!.portfolioLink,
                    style: const TextStyle(color: Color(0xFF2196F3), fontSize: 15, decoration: TextDecoration.underline),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.open_in_new, color: Color(0xFF2196F3), size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCircle('5', 'Hosted', const Color(0xFFF44336)),
              _buildStatCircle('12', 'Joined', const Color(0xFF4CAF50)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCircle(String count, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: Text(count, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Project History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          _buildProjectCard('Mobile App Development', 'Developer', 'Completed', const Color(0xFF4CAF50)),
          _buildProjectCard('Website Redesign', 'UI Designer', 'Active', const Color(0xFFF44336)),
          _buildProjectCard('AI Chatbot', 'Developer', 'Active', const Color(0xFF2196F3)),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String role, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.folder, color: statusColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('$role • $status', style: const TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black38, size: 16),
        ],
      ),
    );
  }
}