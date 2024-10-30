/* searchscreen.dart
 * does: implements search screen of homepage tabs
 * calls: mangainfopage.dart
 * depends on: homepage.dart
 */

//flutter libraries
import 'package:flutter/material.dart';

//project files

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
    );
  }
}