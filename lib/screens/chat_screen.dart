import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 80.0), // Space for nav bar
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Message your team members',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
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