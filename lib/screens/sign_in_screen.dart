import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    width: 220,
                    height: 220,
                  ),
                  const SizedBox(height: 40),

                  // Sign In Card
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
                          'Sign In',
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
                        const SizedBox(height: 35),

                        // Sign In Button
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            // TODO: Implement actual sign in logic (e.g., API call)
                            // For now, assuming success, navigate to HomePage
                            print('Username: ${usernameController.text}');
                            print('Password: ${passwordController.text}');
                            
                            // ✅ FIXED: Pass username to MainNavigation
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.home,
                              arguments: {'username': usernameController.text},
                            );
                          },
                        ),
                        const SizedBox(height: 25),

                        // Forgot Password
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: AppTextStyles.linkPurple,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Create Account Link
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.signUp);
                          },
                          child: const Text(
                            'Create New Account',
                            style: AppTextStyles.link,
                          ),
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