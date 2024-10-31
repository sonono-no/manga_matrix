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

//project files

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'user';
  String password = '';
  String email = '';

  bool readOnly = true;
  bool switched = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    Text(
                      'Hello, $username!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
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