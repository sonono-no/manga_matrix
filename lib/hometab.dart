/* searchscreen.dart
 * does: implements search screen of homepage tabs
 * calls: mangainfopage.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//project files


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

class ManualEntryTab extends StatefulWidget {
  @override
  State<ManualEntryTab> createState() => _ManualEntryTabState();
}

class _ManualEntryTabState extends State<ManualEntryTab> {

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
                mainAxisAlignment: MainAxisAlignment.center,
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
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]), 
                      foregroundColor: WidgetStatePropertyAll(Colors.pink[100])
                    ),
                    child: Text('Submit'),
                    onPressed: (){}
                    ),
                )
              ],)
            ],
          ),
        ),
      )
    );
  }
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
                mainAxisAlignment: MainAxisAlignment.center,
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