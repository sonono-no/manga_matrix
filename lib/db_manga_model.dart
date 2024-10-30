/* db_manga_Model.dart
 * does: creates db model json framework for manga collection
 * calls: N/A
 * depends on: N/A
 */

//dart libraries
import 'dart:convert';

//projext files
import 'package:mongo_dart/mongo_dart.dart';

dbMangaModel dbMangaModelFromJson(String str) => dbMangaModel.fromJson(json.decode(str));

String dbMangaModelToJson(dbMangaModel data) => json.encode(data.toJson());

class dbMangaModel {
    ObjectId id;
    String mangaName;
    String publisher;
    String type;
    int totalChapters;
    String status;
    List<String> genreTags;
    List<String> altNames;

    dbMangaModel({
        required this.id,
        required this.mangaName,
        required this.publisher,
        required this.type,
        required this.totalChapters,
        required this.status,
        required this.genreTags,
        required this.altNames,
    });

    factory dbMangaModel.fromJson(Map<String, dynamic> json) => dbMangaModel(
        id: json["_id"],
        mangaName: json["manga name"],
        publisher: json["publisher"],
        type: json["type"],
        totalChapters: json["total chapters"],
        status: json["status"],
        genreTags: List<String>.from(json["genre tags"].map((x) => x)),
        altNames: List<String>.from(json["alt names"].map((y) => y)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "manga name": mangaName,
        "publisher": publisher,
        "type": type,
        "total chapters": totalChapters,
        "status": status,
        "genre tags": List<dynamic>.from(genreTags.map((x) => x)),
        "alt names": List<dynamic>.from(altNames.map((y)=> y)),
    };
}