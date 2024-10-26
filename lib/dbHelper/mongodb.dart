import 'dart:developer';

import 'package:manga_matrix/dbHelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = inspect(db.serverStatus());
    print(status);
    var userCollection = db.collection(USER_COLLECTION);
    /* EXAMPLE INSERT
    await userCollection.insertOne({
      "username": "tester",
      "password": "tester",
      "email": "testeremail@email.com"
    });
    */
    print(await userCollection.find().toList());
  }
}