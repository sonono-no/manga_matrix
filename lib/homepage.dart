/* homepage.dart
 * does: implements homepage & homescreen (entry screen) of appbar
 *       initialiZes list of tabs for appbar tabbar
 *       initializes list values for types, statuses, and userstatuses dropdowns
 * calls: listscreen.dart, searchscreen.dart, profilescreen.dart
 * depends on: main.dart
 */

//flutter libraries
import 'package:flutter/material.dart';

//project files
import 'package:manga_matrix/listscreen.dart';
import 'package:manga_matrix/profilescreen.dart';
import 'package:manga_matrix/searchscreen.dart';
import 'package:manga_matrix/hometab.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> _tabs = [
    NestedTabBar('Entry'),
    ListScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Text('Welcome to Manga Matrix!'),
          scrolledUnderElevation: 5,
          bottom: TabBar(
            labelColor: Colors.pink[100],
            indicatorColor: Colors.pink[100],
            tabs: [
              Tab(icon: Icon(Icons.format_list_bulleted_add), text: 'Entry'),
              Tab(icon: Icon(Icons.list_alt), text: 'My List'),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Manual Entry'),
            Tab(text: 'List Entry'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ManualEntryTab(),
              ListEntryTab()
            ],
          ),
        ),
      ],
    );
  }
}