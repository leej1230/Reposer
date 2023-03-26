import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(150.0),
      ),
      child: TextField(
        style: TextStyle(
          color: Color(0xFF929292),
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
        decoration: InputDecoration(
          icon: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Icon(
                Icons.search,
                color: Colors.yellow,
              ),
            ),
          ),
          border: InputBorder.none,
          hintText: 'Search Songs',
          hintStyle: TextStyle(
            color: Color(0xFF929292),
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
          contentPadding: EdgeInsets.all(3.0),
        ),
      ),
    );
  }
}
