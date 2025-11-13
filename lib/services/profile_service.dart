import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Model class for profile data
class ProfileData {
  final String username;
  final String fullName;
  final String bio;
  final String portfolioLink;
  final String nationality;
  final String interest;
  final List<String> hashtags;
  final String? profilePhotoPath;

  ProfileData({
    required this.username,
    required this.fullName,
    required this.bio,
    required this.portfolioLink,
    required this.nationality,
    required this.interest,
    required this.hashtags,
    this.profilePhotoPath,
  });

  /// Convert ProfileData to JSON
  Map<String, dynamic> toJson() => {
        'username': username,
        'fullName': fullName,
        'bio': bio,
        'portfolioLink': portfolioLink,
        'nationality': nationality,
        'interest': interest,
        'hashtags': hashtags,
        'profilePhotoPath': profilePhotoPath,
      };

  /// Create ProfileData from JSON
  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        username: json['username'] ?? '',
        fullName: json['fullName'] ?? '',
        bio: json['bio'] ?? '',
        portfolioLink: json['portfolioLink'] ?? '',
        nationality: json['nationality'] ?? '',
        interest: json['interest'] ?? '',
        hashtags: List<String>.from(json['hashtags'] ?? []),
        profilePhotoPath: json['profilePhotoPath'],
      );

  /// Create a copy with updated fields
  ProfileData copyWith({
    String? username,
    String? fullName,
    String? bio,
    String? portfolioLink,
    String? nationality,
    String? interest,
    List<String>? hashtags,
    String? profilePhotoPath,
  }) {
    return ProfileData(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      portfolioLink: portfolioLink ?? this.portfolioLink,
      nationality: nationality ?? this.nationality,
      interest: interest ?? this.interest,
      hashtags: hashtags ?? this.hashtags,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
    );
  }
}

/// Service class for managing profile data in local storage
class ProfileService {
  static const String _keyPrefix = 'profile_';

  /// Save profile data to local storage
  static Future<bool> saveProfile(ProfileData profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _keyPrefix + profile.username;
      final jsonString = jsonEncode(profile.toJson());
      return await prefs.setString(key, jsonString);
    } catch (e) {
      print('Error saving profile: $e');
      return false;
    }
  }

  /// Get profile data from local storage
  static Future<ProfileData?> getProfile(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _keyPrefix + username;
      final jsonString = prefs.getString(key);
      
      if (jsonString == null) return null;
      
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return ProfileData.fromJson(jsonMap);
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  /// Check if a profile exists for the given username
  static Future<bool> hasProfile(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _keyPrefix + username;
      return prefs.containsKey(key);
    } catch (e) {
      print('Error checking profile: $e');
      return false;
    }
  }

  /// Delete profile from local storage
  static Future<bool> deleteProfile(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _keyPrefix + username;
      return await prefs.remove(key);
    } catch (e) {
      print('Error deleting profile: $e');
      return false;
    }
  }

  /// Get all stored profile usernames
  static Future<List<String>> getAllUsernames() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      return keys
          .where((key) => key.startsWith(_keyPrefix))
          .map((key) => key.replaceFirst(_keyPrefix, ''))
          .toList();
    } catch (e) {
      print('Error getting all usernames: $e');
      return [];
    }
  }

  /// Clear all profile data
  static Future<bool> clearAllProfiles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      for (final key in keys) {
        if (key.startsWith(_keyPrefix)) {
          await prefs.remove(key);
        }
      }
      
      return true;
    } catch (e) {
      print('Error clearing all profiles: $e');
      return false;
    }
  }
}