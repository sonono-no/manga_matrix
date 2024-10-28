// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    ObjectId id;
    String username;
    String mangaName;
    int chaptersRead;
    String userStatus;
    int rating;
    DateTime dateEntered;
    List<String> customTags;
    String comments;

    MongoDbModel({
        required this.id,
        required this.username,
        required this.mangaName,
        required this.chaptersRead,
        required this.userStatus,
        required this.rating,
        required this.dateEntered,
        required this.customTags,
        required this.comments,
    });

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        username: json["username"],
        mangaName: json["manga name"],
        chaptersRead: json["chapters read"],
        userStatus: json["user status"],
        rating: json["rating"],
        dateEntered: json["date entered"],
        customTags: List<String>.from(json["custom tags"].map((x) => x)),
        comments: json["comments"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "username": username,
        "manga name": mangaName,
        "chapters read": chaptersRead,
        "user status": userStatus,
        "rating": rating,
        "date entered": dateEntered,
        "custom tags": List<dynamic>.from(customTags.map((x) => x)),
        "comments": comments,
    };
}