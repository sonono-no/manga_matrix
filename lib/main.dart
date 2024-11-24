/* main.dart
 * does: establishes and runs app
 *       connects database
 *       implements up log-in page
 * calls: signuppage.dart, homepage.dart, mongodb.dart
 * depends on: N/A
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:manga_matrix/dbHelper/constants.dart';

//project files
import 'homepage.dart';
import 'dbHelper/mongodb.dart';
import 'signuppage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<MainPage> {
  bool _obscure = true;
  var usernameController = new TextEditingController();
  var pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text('Welcome to Manga Matrix!')),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/wotakoi_reading_sit.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
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
                      padding: const EdgeInsets.all(5.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (usernameController.text.isNotEmpty && pwdController.text.isNotEmpty) {
                        CURR_USER = usernameController.text;
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return MyHomePage();
                        }));
                      } else {
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog (
                          title: const Text('Invalid log-in'),
                          content: const Text('Fields must not be empty, please enter info and try again.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'), 
                              child: const Text('OK'),
                              )
                          ],
                        ));
                      }
                    }, 
                    child: Text('Log in'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return SignUpPage();
                    }));
                  }, 
                  child: Text('New user? Sign up!', 
                    style: TextStyle(decoration: TextDecoration.underline),
                  ))
              ]
            )
        ],)
      ),
    );
  }
}
