import 'package:flutter/material.dart';
import 'package:personeels_app/pages/werknemers_home_page.dart';
import 'package:personeels_app/pages/werknemers_index_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.setSignedIn}) : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.blue,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info_outline)),
              Tab(icon: Icon(Icons.people)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const WerknemersHomePage(),
            WerknemersIndexPage(setSignedIn: widget.setSignedIn),
          ],
        ),
      ),
    );
  }
}
