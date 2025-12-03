import 'package:flutter/material.dart';

class FriendsItem extends StatelessWidget {
  const FriendsItem(
      {super.key,
      required this.letter,
      required this.name,
      required this.username,
      required this.color,
      required this.status,required this.statusColor});
  final String? letter;
  final String? name;
  final String? username;
  final Color? color;
  final String status;
  final Color? statusColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A148C), Color(0xFF6B2FD9)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // to create a clean ring
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    letter!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),

              // Status dot
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color, // online color
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // to create a clean ring
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                username!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle_rounded,
                    size: 5,
                    color: statusColor,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Icon(Icons.more_horiz_rounded),
        ],
      ),
    );
  }
}
