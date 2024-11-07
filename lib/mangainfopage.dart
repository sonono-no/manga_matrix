/* mangainfopage.dart
 * does: displays info from manga and entry collections of database
 *       takes in data for entry collection from list screen
 *       takes snapshot of data from manga collection in db
 *       allows edits on displayed info
 *       submits and updates db with edited info
 * calls: mongodb.dart
 * depends on: listscreen.dart
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//project files
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/db_manga_model.dart';
import 'package:manga_matrix/db_entry_model.dart';

class MangaInfoPage extends StatefulWidget {
  final dbEntryModel entryData;

  const MangaInfoPage({Key? key, required this.entryData}) : super(key: key);

  @override
  State<MangaInfoPage> createState() => _MangaInfoPageState();
}

String typesdropdownvalue = 'MANGA';
var types = [
  'MANGA',
  'MANHWA',
  'WEBTOON',
  'LIGHT NOVEL',
  'OTHER',
];

String statusesdropdownvalue = 'ONGOING';
var statuses = [
  'ONGOING',
  'COMPLETED',
  'HIATUS'
];

String userstatusesdropdownvalue = 'CAUGHT UP';
var userStatuses = [
  'CAUGHT UP',
  'STILL READING',
  'DROPPED',
  'WANT TO READ'
];

class _MangaInfoPageState extends State<MangaInfoPage> {

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

  void setDbVars(dbMangaModel data) {
    mangaName = widget.entryData.mangaName;
    if(data.publisher.isNotEmpty){
      publisher = data.publisher;
    }
    
    chRead = widget.entryData.chaptersRead;
    chTotal = data.totalChapters;
    status = data.status;
    userStatus = widget.entryData.userStatus;
    type = data.type;
    rating = widget.entryData.rating;
    comments = widget.entryData.comments;

    for (final item in types){
      if (type.toUpperCase() == item){
        typesdropdownvalue = type.toUpperCase();
      }
    }

    for (final item in statuses){
      if (status.toUpperCase() == item){
        statusesdropdownvalue = status.toUpperCase();
      }
    }

    for (final item in userStatuses){
      if (userStatus.toUpperCase() == item){
        userstatusesdropdownvalue = userStatus.toUpperCase();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('Manga Matrix: Manga Info'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/wotakoi_playing_stand.jpg"), fit: BoxFit.fitWidth),
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: MongoDatabase.queryMangaDataEq('manga name', widget.entryData.mangaName), 
            builder: (context , AsyncSnapshot snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  setDbVars(dbMangaModel.fromJson(snapshot.data[0]));
                  var totalData = snapshot.data.length;
                  print("Total Data" + totalData.toString());
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: mangaName,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                    labelText: "Manga name"
                                  ),
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
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: publisher,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                    labelText: "Publisher"
                                  ),
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
                              child: Text('Chapters read: '),
                            ),
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: readOnly,
                                  initialValue: chRead.toString(),
                                  inputFormatters:<TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
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
                                  inputFormatters:<TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
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
                      Container(
                        color: Colors.blue[50],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Manga status: '),
                            SizedBox(width: 5,),
                            DropdownButton(
                              value: statusesdropdownvalue,
                              items: statuses.map((String statuses){
                                return DropdownMenuItem(
                                  enabled: !readOnly,
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
                      SizedBox(height: 10),
                      Container(
                        color: Colors.blue[50],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('User status: '),
                            SizedBox(width: 5,),
                            DropdownButton(
                              value: userstatusesdropdownvalue,
                              items: userStatuses.map((String userStatuses){
                                return DropdownMenuItem(
                                  enabled: !readOnly,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.blue[50],
                              child: Text('Type:  ')
                              ),
                            Container(
                              color: Colors.blue[50],
                              child: DropdownButton(
                                value: typesdropdownvalue,
                                items: types.map((String types){
                                  return DropdownMenuItem(
                                    enabled: false,
                                    value: types,
                                    child: Text(types),
                                    );
                                }).toList(), 
                                onChanged: (String? newValue) {
                                  setState(() {
                                    typesdropdownvalue = newValue!;
                                  });
                                }),
                            ),
                            SizedBox(width: 10),
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.blue[50],
                                  child: TextFormField(
                                    readOnly: readOnly,
                                    initialValue: rating.toString(),
                                    inputFormatters:<TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLength: 2,
                                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      labelText: "Rating"
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) { //if value is null (! is null check)
                                        return 'Please enter the Overall Rating';
                                      } else if (int.parse(value) < 1 || int.parse(value) > 10) {
                                        return 'The rating must be between 1 and 10';
                                      }
                                      return null;
                                    },
                                  ),
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
                            new Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: readOnly,
                                  maxLines: null,
                                  initialValue: comments,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blue[50],
                                    labelText: "Comments"
                                  ),
                                ),
                              )
                            )
                          ]
                        )
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("No data available."),
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