/* homepage.dart
 * does: implements homepage & homescreen (entry screen) of appbar
 *       initialiZes list of tabs for appbar tabbar
 *       initializes list values for types, statuses, and userstatuses dropdowns
 * calls: listscreen.dart, searchscreen.dart, profilescreen.dart
 * depends on: main.dart
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//project files
import 'package:manga_matrix/listscreen.dart';
import 'package:manga_matrix/profilescreen.dart';
import 'package:manga_matrix/searchscreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> _tabs = [
    HomeScreen(),
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
          title: Text('Welcome to Manga Matrix!'),
          scrolledUnderElevation: 5,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
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

enum Status { ongoing, completed, hiatus }
enum UserStatus { caughtUp, dropped, wantToRead }

String typesdropdownvalue = 'Manga';
var types = [
  'Manga',
  'Manhwa',
  'Webtoon',
  'Light novel',
  'Other',
];

String statusesdropdownvalue = 'Ongoing';
var statuses = [
  'Ongoing',
  'Completed',
  'Hiatus'
];

String userstatusesdropdownvalue = 'Caught up';
var userStatuses = [
  'Caught up',
  'Still Reading',
  'Dropped',
  'Want to read'
];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Manual entry:', style: TextStyle(fontSize: 17, decoration: TextDecoration.underline)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(children: [
                Text('* = Required', style: TextStyle(color: Colors.blue),)
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                new Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "*Manga Name"
                    ),
                  )
                )
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                new Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Publisher"
                    ),
                  )
                )
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                SizedBox(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "*Chapters"
                      ),
                      inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    )
                  ),
                Text(' out of ', style: TextStyle(fontSize: 14)),
                SizedBox(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "*Total"
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    )
                  ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('*Manga status: '),
                  SizedBox(width: 5,),
                  DropdownButton(
                    value: statusesdropdownvalue,
                    items: statuses.map((String statuses){
                      return DropdownMenuItem(
                        value: statuses,
                        child: Text(statuses),
                        );
                    }).toList(), 
                    onChanged: (String? newValue) {
                      setState(() {
                        statusesdropdownvalue = newValue!;
                      });
                    }
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('*User status: '),
                  SizedBox(width: 5,),
                  DropdownButton(
                    value: userstatusesdropdownvalue,
                    items: userStatuses.map((String userStatuses){
                      return DropdownMenuItem(
                        value: userStatuses,
                        child: Text(userStatuses),
                        );
                    }).toList(), 
                    onChanged: (String? newValue) {
                      setState(() {
                        userstatusesdropdownvalue = newValue!;
                      });
                    }
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('*Type:    '),
                DropdownButton(
                  value: typesdropdownvalue,
                  items: types.map((String types){
                    return DropdownMenuItem(
                      value: types,
                      child: Text(types),
                      );
                  }).toList(), 
                  onChanged: (String? newValue) {
                    setState(() {
                      typesdropdownvalue = newValue!;
                    });
                  }),
                  SizedBox(width: 6,),
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "*Rating"
                      ),
                      validator: (value) {
                        if (value!.isEmpty) { //if value is null (! is null check)
                          return 'Please enter the Overall Rating';
                        } else if (int.parse(value) < 1 || int.parse(value) > 10) {
                          return 'The rating must be between 1 and 10';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 2,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    )
                  ),
                  Text(' out of 10')
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                new Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Comments"
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )
                ),
              ],),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: (){}
                  ),
              )
            ],)
          ],
        ),
      ),
    );
  }
}