import 'package:flutter/material.dart';

class UsernameProfileScreen extends StatefulWidget {
  final String username;
  const UsernameProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<UsernameProfileScreen> createState() => _UsernameProfileScreenState();
}

class _UsernameProfileScreenState extends State<UsernameProfileScreen> {
  bool _isLoading = true;
  bool _isFriendRequestSent = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _toggleFriendRequest() {
    setState(() {
      _isFriendRequestSent = !_isFriendRequestSent;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFriendRequestSent ? 'Friend request sent!' : 'Friend request removed'),
        backgroundColor: _isFriendRequestSent ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
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
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '@nada',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _buildProfileContent(),
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
              _buildAvatar(),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nada Elhegawy',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'nada',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildAddFriendButton(),
          const SizedBox(height: 20),
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
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF6B2FD9), width: 3),
        color: const Color(0xFF6B2FD9),
      ),
      child: const Center(
        child: Text(
          'N',
          style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAddFriendButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _toggleFriendRequest,
        icon: Icon(
          _isFriendRequestSent ? Icons.person_remove : Icons.person_add,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          _isFriendRequestSent ? 'Remove Request' : 'Add Friend',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isFriendRequestSent ? Colors.orange : const Color(0xFF6B2FD9),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 2,
        ),
      ),
    );
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
          _buildInfoRow(Icons.info_outline, 'Bio', 'Passionate Flutter developer building beautiful cross-platform applications. Love creating seamless user experiences with clean code.'),
          const Divider(height: 25),
          _buildInfoRow(Icons.public, 'Nationality', 'Egyptian'),
          const Divider(height: 25),
          _buildInfoRow(Icons.favorite_outline, 'Interest', 'Mobile Development'),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(
                label: Text('#Flutter', style: TextStyle(color: Color(0xFF6B2FD9), fontSize: 13, fontWeight: FontWeight.w500)),
                backgroundColor: Color(0xFFE8DEF8),
                side: BorderSide.none,
              ),
              Chip(
                label: Text('#Dart', style: TextStyle(color: Color(0xFF6B2FD9), fontSize: 13, fontWeight: FontWeight.w500)),
                backgroundColor: Color(0xFFE8DEF8),
                side: BorderSide.none,
              ),
              Chip(
                label: Text('#Firebase', style: TextStyle(color: Color(0xFF6B2FD9), fontSize: 13, fontWeight: FontWeight.w500)),
                backgroundColor: Color(0xFFE8DEF8),
                side: BorderSide.none,
              ),
            ],
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
      children: const [
        Row(
          children: [
            Icon(Icons.link, color: Color(0xFF6B2FD9), size: 20),
            SizedBox(width: 8),
            Text('Portfolio', style: TextStyle(color: Color(0xFF6B2FD9), fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'github.com/nadaelhegawy',
                  style: TextStyle(color: Color(0xFF2196F3), fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.open_in_new, color: Color(0xFF2196F3), size: 18),
            ],
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
              _buildStatCircle('8', 'Hosted', const Color(0xFFF44336)),
              _buildStatCircle('15', 'Joined', const Color(0xFF4CAF50)),
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
          const Text('Recent Projects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          _buildProjectCard('Wusol App', 'Lead Developer', 'Active', const Color(0xFF4CAF50)),
          _buildProjectCard('E-commerce Platform', 'Flutter Developer', 'Completed', const Color(0xFF2196F3)),
          _buildProjectCard('Chat Application', 'Mobile Developer', 'Active', const Color(0xFFF44336)),
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