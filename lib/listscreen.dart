/* listscreen.dart
 * does: implements list screen of homepage tabs
 *       displays list of all manga for current user in card form
 *       takes snapshot of entry collection of db and displays some info
 * calls: mangainfopage.dart, mongodb.dart, mangainfopage.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';

//project files
import 'package:manga_matrix/db_entry_model.dart';
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/mangainfopage.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/girl_reading_sit.jpg"), fit: BoxFit.cover),
        ),
        child: SafeArea(
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
      )
    );
  }

  /* Function to display summarized manga info in card form
   * param: dbEntryModel data (formatted json data from database Entry collection)
   * return: Card widget
   */
  Widget displayEntryCard(dbEntryModel data){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return MangaInfoPage(entryData: data); //go to MangaInfoPage if card is clicked
        }));
      },
      child: 
        Card(
          color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [ //displays selected Manga entry info 
              Text("${data.mangaName}"),
              SizedBox(height: 5,),
              Text("Chapters read: ${data.chaptersRead}"),
              SizedBox(height: 5,),
              if(data.userStatus!='') //if userStatus field not empty
                Text("User status: ${data.userStatus}"),
              SizedBox(height: 5,),
              if(data.rating!=-1) //if rating field not empty
                Text("Rate: ${data.rating}/10"),
            ],
          ),
        ),
      )
    );
  }
}