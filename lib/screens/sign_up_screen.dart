import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../screens/profile_info_screen.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  String? passwordError;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    setState(() {
      if (passwordController.text.isEmpty || 
          confirmPasswordController.text.isEmpty) {
        passwordError = 'Password fields cannot be empty';
      } else if (passwordController.text != confirmPasswordController.text) {
        passwordError = 'Passwords do not match!';
      } else {
        passwordError = null;
        // Navigate to profile info screen and pass the username
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileInfoScreen(
              username: usernameController.text,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // Logo
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Card
                  Container(
                    padding: const EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Title
                        const Text(
                          'Sign Up',
                          style: AppTextStyles.heading,
                        ),
                        const SizedBox(height: 35),

                        // Username Field
                        CustomTextField(
                          hintText: 'Username',
                          icon: Icons.person,
                          controller: usernameController,
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        CustomTextField(
                          hintText: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),

                        // Confirm Password Field
                        CustomTextField(
                          hintText: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          controller: confirmPasswordController,
                          errorText: passwordError,
                        ),
                        const SizedBox(height: 35),

                        // Sign Up Button
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: _handleSignUp,
                        ),
                        const SizedBox(height: 25),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Sign In',
                                style: AppTextStyles.link,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}