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

  final title = ['Home', 'Files', 'Tools', 'Me'];
  final pages = [
    const HomePage(),
    const FilesPage(),
    const ToolsPage(),
    const MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title[pageIndex], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
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
      decoration: BoxDecoration(
        color: Colors.purple[900],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.work_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
