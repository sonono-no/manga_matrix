/* mongodb.dart
 * does: connects to database
 *       has functions for database interactions
 *       prints db status on connection startup
 * calls: N/A
 * depends on: N/A
 */

//dart libraries
import 'dart:developer';

//project files
import 'package:manga_matrix/dbHelper/constants.dart';
import 'package:manga_matrix/db_user_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, mangaCollection, entryCollection, tagsCollection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = inspect(db.serverStatus());
    print(status);
    userCollection = db.collection(USER_COLLECTION);
    mangaCollection = db.collection(MANGA_COLLECTION);
    entryCollection = db.collection(ENTRY_COLLECTION);
    tagsCollection = db.collection(TAGS_COLLECTION);
    
    /* EXAMPLE INSERT
    await userCollection.insertOne({
      "username": "tester",
      "password": "tester",
      "email": "testeremail@email.com"
    });
    */
    print(await userCollection.find().toList());
  }

  static Future<String> insertUser(dbUserModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Error creating new user";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String,dynamic>>> getMangaData() async {
    final arrData = await mangaCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String,dynamic>>> getEntryData() async {
    final arrData = await entryCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String,dynamic>>> getUserData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String,dynamic>>> getTagsData() async {
    final arrData = await tagsCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String,dynamic>>> queryMangaDataEq(fieldName, value) async {
    final data = await mangaCollection.find(where.eq(fieldName, value)).toList();
    return data;
  }

  static Future<List<Map<String,dynamic>>> queryUserDataEq(fieldName, value) async {
    final data = await userCollection.find(where.eq(fieldName, value)).toList();
    return data;
  }
}