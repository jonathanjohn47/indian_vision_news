// To parse this JSON data, do
//
//     final articlesFromRtdb = articlesFromRtdbFromJson(jsonString);

import 'dart:convert';

List<ArticlesFromRtdb> articlesFromRtdbFromJson(String str) => List<ArticlesFromRtdb>.from(json.decode(str).map((x) => ArticlesFromRtdb.fromJson(x)));

String articlesFromRtdbToJson(List<ArticlesFromRtdb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticlesFromRtdb {
  String title;
  String content;
  String url;
  int timestamp;
  List<Category> category;
  PublisherName publisherName;
  String thumbnailImageUrl;

  ArticlesFromRtdb({
    required this.title,
    required this.content,
    required this.url,
    required this.timestamp,
    required this.category,
    required this.publisherName,
    required this.thumbnailImageUrl,
  });

  ArticlesFromRtdb copyWith({
    String? title,
    String? content,
    String? url,
    int? timestamp,
    List<Category>? category,
    PublisherName? publisherName,
    String? thumbnailImageUrl,
  }) =>
      ArticlesFromRtdb(
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
        category: category ?? this.category,
        publisherName: publisherName ?? this.publisherName,
        thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      );

  factory ArticlesFromRtdb.fromJson(Map<String, dynamic> json) => ArticlesFromRtdb(
    title: json["title"],
    content: json["content"],
    url: json["url"],
    timestamp: json["timestamp"],
    category: List<Category>.from(json["category"].map((x) => categoryValues.map[x]!)),
    publisherName: publisherNameValues.map[json["publisher_name"]]!,
    thumbnailImageUrl: json["thumbnail_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "url": url,
    "timestamp": timestamp,
    "category": List<dynamic>.from(category.map((x) => categoryValues.reverse[x])),
    "publisher_name": publisherNameValues.reverse[publisherName],
    "thumbnail_image_url": thumbnailImageUrl,
  };
}

enum Category {
  EDUCATION,
  HEALTHCARE,
  JAMMU,
  KASHMIR,
  NATIONAL,
  SPORTS
}

final categoryValues = EnumValues({
  "Education": Category.EDUCATION,
  "Healthcare": Category.HEALTHCARE,
  "Jammu": Category.JAMMU,
  "Kashmir": Category.KASHMIR,
  "National": Category.NATIONAL,
  "Sports": Category.SPORTS
});

enum PublisherName {
  INDIAN_VISION_NEWS
}

final publisherNameValues = EnumValues({
  "Indian Vision News": PublisherName.INDIAN_VISION_NEWS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
