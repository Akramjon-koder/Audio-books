class AudioModel {
  AudioModel({
    required this.id,
    this.author = '',
    this.title = '',
    required this.image,
    required this.audio,
    this.position = 0,
    this.isLoaded = false,
  });

  String id;
  String title;
  String author;
  String image;
  String audio;
  bool isLoaded;

  int position;// milliseconds

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
    id: json["id"].toString(),
    author: json["author"].toString(),
    title: json["title"].toString(),
    image: json["image"].toString(),
    audio: json["audio"].toString(),
    position: json["position"] is int ? json["position"] : 0,
    isLoaded: json["isLoaded"] is bool ? json["isLoaded"] : false,
  );

  AudioModel copyWith({
    String? id,
    String? title,
    String? author,
    String? image,
    String? audio,
    int? position,
    bool? isLoaded,
  }) => AudioModel(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author ?? this.author,
    image: image ?? this.image,
    audio: audio ?? this.audio,
    position: position ?? this.position,
    isLoaded: isLoaded ?? this.isLoaded,
  );
}
