import 'package:flutter/material.dart';

class RequestTab extends StatelessWidget {
  const RequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 3,),
        Icon(
          Icons.notifications_rounded,
          size: 83,
          color: Color(0xffBDBDBD),
        ),
         Spacer(flex: 1,),
        Text(
          "No pending requests",
          style: TextStyle(
              color: Color(0xff8B8B83),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
         Spacer(flex: 1,),
        Text(
          "Requests will apear here",
          style: TextStyle(
            color: Color(0xffBDBDBD),
            fontSize: 15,
          ),
        ),
         Spacer(flex: 20,),
      ],
    );
  }
}
