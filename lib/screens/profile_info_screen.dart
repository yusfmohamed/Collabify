import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart'; // ⚠️ ADD THIS IMPORT
import '../widgets/custom_button.dart';
import '../widgets/photo_picker.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/dropdown_field.dart';
import '../widgets/interest_input_field.dart';

class ProfileInfoScreen extends StatefulWidget {
  final String username;
  
  const ProfileInfoScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  
  String? _selectedNationality;
  String? _profilePhotoPath;
  
  String? _fullNameError;
  String? _bioError;
  String? _portfolioError;
  String? _nationalityError;
  String? _interestError;
  
  List<String> _hashtags = [];

  @override
  void dispose() {
    _fullNameController.dispose();
    _bioController.dispose();
    _portfolioController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  void _validateAndSubmit() {
    setState(() {
      // Reset errors
      _fullNameError = null;
      _bioError = null;
      _portfolioError = null;
      _nationalityError = null;
      _interestError = null;

      // Validate Full Name
      if (_fullNameController.text.trim().isEmpty) {
        _fullNameError = 'Full name is required';
      }

      // Validate Bio
      if (_bioController.text.trim().isEmpty) {
        _bioError = 'Bio is required';
      } else if (_bioController.text.length > 250) {
        _bioError = 'Bio must be 250 characters or less';
      }

      // Validate Portfolio Link
      if (_portfolioController.text.trim().isEmpty) {
        _portfolioError = 'Portfolio link is required';
      } else if (!_isValidUrl(_portfolioController.text.trim())) {
        _portfolioError = 'Please enter a valid URL';
      }

      // Validate Nationality
      if (_selectedNationality == null) {
        _nationalityError = 'Please select your nationality';
      }

      // Validate Interest
      if (_interestController.text.trim().isEmpty) {
        _interestError = 'Please describe your interest';
      }

      // Validate Hashtags
      if (_hashtags.isEmpty) {
        _interestError = 'Please add at least one hashtag';
      }

      // If no errors, proceed
      if (_fullNameError == null &&
          _bioError == null &&
          _portfolioError == null &&
          _nationalityError == null &&
          _interestError == null) {
        print('Username: ${widget.username}');
        print('Full Name: ${_fullNameController.text}');
        print('Profile Photo: $_profilePhotoPath');
        print('Bio: ${_bioController.text}');
        print('Portfolio: ${_portfolioController.text}');
        print('Nationality: $_selectedNationality');
        print('Interest: ${_interestController.text}');
        print('Hashtags: $_hashtags');
        
        // ✅ FIXED: Navigate to MainNavigation with username
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
          arguments: {'username': widget.username},
        );
      }
    });
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
              AppColors.gradientTop,
              AppColors.gradientMiddle,
              AppColors.gradientBottom,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Complete Your Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PhotoPicker(
                          onPhotoSelected: (path) {
                            setState(() {
                              _profilePhotoPath = path;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        
                        CustomTextField(
                          hintText: 'Full Name',
                          icon: Icons.person_outline,
                          controller: _fullNameController,
                          errorText: _fullNameError,
                        ),
                        const SizedBox(height: 15),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hintText: 'Bio (max 250 characters)',
                              icon: Icons.edit_outlined,
                              controller: _bioController,
                              errorText: _bioError,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                '${_bioController.text.length}/250',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _bioController.text.length > 250
                                      ? Colors.red
                                      : AppColors.textLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        CustomTextField(
                          hintText: 'Portfolio Link',
                          icon: Icons.link,
                          controller: _portfolioController,
                          errorText: _portfolioError,
                        ),
                        const SizedBox(height: 15),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownField(
                              hintText: 'Nationality',
                              icon: Icons.public,
                              selectedValue: _selectedNationality,
                              onChanged: (value) {
                                setState(() {
                                  _selectedNationality = value;
                                  _nationalityError = null;
                                });
                              },
                              hasError: _nationalityError != null,
                            ),
                            if (_nationalityError != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 20, top: 8),
                                child: Text(
                                  _nationalityError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        InterestInputField(
                          interestController: _interestController,
                          hashtags: _hashtags,
                          errorText: _interestError,
                          onHashtagsChanged: (tags) {
                            setState(() {
                              _hashtags = tags;
                              if (tags.isNotEmpty && _interestController.text.isNotEmpty) {
                                _interestError = null;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        
                        CustomButton(
                          text: 'Complete Profile',
                          onPressed: _validateAndSubmit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}