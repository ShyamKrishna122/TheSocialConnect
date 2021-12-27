import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/api/posts.api.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/meta/widget/post_body_widget.dart';
import 'package:sociocon/meta/widget/story_body_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SocioCon"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.messenger,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoryBodyWigdet(),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            //PostBodyWidget(),
            MaterialButton(
              color: Colors.red,
              onPressed: () async{
                await Provider.of<PostsNotifier>(context, listen: false).getPosts(
                  userMail: "shyam@gmail.com",
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              label: 'fav'),
          BottomNavigationBarItem(icon: CircleAvatar(), label: 'me'),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}