import 'dart:ui';

import 'package:collabify/components/announcement_item.dart';
import 'package:collabify/models/announcement.dart';
import 'package:collabify/screens/announcement_detail_screen.dart';

import 'package:flutter/material.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  final List<Announcement> announcements = const [
    Announcement(
        uaserName: "@nada",
        projectName: "Wusol",
        describtion:
            "I'm building a mobile app that connects to Spotify and uses AI to generate unique visuals based on what you're listening to. I'm planning on using a react frontend, with rust on the back.",
        language: "flutter",
        teamNum: "4",
        projrctType: "mobile"),
    Announcement(
        uaserName: "@yusf",
        projectName: "Collabify",
        describtion:
            "I'm building a web app that connects to Spotify and uses AI to generate unique visuals based on what you're listening to. I'm planning on using a react frontend, with rust on the back.",
        language: "react",
        teamNum: "2",
        projrctType: "web"),
    Announcement(
        uaserName: "@jana",
        projectName: "Study Tracking App",
        describtion:
            "I'm working on a mobile app for helping track study patterns. The goal is to have something similar to quizlet, but simpler and easier to navigate.",
        language: "kotlin",
        teamNum: "1",
        projrctType: "mobile"),
    Announcement(
        uaserName: "@maya",
        projectName: "AI Crypto Tool",
        describtion:
            "been reading about crypto prediction and ML stuff. want to make a basic tool using past prices to spot patterns.",
        language: "python",
        teamNum: "1",
        projrctType: "desktop"),
    Announcement(
        uaserName: "@gaber",
        projectName: "Open Source Animation App",
        describtion:
            "Let's make an open source animation app together! New to Github and programming so please walk me through, I am learning too so if you don't know anything too, I want to hear from everybody!",
        language: "javaScript",
        teamNum: "5",
        projrctType: "web"),
  ];

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
                    color: Colors.white),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.announcement_rounded,
                color: Colors.white,
              )
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
        body:  ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          return InkWell(  // Wrap with InkWell for tapability and ripple effect
            onTap: () {
              // Navigate to the details screen and pass the announcement
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnnouncementDetailScreen(
                    announcement: announcements[index],
                  ),
                ),
              );
            },
            child: Center(
              child: AnnouncementItem(announcement: announcements[index]),
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

List<Widget> getList(List<Announcement> announcements) {
  List<AnnouncementItem> itemsList = [];
  for (int i = 0; i < announcements.length; i++) {
    itemsList.add(AnnouncementItem(announcement: announcements[i]));
  }
  return itemsList;
}
