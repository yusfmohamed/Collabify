import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  // Sample data for hosted projects (replace with real data)
  final List<Map<String, dynamic>> _hostedProjects = const [
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
      backgroundColor: Colors.white,  // Blank white background
      appBar: AppBar(
        title: const Text(
          'My Activity',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,  // Transparent for gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A148C), // gradientTop (matching home page)
                Color(0xFF5E35B1), // gradientMiddle
                Color(0xFF00BCD4), // gradientBottom
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFBBF24),  // Accent color from home page
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
          // Host Tab: Your hosted projects and activities
          _buildHostTab(),
          // Join Tab: Projects you've joined, with upload options
          _buildJoinTab(),
        ],
      ),
    );
  }

  Widget _buildHostTab() {
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
              color: Color(0xFF4A148C),  // Matching home page accent
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _hostedProjects.length,
              itemBuilder: (context, index) {
                final project = _hostedProjects[index];
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
              color: Color(0xFF4A148C),  // Matching home page accent
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
            colors: [Colors.white, Colors.grey.shade50],  // Subtle gradient
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
              // Simulate upload (integrate with file picker/API here)
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
}