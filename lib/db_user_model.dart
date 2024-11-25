/* db_user_Model.dart
 * does: creates db model json framework for user collection
 * calls: N/A
 * depends on: N/A
 */

//dart libraries
import 'dart:convert';

//projext files

dbUserModel dbUserModelFromJson(String str) => dbUserModel.fromJson(json.decode(str));

String dbUserModelToJson(dbUserModel data) => json.encode(data.toJson());

class dbUserModel {
    String username;
    String password;
    String email;

    dbUserModel({
        required this.username,
        required this.password,
        required this.email,
    });

    factory dbUserModel.fromJson(Map<String, dynamic> json) => dbUserModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
    };
}