import 'package:collabify/components/friends_item.dart';
import 'package:flutter/material.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 58,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6D23BE), Color(0xFF864AC4)],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.green,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "4 online",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Spacer(
                    flex: 30,
                  ),
                  Text(
                    "10 total friends",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FriendsItem(letter: "N", name: "Nada", username: "nadaelhegawy11",color: Colors.green,status: "Online",statusColor: Colors.green,),
            SizedBox(
              height: 8,
            ),
            FriendsItem(letter: "Y", name: "Youssef", username: "yusf404",color: Colors.green,status: "Online",statusColor: Colors.green,),
            SizedBox(
              height: 8,
            ),
            FriendsItem(letter: "M", name: "Maya", username: "mayaelashry101",color: Colors.green,status: "Online",statusColor: Colors.green,),
            SizedBox(
              height: 8,
            ),
            FriendsItem(letter: "J", name: "Jana", username: "janahazem32",color: Colors.green,status: "Online",statusColor: Colors.green,),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}




















// Container(
//                   padding: const EdgeInsets.all(30),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF6B2FD9),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.people,
//                     size: 80,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   'Friends',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF4A148C),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Connect with your collaborators',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),