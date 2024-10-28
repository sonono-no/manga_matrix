import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/mangainfopage.dart';
import 'package:manga_matrix/dbEntryModel.dart';

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
                  Text('Manga status: '),
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
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('User status: '),
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
                  }),
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

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getEntryData(),
          builder: (context , AsyncSnapshot snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print("Total Data" + totalData.toString());
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return displayEntryCard(
                      dbEntryModel.fromJson(snapshot.data[index]));
                  });
              } else {
                return Center(
                  child: Text("No data available."),
                );
              }
            }
          }
        )
      )
    );
  }

  Widget displayEntryCard(dbEntryModel data){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return MangaInfoPage(entryData: data);
        }));
      },
      child: 
        Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("${data.mangaName}"),
              SizedBox(height: 5,),
              Text("Chapters read: ${data.chaptersRead}"),
              SizedBox(height: 5,),
              Text("User status: ${data.userStatus}"),
              SizedBox(height: 5,),
              Text("Rate: ${data.rating}/10"),
            ],
          ),
        ),
      )
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override

  String username = '';
  String password = '';
  String email = '';

  bool readOnly = true;
  bool switched = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Toggle edit mode '),
                  ),
                  Switch(
                    value: switched, 
                    onChanged: (bool newValue) {
                      setState(() {
                        switched = newValue;
                        switched ? readOnly = false : readOnly = true;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text('Submit Edits'),
                      onPressed: (){
                        if (readOnly){
                          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                            title: const Text('Not in Edit Mode'),
                            content: const Text('If you wish to edit, please toggle Edit Mode then make edits and press Submit Edits.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'), 
                                child: const Text('OK'),
                              )
                            ],
                          ));
                        } else {
                          //TODO: Update DB
                          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                            title: const Text('Edits Submitted!'),
                            content: const Text('Changes have been submitted to the database and your list has been updated.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'), 
                                child: const Text('OK'),
                                )
                            ],
                          ));
                        }
                      }
                    ),
                  ),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          readOnly: readOnly,
                          initialValue: username,
                          decoration: InputDecoration(
                            labelText: "Username"
                          ),
                        ),
                    ),
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: email,
                        decoration: InputDecoration(
                          labelText: "Email"
                        ),
                      ),
                    )
                  )
                ]
              )
            ),
          ]
        )
      )
    );
  }
  
}