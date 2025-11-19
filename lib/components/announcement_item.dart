import 'package:collabify/models/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementItem extends StatelessWidget {
  AnnouncementItem({required this.announcement});


  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      width: 358,
      height: 220,
      padding: const EdgeInsets.all(16),
      //color: Colors.blueAccent,
      decoration: BoxDecoration(
        color: const Color(0xff532B77),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4)),
        ],
      ),

      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xff8E7CA0),
                child: Icon(
                  Icons.person,
                  color: Color(0xffBEA5D3),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                announcement.uaserName,
                style: TextStyle(
                  color: Color(0xff8E7CA0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Spacer(
                flex: 10,
              ),
              Text(
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Text(
            announcement.describtion,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff8E7CA0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  announcement.language,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Icon(
                  Icons.people_alt,
                  color: Colors.white,
                ),
                Text(
                  announcement.teamNum,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  announcement.projrctType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ], //children of column
      ),
    );
  }
}
