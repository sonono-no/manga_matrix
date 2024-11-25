/* searchscreen.dart
 * does: implements search screen of homepage tabs
 * calls: mangainfopage.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';

//project files
import 'package:manga_matrix/dbHelper/constants.dart';
import 'package:manga_matrix/dbHelper/mongodb.dart';
import 'package:manga_matrix/db_entry_model.dart';
import 'package:manga_matrix/mangainfopage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Flexible(
                      child: SearchAnchor(
                      builder: (context, controller) {
                      return SearchBar(
                        leading: Icon(Icons.search),
                          hintText: "Enter manga name to search by",
                        ); 
                      },
                      suggestionsBuilder: (context, controller) {
                        return [];
                        }
                      )
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}