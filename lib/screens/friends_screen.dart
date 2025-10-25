import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Solid white background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color(0xFF6B2FD9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.people,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A148C),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Connect with your collaborators',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}