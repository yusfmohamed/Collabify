import 'package:collabify/icons/activity_screen.dart';
import 'package:collabify/models/announcement.dart';
import 'package:collabify/screens/join_screen.dart';
import 'package:collabify/services/announcement_service.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();

  String? selectedLanguage;
  String? selectedTeamSize;
  String? selectedPlatform;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> languages = [
    'Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Swift', 'Kotlin', 'Go', 'Rust', 'Other',
  ];
  final List<String> teamSizes = ['1', '2', '3', '4', '5', '6-10', '10+'];
  final List<String> platforms = ['Web', 'Mobile', 'Desktop', 'Cross-Platform'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _githubController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4B0082),
            Color(0xFF5E35B1),
            Color(0xFF009688),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Fixed Top Bar - Doesn't scroll
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Go Back Button
                    _buildTopButton(
                      label: "Go Back",
                      gradientColors: const [Color(0xFFFB923C), Color(0xFFF97316)],
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Go to Activities Button
                    _buildTopButton(
                      label: "Go To Activities",
                      color: const Color(0xff8400FF),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Main Content - Scrollable
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Create New Project",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                _buildInputField(
                                  label: "Project Title*",
                                  controller: _titleController,
                                  hint: 'Enter Project Title',
                                  validator: (value) => value!.isEmpty ? 'Please enter a project title' : null,
                                ),
                                const SizedBox(height: 15),
                                _buildInputField(
                                  label: "Project Description*",
                                  controller: _descriptionController,
                                  hint: 'Describe your project',
                                  maxLines: 4,
                                  validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                                ),
                                const SizedBox(height: 15),
                                _buildInputField(
                                  label: "GitHub Link*",
                                  controller: _githubController,
                                  hint: 'Enter your GitHub link to your project',
                                  validator: (value) => value!.isEmpty ? 'Please enter a GitHub link' : null,
                                ),
                                const SizedBox(height: 15),
                                _buildDropdownField(
                                  label: "Primary Language*",
                                  value: selectedLanguage,
                                  hint: 'Select a language',
                                  items: languages,
                                  onChanged: (value) => setState(() => selectedLanguage = value),
                                ),
                                const SizedBox(height: 15),
                                _buildDropdownField(
                                  label: "Team Size*",
                                  value: selectedTeamSize,
                                  hint: 'Select a team size',
                                  items: teamSizes,
                                  onChanged: (value) => setState(() => selectedTeamSize = value),
                                ),
                                const SizedBox(height: 15),
                                _buildDropdownField(
                                  label: "Project Platform*",
                                  value: selectedPlatform,
                                  hint: 'Select a platform',
                                  items: platforms,
                                  onChanged: (value) => setState(() => selectedPlatform = value),
                                ),
                                const SizedBox(height: 40),
                                _buildActionButton(
                                  label: "Create Project",
                                  color: const Color(0xffFF7700),
                                  onTap: _createProject,
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: TextFormField(
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: hint,
              filled: true,
              fillColor: Colors.white.withOpacity(0.95),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xffFF7700), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          validator: (val) => val == null ? 'Please select an option' : null,
          hint: Text(hint, style: TextStyle(color: Colors.grey[400])),
          items: items.map((String item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            filled: true,
            fillColor: Colors.white.withOpacity(0.95),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xffFF7700), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          dropdownColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton({
    required String label,
    Color? color,
    List<Color>? gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: gradientColors != null
                ? LinearGradient(colors: gradientColors)
                : null,
            color: gradientColors == null ? color : null,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _createProject() {
    if (_formKey.currentState!.validate()) {
      final newAnnouncement = Announcement(
        userName: 'Current User',
        projectName: _titleController.text,
        description: _descriptionController.text,
        language: selectedLanguage!,
        teamNum: selectedTeamSize!,
        projectType: selectedPlatform!,
      );
      announcements.add(newAnnouncement);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Project created and announced!'),
          backgroundColor: const Color(0xffFF7700),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Navigate to both ActivityScreen and then JoinScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ActivityScreen()),
      ).then((_) {
        // After ActivityScreen is shown, navigate to JoinScreen
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JoinScreen()),
            );
          }
        });
      });
    }
  }
}