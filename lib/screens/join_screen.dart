import 'dart:ui';
import 'package:collabify/components/announcement_item.dart';
import 'package:collabify/models/announcement.dart';
import 'package:collabify/screens/announcement_detail_screen.dart';
import 'package:collabify/services/announcement_service.dart';  // Import the global list
import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4A148C), // gradientTop
            Color(0xFF5E35B1), // gradientMiddle
            Color(0xFF00BCD4), // gradientBottom
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 88,
          title: const Row(
            children: [
              Text(
                "Available Projects",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.announcement_rounded,
                color: Colors.white,
              ),
            ],
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A148C), Color(0xFF6B2FD9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: announcements.length,  // Use global list
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnnouncementDetailScreen(
                      announcement: announcements[index],  // Use global list
                    ),
                  ),
                );
              },
              child: Center(
                child: AnnouncementItem(announcement: announcements[index]),  // Use global list
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ),
    );
  }
}

// Remove the old getList function - no longer needed