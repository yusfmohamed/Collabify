import 'package:collabify/models/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff532B77),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xff8E7CA0),
                child: Icon(
                  Icons.person,
                  color: Color(0xffBEA5D3),
                ),
              ),
              const Spacer(flex: 1),
              Text(
                announcement.userName,  // Fixed
                style: const TextStyle(
                  color: Color(0xff8E7CA0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(flex: 10),
              const Text(
                "11mo",
                style: TextStyle(
                  color: Color(0xff8E7CA0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            announcement.projectName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Text(
            announcement.description,  // Fixed
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff8E7CA0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  announcement.language,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                const Icon(
                  Icons.people_alt,
                  color: Colors.white,
                ),
                Text(
                  announcement.teamNum,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  announcement.projectType,  // Fixed
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}