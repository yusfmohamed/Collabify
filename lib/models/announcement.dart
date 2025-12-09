//import 'package:flutter/material.dart';

class Announcement {
  final String userName;  // Fixed from uaserName
  final String projectName;
  final String description;  // Fixed from describtion
  final String language;
  final String teamNum;
  final String projectType;  // Fixed from projrctType

  const Announcement({
    required this.userName,
    required this.projectName,
    required this.description,
    required this.language,
    required this.teamNum,
    required this.projectType,
  });
}