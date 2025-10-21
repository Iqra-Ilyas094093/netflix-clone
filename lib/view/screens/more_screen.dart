import 'package:flutter/material.dart';

import '../widgets/coming_soon_movie_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text('New & Hot',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.cast, color: Colors.white, size: 30),
            ),
          ),
          Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 20),
        ],
          bottom: TabBar(
            dividerColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white70
              ),
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
              tabs: [
            Tab(text: '    Coming Soon    ',),
            Tab(text: "    Everyone's Watching    ",),
          ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            ComingSoonMovieWidget(
              imageUrl:
              'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
              overview:
              'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
              logoUrl:
              "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
              month: "Jun",
              day: "19",
            ),
            SizedBox(
              height: 20,
            ),
            ComingSoonMovieWidget(
              imageUrl:
              'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
              overview:
              'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
              logoUrl:
              "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
              month: "Mar",
              day: "07",
            ),
            SizedBox(
              height: 20,
            ),
            ComingSoonMovieWidget(
          imageUrl:
          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
          overview:
          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
          logoUrl:
          "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
          month: "Feb",
          day: "20",
        ),
          ],
        ),
      ),
      ),
    );
  }
}
