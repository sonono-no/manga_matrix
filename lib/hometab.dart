/* searchscreen.dart
 * does: implements search screen of homepage tabs
 * calls: mangainfopage.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_matrix/dbHelper/constants.dart';

//project files
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/db_entry_model.dart';
import 'package:manga_matrix/db_manga_model.dart';


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

  String pubTemp = '';
  String commTemp = '';

class ManualEntryTab extends StatefulWidget {
  @override
  State<ManualEntryTab> createState() => _ManualEntryTabState();
}

class _ManualEntryTabState extends State<ManualEntryTab> {

  // text field controllers
  var mangaNameController = new TextEditingController();
  var publisherController = new TextEditingController();
  var chReadController = new TextEditingController();
  var chTotalController = new TextEditingController();
  var ratingController = new TextEditingController();
  var commentsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/narumi_reading_stand.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.white,
                      child: Text('Manual entry:', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20, 
                              color: Colors.black,
                            )
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.pink[50]), 
                        foregroundColor: WidgetStatePropertyAll(Colors.black)
                      ),
                      child: Text('Submit'),
                      onPressed: (){
                        bool valid = validateMangaEntry(
                          mangaNameController.text, chReadController.text, ratingController.text, commentsController.text, publisherController.text, chTotalController.text
                        );
                        if (valid) {
                          _insertEntry(mangaNameController.text, int.parse(chReadController.text), int.parse(ratingController.text), userstatusesdropdownvalue, commTemp);
                          _insertManga(mangaNameController.text, pubTemp, typesdropdownvalue, int.parse(chTotalController.text), statusesdropdownvalue);
                          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                            title: const Text('Entry submitted!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'), 
                                child: const Text('OK'),
                                )
                            ],
                          ));
                          mangaNameController.text = '';
                          chReadController.text = '';
                          chTotalController.text = '';
                          ratingController.text = '';
                          commentsController.text = '';
                        } else {
                          showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                            title: const Text('Invalid Entry'),
                            content: const Text('Required fields cannot be left empty.'),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text('* = Required', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  new Flexible(
                    child: TextFormField(
                      controller: mangaNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.pink[50],
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
                      controller: publisherController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.pink[50],
                        border: OutlineInputBorder(),
                        labelText: "Publisher"
                      ),
                    )
                  )
                ],),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        controller: chReadController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink[50],
                          border: OutlineInputBorder(),
                          labelText: "*Chapters"
                        ),
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      )
                    ),
                  Container(
                    color: Colors.white,
                    child: Text(' out of ', style: TextStyle(fontSize: 14))
                    ),
                  SizedBox(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        controller: chTotalController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink[50],
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
                child: Container(
                  width: 250,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('*Manga status: '),
                      SizedBox(width: 5,),
                      DropdownButton(
                        dropdownColor: Colors.pink[50],
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  width: 250,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
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
                          controller: ratingController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.pink[50],
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
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    new Flexible(
                      child: TextField(
                        controller: commentsController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink[50],
                          border: OutlineInputBorder(),
                          labelText: "Comments"
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      )
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(height: 500,)
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}

bool validateMangaEntry(String mangaName, String chRead, String rating, String comments, String publisher, String chTotal) {
  if (publisher.isNotEmpty) {
    pubTemp = publisher;
  }
  if (comments.isNotEmpty) {
    commTemp = comments;
  }

  if (mangaName.isEmpty || chRead.isEmpty || rating.isEmpty) {
    return false;
  }
  return true;
}

/* insert new entry
 * param: manga name, chapters read, rating, user status, comments
 */
Future<void> _insertEntry(String mangaName, int chRead, int rating, String userStatus, String comments) async {
  DateTime dateEntered = DateTime.now();
  List<String> customTags = [''];
  final data = dbEntryModel(username: CURR_USER, mangaName: mangaName, chaptersRead: chRead, userStatus: userStatus, rating: rating, dateEntered: dateEntered, customTags: customTags, comments: comments);
  var result = await MongoDatabase.insertEntry(data);
}

/* insert new manga
 * param: manga name, puplisher, manga type, total chapters, manga status
 */
Future<void> _insertManga(String mangaName, String publisher, String type, int chTotal, String status) async {
  final data = dbMangaModel(mangaName: mangaName, publisher: publisher, type: type, totalChapters: chTotal, status: status, genreTags: [''], altNames: ['']);
  var result = await MongoDatabase.insertManga(data);
}

class ListEntryTab extends StatefulWidget {
  @override
  State<ListEntryTab> createState() => _ListEntryTabState();
}

class _ListEntryTabState extends State<ListEntryTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text('Multi entry:', 
                        textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20, 
                            )
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.pink[50]), 
                        foregroundColor: WidgetStatePropertyAll(Colors.black)
                      ),
                      child: Text('Submit'),
                      onPressed: (){}
                      ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  new Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pink[50],
                          border: OutlineInputBorder(),
                          labelText: "List entry",
                          hintText: "Enter multiple manga names with chapter numbers in list form"
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      )
                    ),
                  ]
                ),
              ),
            ]
          )
        )
      );
  }
}