library pocket_client.video_data_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class VideoDataTests {
	static void run() {
		group('VideoData.fromJSON()', () {
			test('should create object from json', () {
				String json = '''
		    {
		      "item_id": "229279689",
		      "video_id": "1",
		      "src": "http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0",
		      "width": "420",
		      "height": "315",
		      "type": "1",
		      "vid": "Er34PbFkVGk"
				}''';

				VideoData actualData = new VideoData.fromJSON(json);

				expect(actualData.itemId, '229279689', reason: 'itemId');
				expect(actualData.videoId, '1', reason: 'videoId');
				expect(actualData.vId, 'Er34PbFkVGk', reason: 'vId');
				expect(actualData.sourceUrl,'http:\/\/www.youtube.com\/v\/Er34PbFkVGk?version=3&hl=en_US&rel=0', reason: 'sourceUrl');
				expect(actualData.type, 1, reason: 'type');
				expect(actualData.width, 420, reason: 'width');
				expect(actualData.height, 315, reason: 'height');
			});

			test('should parse type from json', () {

				VideoData actualData = new VideoData.fromJSON('{"type": "123"}');
				expect(actualData.type, 123);

				actualData = new VideoData.fromJSON('{}');
				expect(actualData.type, null);
			});

			test('should parse width from json', () {

				VideoData actualData = new VideoData.fromJSON('{"width": "123"}');
				expect(actualData.width, 123);

				actualData = new VideoData.fromJSON('{}');
				expect(actualData.width, null);
			});

			test('should parse height from json', () {

				VideoData actualData = new VideoData.fromJSON('{"height": "123"}');
				expect(actualData.height, 123);

				actualData = new VideoData.fromJSON('{}');
				expect(actualData.height, null);
			});
		});
	}
}

void main() {
	VideoDataTests.run();
}