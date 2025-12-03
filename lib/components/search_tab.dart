import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.orange),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.orange,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Search by username',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xffF7F3E7),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 8,),
          Icon(
            Icons.search,
            size: 83,
            color: Color(0xffBDBDBD),
          ),
         
          Text(
            "Search for a friend",
            style: TextStyle(
              color: Color(0xff8B8B83),
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          
          Text(
            "Enter at least 2 letters to search",
            style: TextStyle(
              color: Color(0xffBDBDBD),
              fontSize: 15,
            ),
          ),
          Spacer(flex: 7,),
        ],
      ),
    );
  }
}
