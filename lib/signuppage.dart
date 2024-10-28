import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_matrix/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscure = true;
  bool _obscure2 = true;
  bool valid = true;

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
                      valid = validateEntry();
                      if(valid){
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

bool validateEntry(){
  //TODO: add entry validation
  return true;
}