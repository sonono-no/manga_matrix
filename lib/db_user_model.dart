/* db_user_Model.dart
 * does: creates db model json framework for manga collection
 * calls: N/A
 * depends on: N/A
 */

//dart libraries
import 'dart:convert';

//projext files
import 'package:mongo_dart/mongo_dart.dart';

dbUserModel dbUserModelFromJson(String str) => dbUserModel.fromJson(json.decode(str));

String dbUserModelToJson(dbUserModel data) => json.encode(data.toJson());

class dbUserModel {
    ObjectId id;
    String username;
    String password;
    String email;

    dbUserModel({
        required this.id,
        required this.username,
        required this.password,
        required this.email,
    });

    factory dbUserModel.fromJson(Map<String, dynamic> json) => dbUserModel(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "username": username,
        "password": password,
        "email": email,
    };
}