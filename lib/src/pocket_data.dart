library pocket_client.data;

import 'dart:convert';
import 'package:pocket_client/src/pocket_status.dart';
import 'package:pocket_client/src/pocket_tag.dart';
import 'package:pocket_client/src/pocket_author.dart';
import 'package:pocket_client/src/pocket_video_data.dart';
import 'package:pocket_client/src/pocket_image_data.dart';

class PocketData {

	String itemId;
	String resolvedId;
	String givenUrl;
	String resolvedUrl;
	String givenTitle;
	String resolvedTitle;
	bool isFavorite;
	PocketStatus status;
	String excerpt;
	bool isArticle;
	bool isImage;
	bool isVideo;
	bool hasImages;
	bool hasVideos;
	int wordCount;
	List<PocketTag> tags;
	List<PocketAuthor> authors;
	List<PocketImageData> images;
	List<PocketVideoData> videos;


	PocketData(this.itemId, {this.resolvedId, this.givenUrl, this.resolvedUrl, this.givenTitle, this.resolvedTitle,
		this.isFavorite, this.status, this.excerpt, this.isArticle, this.isImage, this.isVideo, this.hasImages,
		this.hasVideos, this.wordCount, this.tags, this.authors, this.images, this.videos});

	PocketData.fromMap(Map map) {
		_initFromMap(map);
	}

	PocketData.fromJSON(String jsonString) {
		Map json = JSON.decode(jsonString);
		_initFromMap(json);
	}

	_initFromMap(map){
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

	List<PocketTag> _convertToTags(data) {
		List<PocketTag> result = [];

		data?.forEach((id, item) => result.add(new PocketTag.fromMap(item)));

		return result;
	}

	List<PocketAuthor> _convertToAuthors(data) {
		List<PocketAuthor> result = [];

		data?.forEach((id, item) => result.add(new PocketAuthor.fromMap(item)));

		return result;
	}

	List<PocketVideoData> _convertToVideos(data) {
		List<PocketVideoData> result = [];

		data?.forEach((id, item) => result.add(new PocketVideoData.fromMap(item)));

		return result;
	}

	List<PocketImageData> _convertToImages(data) {
		List<PocketImageData> result = [];

		data?.forEach((id, item) => result.add(new PocketImageData.fromMap(item)));

		return result;
	}


	PocketStatus _convertToPocketStatus(String statusString) {
		if (statusString == null || statusString.isEmpty)
			return null;

		switch (statusString) {
			case '0':
				return PocketStatus.normal;
			case '1':
				return PocketStatus.archived;
			case '2':
				return PocketStatus.toBeDeleted;
			default:
				throw new ArgumentError('Unknown pocket data status $statusString');
		}
	}
}