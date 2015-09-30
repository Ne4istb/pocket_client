library pocket_client.image_data_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketImageDataTests {
	static run() {
		group('PocketImageData.fromJSON()', () {

			test('should create object from json', () {
				String json = '''
		    {
		      "item_id": "229279689",
		      "image_id": "1",
		      "src": "http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360",
		      "width": "420",
		      "height": "315",
		      "credit": "Jamie Squire\/Getty Images",
		      "caption": "cap"
		    }''';

				var actualData = new PocketImageData.fromJSON(json);

				expect(actualData.itemId, '229279689', reason: 'itemId');
				expect(actualData.imageId, '1', reason: 'imageId');
				expect(actualData.credit, 'Jamie Squire\/Getty Images', reason: 'credit');
				expect(actualData.caption, 'cap', reason: 'caption');
				expect(actualData.sourceUrl,'http:\/\/a.espncdn.com\/combiner\/i?img=\/photo\/2012\/0927\/grant_g_ryder_cr_640.jpg&w=640&h=360', reason: 'sourceUrl');
				expect(actualData.width, 420, reason: 'width');
				expect(actualData.height, 315, reason: 'height');
			});

			test('should parse width from json', () {

				var actualData = new PocketImageData.fromJSON('{"width": "123"}');
				expect(actualData.width, 123);

				actualData = new PocketImageData.fromJSON('{}');
				expect(actualData.width, null);
			});

			test('should parse height from json', () {

				var actualData = new PocketImageData.fromJSON('{"height": "123"}');
				expect(actualData.height, 123);

				actualData = new PocketImageData.fromJSON('{}');
				expect(actualData.height, null);
			});
		});
	}
}

void main() {
	PocketImageDataTests.run();
}