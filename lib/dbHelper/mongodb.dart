import 'dart:developer';

import 'package:manga_matrix/dbHelper/constants.dart';
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

  static Future<List<Map<String,dynamic>>> queryMangaDataEq(fieldname, value) async {
    final data = await mangaCollection.find(where.eq(fieldname, value)).toList();
    return data;
  }
}