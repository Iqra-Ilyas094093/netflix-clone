import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/view/screens/home_screen.dart';
import 'package:netflix_clone/view/screens/more_screen.dart';
import 'package:netflix_clone/view/screens/search_screen.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // match your app background
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          height: 70,
          child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.search_outlined),
              text: 'Search',
            ),
            Tab(
              icon: Icon(Icons.photo_library_outlined),
              text: 'More Hot Data',
            ),
          ]),
        ),
        body: TabBarView(children: [
          HomeScreen(),
          SearchScreen(),
          MoreScreen(),
        ]),
      ),
    );
  }
}
