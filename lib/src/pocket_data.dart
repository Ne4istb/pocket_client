library pocket_client.data;

import 'dart:convert';
import 'package:pocket_client/src/enums.dart';
import 'package:pocket_client/src/tag.dart';
import 'package:pocket_client/src/author.dart';
import 'package:pocket_client/src/video_data.dart';
import 'package:pocket_client/src/image_data.dart';

class PocketData {
  String itemId;
  String resolvedId;
  String givenUrl;
  String resolvedUrl;
  String givenTitle;
  String resolvedTitle;
  bool isFavorite;
  Status status;
  String excerpt;
  bool isArticle;
  bool isImage;
  bool isVideo;
  bool hasImages;
  bool hasVideos;
  int wordCount;
  List<Tag> tags;
  List<Author> authors;
  List<ImageData> images;
  List<VideoData> videos;

  PocketData(this.itemId,
      {this.resolvedId,
      this.givenUrl,
      this.resolvedUrl,
      this.givenTitle,
      this.resolvedTitle,
      this.isFavorite,
      this.status,
      this.excerpt,
      this.isArticle,
      this.isImage,
      this.isVideo,
      this.hasImages,
      this.hasVideos,
      this.wordCount,
      this.tags,
      this.authors,
      this.images,
      this.videos});

  PocketData.fromMap(Map<String, dynamic> map) {
    _initFromMap(map);
  }

  PocketData.fromJSON(String jsonString) {
    Map<String, dynamic> json = JSON.decode(jsonString) as Map<String, dynamic>;
    _initFromMap(json);
  }

  void _initFromMap(Map<String, dynamic> map) {
    itemId = map['item_id'];
    resolvedId = map['resolved_id'];
    givenUrl = map['given_url'];
    resolvedUrl = map['resolved_url'];
    givenTitle = map['given_title'];
    resolvedTitle = map['resolved_title'];
    isFavorite = map['favorite'] == '1';
    status = _convertToPocketStatus(map['status']);
    excerpt = map['excerpt'];
    isArticle = map['is_article'] == '1';
    isImage = map['has_image'] == '2';
    isVideo = map['has_video'] == '2';
    hasImages = map['has_image'] == '1';
    hasVideos = map['has_video'] == '1';
    wordCount = map['word_count'] != null ? int.parse(map['word_count']) : null;
    tags = _convertToTags(map['tags']);
    authors = _convertToAuthors(map['authors']);
    images = _convertToImages(map['images']);
    videos = _convertToVideos(map['videos']);
  }

  List<Tag> _convertToTags(dynamic data) {
    List<Tag> result = new List<Tag>();

    if (data != null && data.length > 0)
      data.forEach((_, Map<String, String> item) => result.add(new Tag.fromMap(item)));

    return result;
  }

  List<Author> _convertToAuthors(dynamic data) {
    List<Author> result = new List<Author>();

    if (data != null && data.length > 0)
      data.forEach((_, Map<String, String> item) => result.add(new Author.fromMap(item)));

    return result;
  }

  List<VideoData> _convertToVideos(dynamic data) {
    List<VideoData> result = new List<VideoData>();

    if (data != null && data.length > 0)
      data.forEach((_, Map<String, String> item) => result.add(new VideoData.fromMap(item)));

    return result;
  }

  List<ImageData> _convertToImages(dynamic data) {
    List<ImageData> result = new List<ImageData>();

    if (data != null && data.length > 0)
      data.forEach((_, Map<String, String> item) => result.add(new ImageData.fromMap(item)));

    return result;
  }

  Status _convertToPocketStatus(String statusString) {
    if (statusString == null || statusString.isEmpty) return null;

    switch (statusString) {
      case '0':
        return Status.normal;
      case '1':
        return Status.archived;
      case '2':
        return Status.toBeDeleted;
      default:
        throw new ArgumentError('Unknown pocket data status $statusString');
    }
  }
}
