import 'package:collabify/components/friends_tab.dart';
import 'package:collabify/components/request_tab.dart';
import 'package:collabify/components/search_tab.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Color(0xffF7F3E7),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: const Color(0xFF6B2FD9),
          title: Text(
            "Friends",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Container(
              color: Color(0xffF7F3E7),
              child: const TabBar(    
                indicatorColor: Colors.orange,
                labelColor: Color(0xff6E3CA4),
                unselectedLabelColor: Colors.grey,
                tabs: [
                    Tab(
                    icon: Icon(Icons.people_alt),
                    text: 'Friends',
                  ),
                  Tab(
                    icon: Icon(Icons.notifications),
                    text: 'Requests',
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                    text: 'Search',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(children: [
          FriendsTab(),
          RequestTab(),
          SearchTab(),
        ],),
      ),
    );
  }
}
