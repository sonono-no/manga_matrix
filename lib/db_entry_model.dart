/* db_entry_model.dart
 * does: creates db model json framework for entry collection
 * calls: N/A
 * depends on: N/A
 */

//dart libraries
import 'dart:convert';

//project files

dbEntryModel dbEntryModelFromJson(String str) => dbEntryModel.fromJson(json.decode(str));

String dbEntryModelToJson(dbEntryModel data) => json.encode(data.toJson());

class dbEntryModel {
    String username;
    String mangaName;
    int chaptersRead;
    String userStatus;
    int rating;
    DateTime dateEntered;
    List<String> customTags;
    String comments;

    dbEntryModel({
        required this.username,
        required this.mangaName,
        required this.chaptersRead,
        required this.userStatus,
        required this.rating,
        required this.dateEntered,
        required this.customTags,
        required this.comments,
    });

    factory dbEntryModel.fromJson(Map<String, dynamic> json) => dbEntryModel(
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