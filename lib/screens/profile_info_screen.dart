import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../services/profile_service.dart';
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
  bool _isLoading = true;
  int _bioCharCount = 0;

  @override
  void initState() {
    super.initState();
    _loadExistingProfile();
    
    // Add listeners to clear errors on input
    _fullNameController.addListener(_onFullNameChanged);
    _bioController.addListener(_onBioChanged);
    _portfolioController.addListener(_onPortfolioChanged);
    _interestController.addListener(_onInterestChanged);
  }

  void _onFullNameChanged() {
    if (_fullNameError != null && _fullNameController.text.trim().isNotEmpty) {
      setState(() => _fullNameError = null);
    }
  }

  void _onBioChanged() {
    setState(() {
      _bioCharCount = _bioController.text.length;
      if (_bioError != null && _bioController.text.trim().isNotEmpty && _bioController.text.length <= 250) {
        _bioError = null;
      }
    });
  }

  void _onPortfolioChanged() {
    if (_portfolioError != null && _portfolioController.text.trim().isNotEmpty) {
      setState(() => _portfolioError = null);
    }
  }

  void _onInterestChanged() {
    if (_interestError != null && _interestController.text.trim().isNotEmpty && _hashtags.isNotEmpty) {
      setState(() => _interestError = null);
    }
  }

  Future<void> _loadExistingProfile() async {
    try {
      final profile = await ProfileService.getProfile(widget.username);
      
      if (profile != null && mounted) {
        setState(() {
          _fullNameController.text = profile.fullName;
          _bioController.text = profile.bio;
          _bioCharCount = profile.bio.length;
          _portfolioController.text = profile.portfolioLink;
          _interestController.text = profile.interest;
          _selectedNationality = profile.nationality;
          _hashtags = profile.hashtags;
          _profilePhotoPath = profile.profilePhotoPath;
          _isLoading = false;
        });
      } else if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.removeListener(_onFullNameChanged);
    _bioController.removeListener(_onBioChanged);
    _portfolioController.removeListener(_onPortfolioChanged);
    _interestController.removeListener(_onInterestChanged);
    
    _fullNameController.dispose();
    _bioController.dispose();
    _portfolioController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    // More flexible URL validation
    if (url.isEmpty) return false;
    
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) return false;
      
      // Check if it has a scheme (http/https) or add it
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        final testUrl = 'https://$url';
        final testUri = Uri.tryParse(testUrl);
        return testUri != null && testUri.host.isNotEmpty && testUri.host.contains('.');
      }
      
      return uri.hasScheme && uri.host.isNotEmpty && uri.host.contains('.');
    } catch (e) {
      return false;
    }
  }

  Future<void> _validateAndSubmit() async {
    setState(() {
      _fullNameError = null;
      _bioError = null;
      _portfolioError = null;
      _nationalityError = null;
      _interestError = null;

      if (_fullNameController.text.trim().isEmpty) {
        _fullNameError = 'Full name is required';
      }

      if (_bioController.text.trim().isEmpty) {
        _bioError = 'Bio is required';
      } else if (_bioController.text.length > 250) {
        _bioError = 'Bio must be 250 characters or less';
      }

      if (_portfolioController.text.trim().isEmpty) {
        _portfolioError = 'Portfolio link is required';
      } else if (!_isValidUrl(_portfolioController.text.trim())) {
        _portfolioError = 'Please enter a valid URL';
      }

      if (_selectedNationality == null || _selectedNationality!.isEmpty) {
        _nationalityError = 'Please select your nationality';
      }

      if (_interestController.text.trim().isEmpty) {
        _interestError = 'Please describe your interest';
      } else if (_hashtags.isEmpty) {
        _interestError = 'Please add at least one hashtag';
      }
    });

    // Check if there are any errors
    if (_fullNameError == null &&
        _bioError == null &&
        _portfolioError == null &&
        _nationalityError == null &&
        _interestError == null) {
      
      try {
        final profileData = ProfileData(
          username: widget.username,
          fullName: _fullNameController.text.trim(),
          bio: _bioController.text.trim(),
          portfolioLink: _portfolioController.text.trim(),
          nationality: _selectedNationality!,
          interest: _interestController.text.trim(),
          hashtags: _hashtags,
          profilePhotoPath: _profilePhotoPath,
        );

        final success = await ProfileService.saveProfile(profileData);
        
        if (!mounted) return;
        
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Profile saved successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.home,
            arguments: {'username': widget.username},
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save profile. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

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
                          initialImagePath: _profilePhotoPath,
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
                              maxLines: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                '$_bioCharCount/250',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _bioCharCount > 250
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
                          keyboardType: TextInputType.url,
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
                              if (tags.isNotEmpty && _interestController.text.trim().isNotEmpty) {
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