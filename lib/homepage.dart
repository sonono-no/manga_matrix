import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

String dropdownvalue = 'Manga';

var types = [
  'Manga',
  'Manhwa',
  'Webtoon',
  'Light novel',
  'Other',
];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int statusVal = -1;
  Status _status = Status.ongoing;
  UserStatus _userStatus = UserStatus.caughtUp;

  void _handleStatusRadioChange(int value) {
    setState(() {
      statusVal = value;

      switch (statusVal) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                Text('* = Required', style: TextStyle(color: Colors.pink),)
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('*Name: ', style: TextStyle(fontSize: 14)),
                ),
                new Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  )
                ),
                Text(' Publisher: ', style: TextStyle(fontSize: 14)),
                new Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  )
                )
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Text('*Chapters read: ', style: TextStyle(fontSize: 14)),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                      border: OutlineInputBorder()
                      ),
                      inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    )
                  ),
                Text(' /   *Total Chapters: ', style: TextStyle(fontSize: 14)),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                      border: OutlineInputBorder()
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
                  Radio(value: 0, groupValue: statusVal, onChanged: (index){
                    _handleStatusRadioChange;
                  }),
                  Text('Ongoing'),
                  SizedBox(width: 20,),
                  Radio(value: 1, groupValue: statusVal, onChanged: (index){
                    _handleStatusRadioChange;
                  }),
                  Text('Completed'),
                  SizedBox(width: 10,),
                  Radio(value: 2, groupValue: statusVal, onChanged: (index){
                    _handleStatusRadioChange;
                  }),
                  Text('Hiatus')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Radio(value: 1, groupValue: null, onChanged: (index){}),
                  Text('Caught up'),
                  SizedBox(width: 10,),
                  Radio(value: 2, groupValue: null, onChanged: (index){}),
                  Text('Dropped'),
                  SizedBox(width: 24,),
                  Radio(value: 3, groupValue: null, onChanged: (index){}),
                  Text('Want to read')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('*Type:    '),
                DropdownButton(
                  value: dropdownvalue,
                  items: types.map((String types){
                    return DropdownMenuItem(
                      value: types,
                      child: Text(types),
                      );
                  }).toList(), 
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  }),
                  Text('  *Rating: ', style: TextStyle(fontSize: 14)),
                  SizedBox(
                    width: 50,
                    height: 60,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
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
                  Text(' / 10')
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Text('Comments: ', style: TextStyle(fontSize: 14)),
                new Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
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

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        ListView.builder(
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              tileColor: index.isOdd ? const Color.fromARGB(73, 124, 17, 53) : Colors.white,
              title: Text('Manga $index'),
              onTap: () {
              
              },
            );
          }
        ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}