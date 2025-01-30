import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'files_page.dart';
import 'tools_page.dart';
import 'me_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({
    super.key,
  });

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  int pageIndex = 0;

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  final title = ['Home', 'Files', 'Tools', 'Me'];
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(onPressed: changePage),
      const FilesPage(),
      const ToolsPage(),
      const MePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title[pageIndex],
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900])),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.purple[900]),
            onPressed: signUserOut,
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: myNavigationBar(context),
    );
  }

  Container myNavigationBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () => changePage(0),
            icon: pageIndex == 0
                ? Icon(
                    Icons.home,
                    color: Colors.purple[900],
                    size: 35,
                  )
                : Icon(
                    Icons.home_outlined,
                    color: Colors.purple[900],
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () => changePage(1),
            icon: pageIndex == 1
                ? Icon(
                    Icons.work_rounded,
                    color: Colors.purple[900],
                    size: 35,
                  )
                : Icon(
                    Icons.work_outline_outlined,
                    color: Colors.purple[900],
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () => changePage(2),
            icon: pageIndex == 2
                ? Icon(
                    Icons.widgets_rounded,
                    color: Colors.purple[900],
                    size: 35,
                  )
                : Icon(
                    Icons.widgets_outlined,
                    color: Colors.purple[900],
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () => changePage(3),
            icon: pageIndex == 3
                ? Icon(
                    Icons.person,
                    color: Colors.purple[900],
                    size: 35,
                  )
                : Icon(
                    Icons.person_outline,
                    color: Colors.purple[900],
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
