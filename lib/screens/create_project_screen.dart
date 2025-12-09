import 'package:collabify/models/announcement.dart';
import 'package:collabify/screens/join_screen.dart';
import 'package:collabify/services/announcement_service.dart';
import 'package:flutter/material.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();

  String? selectedLanguage;
  String? selectedTeamSize;
  String? selectedPlatform;

  final List<String> languages = [
    'Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Swift', 'Kotlin', 'Go', 'Rust', 'Other',
  ];
  final List<String> teamSizes = ['1', '2','3','4','5', '6-10', '10+'];
  final List<String> platforms = ['Web', 'Mobile', 'Desktop', 'Cross-Platform'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _githubController.dispose();
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Create new project",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Project Title*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _titleController,
                      validator: (value) => value!.isEmpty ? 'Please enter a project title' : null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: 'Enter Project Title',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Project Description*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _descriptionController,
                      validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: 'Describe your project',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "GitHub link*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _githubController,
                      validator: (value) => value!.isEmpty ? 'Please enter a GitHub link' : null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: 'Enter your GitHub link to your project',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Primary Language*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedLanguage,
                      validator: (value) => value == null ? 'Please select a language' : null,
                      hint: const Text('Select a language', style: TextStyle(color: Colors.grey)),
                      items: languages.map((String lang) {
                        return DropdownMenuItem(value: lang, child: Text(lang));
                      }).toList(),
                      onChanged: (value) => setState(() => selectedLanguage = value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Team Size*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedTeamSize,
                      validator: (value) => value == null ? 'Please select a team size' : null,
                      hint: const Text('Select a team size', style: TextStyle(color: Colors.grey)),
                      items: teamSizes.map((String size) {
                        return DropdownMenuItem(value: size, child: Text(size));
                      }).toList(),
                      onChanged: (value) => setState(() => selectedTeamSize = value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Project Platform*",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedPlatform,
                      validator: (value) => value == null ? 'Please select a platform' : null,
                      hint: const Text('Select a platform', style: TextStyle(color: Colors.grey)),
                      items: platforms.map((String plat) {
                        return DropdownMenuItem(value: plat, child: Text(plat));
                      }).toList(),
                      onChanged: (value) => setState(() => selectedPlatform = value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color(0xffF7F3E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                            width: 180,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff8400FF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 80),
                        InkWell(
                          onTap: () {
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
                                const SnackBar(content: Text('Project created and announced!')),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const JoinScreen()),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                            width: 180,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffFF7700),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Create Project",
                                style: TextStyle(color: Colors.white, fontSize: 21),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}