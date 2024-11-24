/* profilescreen.dart
 * does: displays info for current user
 *       takes snapshot of user collection in db and displays info
 *       allows edits to displayed data
 *       submits and updates db with edited data
 * calls: mongodb.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:manga_matrix/dbHelper/constants.dart';
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/db_user_model.dart';

//project files

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var usernameController = new TextEditingController();
  var emailController = new TextEditingController();

  String username = CURR_USER;

  bool readOnly = true;
  bool switched = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/wotakoi_ep25.png"), fit: BoxFit.fitWidth),
        ),
        child:SingleChildScrollView(
          child: FutureBuilder(
            future: MongoDatabase.queryUserDataEq('username', CURR_USER), 
            builder: (context , AsyncSnapshot snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var totalData = snapshot.data.length;
                  print("Total Data" + totalData.toString());
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Text(
                                  'Hello, $username!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    //color: Colors.pink[200],
                                  ),
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Text('Toggle edit mode ')
                              ),
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
                                      filled: true,
                                      fillColor: Colors.pink[50],
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
                                  initialValue: dbUserModel.fromJson(snapshot.data[0]).email,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.pink[50],
                                    labelText: "Email"
                                  ),
                                ),
                              )
                            )
                          ]
                        )
                      ),
                      Row( // fill page for better view of background
                        children: [
                          new Flexible(child: SizedBox(height: 400,))
                        ],
                      )
                    ]
                  );
                } else {
                  return Center(
                    child: Text("No data"),
                  );
                }
              }
            }
        )
      )
    )
    );
  }
}