import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject{
  BookModel({
    required this.id,
    this.author = '',
    this.title = '',
    this.imageUrl = '',
    required this.image,
    required this.audio,
    this.position = 0,
    this.isLoaded = false,
    this.progressNotifier,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String author;

  @HiveField(3)
  String image;

  @HiveField(4)
  String audio;

  @HiveField(5)
  bool isLoaded;

  @HiveField(6)
  String imageUrl;

  LoadNotifier? progressNotifier;

  @HiveField(7)
  int position;// milliseconds

  factory BookModel.fromJson(Map<dynamic, dynamic> json) => BookModel(
    id: json["id"].toString(),
    author: json["author"].toString(),
    title: json["title"].toString(),
    image: json["image"].toString(),
    imageUrl: json["imageUrl"] ?? json["image"].toString(),
    audio: json["audio"].toString(),
    position: json["position"] is int ? json["position"] : 0,
    isLoaded: json["isLoaded"] is bool ? json["isLoaded"] : false,
  );

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? image,
    String? imageUrl,
    String? audio,
    int? position,
    bool? isLoaded,
    LoadNotifier? progressNotifier,
  }) => BookModel(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author ?? this.author,
    image: image ?? this.image,
    imageUrl: imageUrl ?? this.imageUrl,
    audio: audio ?? this.audio,
    position: position ?? this.position,
    isLoaded: isLoaded ?? this.isLoaded,
    progressNotifier: progressNotifier ?? this.progressNotifier,
  );
  
  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "title": title,
    "image": image,
    "imageUrl": imageUrl,
    "audio": audio,
    "position": position,
    "isLoaded": isLoaded,
  };
}

typedef LoadNotifier = ValueNotifier<double?>;

class BookAdapter extends TypeAdapter<BookModel> {
  @override
  final typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    return BookModel.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, BookModel book) {
    writer.write(book.toJson());
  }
}