/* signuppage.dart
 * does: implements the sign-up page
 * calls: main.dart (log-in page)
 * depends on: main.dart
 */

//flutter libraries
import 'package:flutter/material.dart';

//project files
import 'package:manga_matrix/main.dart';
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/db_user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // pwd hidden bools
  bool _obscure = true;
  bool _obscure2 = true;

  // input validation
  bool valid = true;

  // text field controllers
  var usernameController = new TextEditingController();
  var emailController = new TextEditingController();
  var pwdController = new TextEditingController();
  var pwdConfController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga Matrix: Sign up'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your email',
                          labelText: "Email"
                        ),
                      ),
                    )
                  ),
                ],
              ),
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your username',
                          labelText: "Username"
                        ),
                      ),
                    )
                  ),
                ],
              ),
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
                        controller: pwdController,
                        obscureText: _obscure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your password',
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            }, 
                            )
                        ),
                      ),
                    )
                  ),
                ],
              ),
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
                        controller: pwdConfController,
                        obscureText: _obscure2,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Confirm your password',
                          labelText: "Confirm password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscure2 ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscure2 = !_obscure2;
                              });
                            }, 
                            )
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      valid = validateEntry(usernameController.text, emailController.text, pwdController.text, pwdConfController.text);
                      if(valid){
                        // insert user to db
                        _insertUser(usernameController.text, pwdController.text, emailController.text);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return MainPage();
                        }));
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                          title: const Text('Account Created'),
                          content: const Text('Account has been created! Redirecting to the log-in page.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'), 
                              child: const Text('OK'),
                              )
                          ],
                        ));
                      } else {
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                          title: const Text('Invalid Entry'),
                          content: const Text('Account info is invalid, please fix entry and try again.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'), 
                              child: const Text('OK'),
                              )
                          ],
                        ));
                      }
                    }, 
                    child: Text('Create Account'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* insert new user
 * param: username, pwd, and email controllers
 */
Future<void> _insertUser(String username, String password, String email) async {
  final data = dbUserModel(username: username, password: password, email: email);
  var result = await MongoDatabase.insertUser(data);
}

/* checks if pwds match + checks acc doesnt exist
 * returns true if valid, false if not
 */
bool validateEntry(String username, String email, String pwd, String pwdConf){

  // if pwds dont match -> return false
  if (pwd != pwdConf) {
    return false;
  }

  //if any fields empty -> return false
  if (username.isEmpty || email.isEmpty || pwd.isEmpty || pwdConf.isEmpty)
    return false;

  //TODO: fix entry validation

  // if account exists -> popup "acc exists" -> nav log in
  /*
  Scaffold(
    body: FutureBuilder(
      future: MongoDatabase.queryUserDataEq("username", username), 
      builder: (context , AsyncSnapshot snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            var totalData = snapshot.data.length;
            print("Total Data" + totalData.toString());
            if (dbUserModel.fromJson(snapshot.data[0]).email == email 
                && dbUserModel.fromJson(snapshot.data[0]).password == pwd) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return MainPage();
                  }));
                  showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                    title: const Text('Account Exists'),
                    content: const Text('This account already exists in the database, please log in.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'), 
                        child: const Text('OK'),
                        )
                    ],
                  ));
                }
            return Center(
              child: Text('Account already exists'),
            );
          } else {
            return Center(
              child: Text('Creating user...'),
            );
          }
        }
      })
    ,);
    */
  return true;
}