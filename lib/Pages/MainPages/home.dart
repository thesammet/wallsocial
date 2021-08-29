
import 'package:flutter/material.dart';
import 'package:wallSocial/Pages/MainPages/profile.dart';
import 'package:wallSocial/Pages/MainPages/top_list.dart';
import 'Upload Photo Pages/upload_photo.dart';
import 'dashboard.dart';
import 'search.dart';

class Home extends StatefulWidget {
  /*final int currentTabHome;

  const Home({
    Key key,
    this.currentTabHome,
  }) : super(key: key);*/
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    SearchPage(),
    UploadPhoto(),
    Toplist(),
    Profile(),
  ];

  Widget currentState = Dashboard();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentState,
        bucket: bucket,
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {},
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        //shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentState = Dashboard();
                    currentTab = 0;
                  });
                },
                minWidth: 40,
                child: Icon(
                  Icons.dashboard,
                  color: currentTab == 0 ? Colors.yellow[700] : Colors.white,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentState = SearchPage();
                    currentTab = 1;
                  });
                },
                minWidth: 40,
                child: Icon(
                  Icons.search,
                  color: currentTab == 1 ? Colors.yellow[700] : Colors.white,
                ),
              ),
            
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentState = UploadPhoto();
                    currentTab = 2;
                  });
                },
                minWidth: 40,
                child: Icon(
                  Icons.send,
                  color: currentTab == 2 ? Colors.yellow[700] : Colors.white,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentState = Toplist();
                    currentTab = 3;
                  });
                },
                minWidth: 40,
                child: Icon(
                  Icons.emoji_events,
                  color: currentTab == 3 ? Colors.yellow[700] : Colors.white,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentState = Profile();
                    currentTab = 4;
                  });
                },
                minWidth: 40,
                child: Icon(
                  Icons.person,
                  color: currentTab == 4 ? Colors.yellow[700] : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
