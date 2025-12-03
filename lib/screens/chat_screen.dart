import 'package:collabify/components/friends_item.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffF7F3E7),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 75,
          backgroundColor: const Color(0xFF6B2FD9),
          title: Text(
            "Chats",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: const Center(
          child: Column(
            children: [
               SizedBox(
            height: 15
          ),
          FriendsItem(letter: "N", name: "Nada", username: "nadaelhegawy11",color: Colors.green,status: "Online",statusColor: Colors.green,),
          SizedBox(
            height: 8
          ),
          FriendsItem(letter: "Y", name: "Youssef", username: "yusf404",color: Colors.green,status: "Online",statusColor: Colors.green,),
          SizedBox(
            height: 8
          ),
          FriendsItem(letter: "M", name: "Maya", username: "mayaelashry101",color: Colors.green,status: "Online",statusColor: Colors.green,),
          SizedBox(
            height: 8
          ),
          FriendsItem(letter: "J", name: "Jana", username: "janahazem32",color: Colors.green,status: "Online",statusColor: Colors.green,),
          SizedBox(
            height: 8),
            FriendsItem(letter: "G", name: "Gaber", username: "abdelrahmangaber", color: Colors.grey,status: "Offline",statusColor: Colors.red,),
            SizedBox(height: 8),
            FriendsItem(letter: "A", name: "Asmaa", username: "asmaaelboghdady", color: Colors.grey,status: "Offline",statusColor: Colors.red,),
           Spacer(flex: 1),
            ],
          ),
        ),
    );
  }
}
