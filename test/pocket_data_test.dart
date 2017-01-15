library pocket_client.data_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketDataTests {
	static void run() {
		group('PocketData.fromJSON()', () {
			test('should create object from json', () {
				String json = '''
		    {
				  "item_id": "229279689",
				  "resolved_id": "229279689",
				  "given_url": "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
				  "given_title": "The Massive Ryder Cup Preview - The Triangle Blog - Grantland",
				  "favorite": "0",
				  "status": "0",
				  "resolved_title": "The Massive Ryder Cup Preview",
				  "resolved_url": "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview/resolved",
				  "excerpt": "The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel, and golf fans can probably guess most of them.",
				  "is_article": "1",
				  "has_video": "1",
				  "has_image": "1",
				  "word_count": "3197",
				  "tags":{
				    "digest":{"item_id":"1052437824","tag":"digest"},
				    "es6":{"item_id":"1052437825","tag":"es6"}
				  },
				  "images": {
				    "1": {
				      "item_id": "229279689",
				      "image_id": "1",
				      "src": "http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360",
				      "width": "420",
				      "height": "315",
				      "credit": "Jamie Squire\/Getty Images",
				      "caption": "cap"
				    }
				  },
				  "videos": {
				    "1": {
				      "item_id": "229279689",
				      "video_id": "1",
				      "src": "http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0",
				      "width": "420",
				      "height": "315",
				      "type": "1",
				      "vid": "Er34PbFkVGk"
				    }
				  },
	        "authors": {
					  "33265953": {
					    "item_id": "1033645339",
					    "author_id": "33265953",
					    "name": "zsolt-nagy",
					    "url": "http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/"
					  }
					}
				}''';
				
				PocketData actualData = new PocketData.fromJSON(json);

				expect(actualData.itemId, '229279689', reason: 'itemId');
				expect(actualData.resolvedId, '229279689', reason: 'resolvedId');
				expect(actualData.givenUrl, 'http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview', reason: 'givenUrl');
				expect(actualData.resolvedUrl,'http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview\/resolved', reason: 'resolvedUrl');
				expect(actualData.givenTitle, 'The Massive Ryder Cup Preview - The Triangle Blog - Grantland', reason: 'givenTitle');
				expect(actualData.resolvedTitle, 'The Massive Ryder Cup Preview', reason: 'resolvedTitle');
				expect(actualData.isFavorite, false, reason: 'isFavorite');
				expect(actualData.excerpt, 'The list of things I love about the Ryder Cup is so long that it could fill a (tedious) novel, and golf fans can probably guess most of them.',	reason: 'excerpt');
				expect(actualData.isArticle, true, reason: 'isArticle');
				expect(actualData.isImage, false, reason: 'isImage');
				expect(actualData.isVideo, false, reason: 'isVideo');
				expect(actualData.hasVideos, true, reason: 'hasVideos');
				expect(actualData.hasImages, true, reason: 'hasImages');
				expect(actualData.wordCount, 3197, reason: 'wordCount');

				expect(actualData.tags.length, 2, reason: 'tags');

				expect(actualData.tags[0].itemId, '1052437824', reason: 'tags digest id');
				expect(actualData.tags[0].tag, 'digest', reason: 'tags digest tag');

				expect(actualData.tags[1].itemId, '1052437825', reason: 'tags es6 id');
				expect(actualData.tags[1].tag, 'es6', reason: 'tags es6 tag');

				expect(actualData.authors.length, 1, reason: 'authors');
				expect(actualData.authors[0].itemId, '1033645339', reason: 'authors itemId');
				expect(actualData.authors[0].authorId, '33265953', reason: 'authors authorId');
				expect(actualData.authors[0].name, 'zsolt-nagy', reason: 'authors name id');
				expect(actualData.authors[0].url, 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/', reason: 'authors url id');

				expect(actualData.videos.length, 1, reason: 'videos');
				expect(actualData.videos[0].itemId, '229279689', reason: 'videos itemId');
				expect(actualData.videos[0].videoId, '1', reason: 'videos videoId');
				expect(actualData.videos[0].vId, 'Er34PbFkVGk', reason: 'videos vid');
				expect(actualData.videos[0].sourceUrl, 'http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0', reason: 'videos sourceUrl');
				expect(actualData.videos[0].type, 1, reason: 'videos type');
				expect(actualData.videos[0].width, 420, reason: 'videos width');
				expect(actualData.videos[0].height, 315, reason: 'videos height');

				expect(actualData.images.length, 1, reason: 'images');
				expect(actualData.images[0].itemId, '229279689', reason: 'images itemId');
				expect(actualData.images[0].imageId, '1', reason: 'images imageId');
				expect(actualData.images[0].sourceUrl, 'http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360', reason: 'images sourceUrl');
				expect(actualData.images[0].caption, 'cap', reason: 'images caption');
				expect(actualData.images[0].credit, 'Jamie Squire\/Getty Images', reason: 'images credit');
				expect(actualData.images[0].width, 420, reason: 'images width');
				expect(actualData.images[0].height, 315, reason: 'images height');
			});

			test('should parse favorite from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"favorite": "1"}');
				expect(actualData.isFavorite, true);

				actualData = new PocketData.fromJSON('{"favorite": "0"}');
				expect(actualData.isFavorite, false);
			});

			test('should parse tags from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{}');
				expect(actualData.tags, []);

				actualData = new PocketData.fromJSON('{"tags": []}');
				expect(actualData.tags, []);

				String json = '''
				{
				"tags":{
				    "digest":{"item_id":"1052437824","tag":"digest"},
				    "es6":{"item_id":"1052437825","tag":"es6"}
				  }
				}
				''';

				actualData = new PocketData.fromJSON(json);

				expect(actualData.tags.length, 2, reason: 'tags');

				expect(actualData.tags[0].itemId, '1052437824', reason: 'tags digest id');
				expect(actualData.tags[0].tag, 'digest', reason: 'tags digest tag');

				expect(actualData.tags[1].itemId, '1052437825', reason: 'tags es6 id');
				expect(actualData.tags[1].tag, 'es6', reason: 'tags es6 tag');
			});

			test('should parse authors from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{}');
				expect(actualData.authors, []);

				actualData = new PocketData.fromJSON('{"authors": []}');
				expect(actualData.authors, []);

				String json = '''
				{
					"authors": {
						  "33265953": {
						    "item_id": "1033645339",
						    "author_id": "33265953",
						    "name": "zsolt-nagy",
						    "url": "http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/"
						  }
						}
				}
				''';

				actualData = new PocketData.fromJSON(json);

				expect(actualData.authors.length, 1, reason: 'authors');
				expect(actualData.authors[0].itemId, '1033645339', reason: 'authors itemId');
				expect(actualData.authors[0].authorId, '33265953', reason: 'authors authorId');
				expect(actualData.authors[0].name, 'zsolt-nagy', reason: 'authors name id');
				expect(actualData.authors[0].url, 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/', reason: 'authors url id');
			});

			test('should parse videos from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{}');
				expect(actualData.videos, []);

				actualData = new PocketData.fromJSON('{"videos": []}');
				expect(actualData.videos, []);

				String json = '''
				{
					"videos": {
				    "1": {
				      "item_id": "229279689",
				      "video_id": "1",
				      "src": "http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0",
				      "width": "420",
				      "height": "315",
				      "type": "1",
				      "vid": "Er34PbFkVGk"
				    }
				  }
				}
				''';

				actualData = new PocketData.fromJSON(json);

				expect(actualData.videos.length, 1, reason: 'videos');
				expect(actualData.videos[0].itemId, '229279689', reason: 'videos itemId');
				expect(actualData.videos[0].videoId, '1', reason: 'videos videoId');
				expect(actualData.videos[0].vId, 'Er34PbFkVGk', reason: 'videos vid');
				expect(actualData.videos[0].sourceUrl, 'http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0', reason: 'videos sourceUrl');
				expect(actualData.videos[0].type, 1, reason: 'videos type');
				expect(actualData.videos[0].width, 420, reason: 'videos width');
				expect(actualData.videos[0].height, 315, reason: 'videos height');
			});

			test('should parse images from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{}');
				expect(actualData.images, []);

				actualData = new PocketData.fromJSON('{"images": []}');
				expect(actualData.images, []);

				String json = '''
				{
					"images": {
				    "1": {
				      "item_id": "229279689",
				      "image_id": "1",
				      "src": "http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360",
				      "width": "420",
				      "height": "315",
				      "credit": "Jamie Squire\/Getty Images",
				      "caption": "cap"
				    }
				  }
				}
				''';

				actualData = new PocketData.fromJSON(json);

				expect(actualData.images.length, 1, reason: 'images');
				expect(actualData.images[0].itemId, '229279689', reason: 'images itemId');
				expect(actualData.images[0].imageId, '1', reason: 'images imageId');
				expect(actualData.images[0].sourceUrl, 'http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360', reason: 'images sourceUrl');
				expect(actualData.images[0].caption, 'cap', reason: 'images caption');
				expect(actualData.images[0].credit, 'Jamie Squire\/Getty Images', reason: 'images credit');
				expect(actualData.images[0].width, 420, reason: 'images width');
				expect(actualData.images[0].height, 315, reason: 'images height');
			});

			test('should parse status from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"status": "0"}');
				expect(actualData.status, Status.normal);

				actualData = new PocketData.fromJSON('{"status": "1"}');
				expect(actualData.status, Status.archived);

				actualData = new PocketData.fromJSON('{"status": "2"}');
				expect(actualData.status, Status.toBeDeleted);

				actualData = new PocketData.fromJSON('{"status": ""}');
				expect(actualData.status, null);

				expect(() => new PocketData.fromJSON('{"status": "3"}'), throwsArgumentError);
			});

			test('should parse is_article from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"is_article": "1"}');
				expect(actualData.isArticle, true);

				actualData = new PocketData.fromJSON('{"is_article": "0"}');
				expect(actualData.isArticle, false);
			});

			test('should parse has_image from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"has_image": "0"}');
				expect(actualData.isImage, false);
				expect(actualData.hasImages, false);

				actualData = new PocketData.fromJSON('{"has_image": "1"}');
				expect(actualData.isImage, false);
				expect(actualData.hasImages, true);

				actualData = new PocketData.fromJSON('{"has_image": "2"}');
				expect(actualData.isImage, true);
				expect(actualData.hasImages, false);
			});

			test('should parse has_video from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"has_video": "0"}');
				expect(actualData.isVideo, false);
				expect(actualData.hasVideos, false);

				actualData = new PocketData.fromJSON('{"has_video": "1"}');
				expect(actualData.isVideo, false);
				expect(actualData.hasVideos, true);

				actualData = new PocketData.fromJSON('{"has_video": "2"}');
				expect(actualData.isVideo, true);
				expect(actualData.hasVideos, false);
			});

			test('should parse word_count from json', () {
				
				PocketData actualData = new PocketData.fromJSON('{"word_count": "123"}');
				expect(actualData.wordCount, 123);

				actualData = new PocketData.fromJSON('{}');
				expect(actualData.wordCount, null);
			});
		});
	}
}

void main() {
	PocketDataTests.run();
}