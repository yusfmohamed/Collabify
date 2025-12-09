import 'package:collabify/services/announcement_service.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample notifications
  final List<Map<String, dynamic>> _notifications = [
    {
      'message': 'John wants to join your project "Mobile App Development"',
      'time': '2 hours ago',
      'userName': 'John',
      'projectName': 'Mobile App Development',
    },
    {
      'message': 'Sarah wants to join your project "Web Design Project"',
      'time': '5 hours ago',
      'userName': 'Sarah',
      'projectName': 'Web Design Project',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Original hosted projects data
  final List<Map<String, dynamic>> _originalHostedProjects = const [
    {
      'title': 'Mobile App Development',
      'status': 'Active',
      'collaborators': 5,
      'progress': 75,
      'description': 'Building a collaborative task manager app.',
      'activities': [
        'John joined as a developer (2 days ago)',
        'Milestone: UI design completed (1 week ago)',
        'Update: Backend integration started (3 days ago)',
      ],
    },
    {
      'title': 'Web Design Project',
      'status': 'Completed',
      'collaborators': 3,
      'progress': 100,
      'description': 'Designing a responsive website for a startup.',
      'activities': [
        'Project completed successfully (1 month ago)',
        'Final review and feedback posted (1 month ago)',
      ],
    },
  ];

  // Sample data for joined projects (replace with real data)
  final List<Map<String, dynamic>> _joinedProjects = const [
    {
      'title': 'AI Research Initiative',
      'host': 'Alice',
      'status': 'Active',
      'progress': 50,
      'description': 'Exploring machine learning for data analysis.',
      'myContributions': ['Uploaded dataset file (1 week ago)', 'Posted update on model training (3 days ago)'],
    },
    {
      'title': 'Game Development',
      'host': 'Bob',
      'status': 'Pending',
      'progress': 20,
      'description': 'Creating an indie game with Flutter.',
      'myContributions': ['Uploaded game assets (5 days ago)'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Activity',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
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
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, size: 32),
                  onPressed: () => _showNotifications(context),
                ),
                if (_notifications.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '${_notifications.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFBBF24),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Host', icon: Icon(Icons.rocket_launch)),
            Tab(text: 'Join', icon: Icon(Icons.handshake)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHostTab(),
          _buildJoinTab(),
        ],
      ),
    );
  }

  Widget _buildHostTab() {
    // Combine original projects with new projects from announcements
    final newProjects = announcements.map((announcement) {
      return {
        'title': announcement.projectName,
        'status': 'Active',
        'collaborators': 0,
        'progress': 0,
        'description': announcement.description,
        'activities': [
          'Project created (Just now)',
          'Looking for ${announcement.teamNum} team members',
          'Tech Stack: ${announcement.language}',
        ],
      };
    }).toList();

    final allHostedProjects = [..._originalHostedProjects, ...newProjects];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Hosted Projects & Activities',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: allHostedProjects.length,
              itemBuilder: (context, index) {
                final project = allHostedProjects[index];
                return _buildProjectCard(
                  project,
                  isHost: true,
                  activities: project['activities'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects You\'ve Joined & Contributions',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _joinedProjects.length,
              itemBuilder: (context, index) {
                final project = _joinedProjects[index];
                return _buildProjectCard(
                  project,
                  isHost: false,
                  contributions: project['myContributions'],
                  onUpload: () => _showUploadDialog(context, project['title']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    Map<String, dynamic> project, {
    required bool isHost,
    List<String>? activities,
    List<String>? contributions,
    VoidCallback? onUpload,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade50],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A148C).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isHost ? Icons.rocket_launch : Icons.handshake,
                    color: const Color(0xFF4A148C),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Status: ${project['status']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: project['status'] == 'Active'
                              ? Colors.green
                              : project['status'] == 'Completed'
                                  ? Colors.blue
                                  : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isHost) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Collaborators: ${project['collaborators']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 4),
                        Text(
                          'Host: ${project['host']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project['description'],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            if (isHost) ...[
              const Text(
                'Recent Activities:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(height: 8),
              ...activities!.map((activity) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $activity',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  )),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: project['progress'] / 100,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A148C)),
              ),
            ] else ...[
              const Text(
                'Your Contributions:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(height: 8),
              ...contributions!.map((contribution) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $contribution',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  )),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: onUpload,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File/Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A148C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showUploadDialog(BuildContext context, String projectTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload to $projectTitle'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Enter update or file description...',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Update uploaded successfully!')),
              );
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A148C),
            ),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _notifications.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No new notifications',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4A148C).withOpacity(0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person_add,
                                        color: Color(0xFF4A148C),
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${notification['userName']} wants to join',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4A148C),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Project: ${notification['projectName']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            notification['time'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, size: 24),
                                      onPressed: () {
                                        setState(() {
                                          _notifications.removeAt(index);
                                        });
                                        Navigator.of(context).pop();
                                        if (_notifications.isNotEmpty) {
                                          _showNotifications(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _notifications.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Request declined'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                        if (_notifications.isNotEmpty) {
                                          _showNotifications(context);
                                        }
                                      },
                                      icon: const Icon(Icons.close, color: Colors.red),
                                      label: const Text(
                                        'Decline',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _notifications.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${notification['userName']} accepted to project!',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                        if (_notifications.isNotEmpty) {
                                          _showNotifications(context);
                                        }
                                      },
                                      icon: const Icon(Icons.check),
                                      label: const Text(
                                        'Accept',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}