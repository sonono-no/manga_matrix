import 'dart:developer';

import 'package:manga_matrix/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = inspect(db.serverStatus());
    print(status);
    var collection = db.collection(COLLECTION_NAME);
    print(await collection.find().toList());
  }
}