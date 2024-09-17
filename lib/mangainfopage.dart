import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_matrix/main.dart';

class MangaInfoPage extends StatefulWidget {
  const MangaInfoPage({Key? key}) : super(key: key);

  @override
  State<MangaInfoPage> createState() => _MangaInfoPageState();
}

class _MangaInfoPageState extends State<MangaInfoPage> {

  //TODO: pull from db
  String mangaName = ''; 
  String publisher = '';
  int chRead = 0;
  int chTotal = 0;
  String status = '';
  String userStatus = '';
  String type = '';
  int rating = 0;
  String comments = '';

  bool readOnly = true;
  bool switched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga Matrix: Manga Info'),
      ),
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
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Manga Name:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: mangaName,
                      ),
                      )
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Publisher:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: publisher,
                      ),
                      )
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Chapters read:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: chRead.toString(),
                      ),
                    )
                  ),
                  ElevatedButton(
                    child: Text('+1'),
                    onPressed: (){
                      //TODO: get this to work
                      //chRead++;
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' / '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: chTotal.toString(),
                      ),
                    )
                  ),
                  ElevatedButton(
                    child: Text('+1'),
                    onPressed: (){
                      //TODO: get this to work
                      //chTotal++;
                    }
                  ),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' Manga Status:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: status,
                      ),
                      )
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('User Status:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: userStatus,
                      ),
                    )
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Type:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: type,
                      ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' Rating: '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        initialValue: rating.toString(),
                      ),
                    )
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Comments:        '),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: readOnly,
                        maxLines: null,
                        initialValue: comments,
                      ),
                    )
                  )
                ]
              )
            ),
          ],
        )
      )
    );
  }
}