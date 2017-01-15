library pocket_client.response_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketResponseTests {
	static void run() {
		group('PocketResponse.fromJSON()', () {
			test('should create object from json', () {
				String json = '''
		    {
				  "status": 1,
				  "complete": 0,
				  "list": {
				    "1052437824": {
				      "item_id": "1052437824",
				      "resolved_id": "1052437824"
				    }
				  },
				  "error": "Some error",
				  "since": 1443547195
				}''';
				
				PocketResponse actualData = new PocketResponse.fromJSON(json);

				expect(actualData.status, 1, reason: 'status');
				expect(actualData.complete, 0, reason: 'complete');
				expect(actualData.error, 'Some error', reason: 'error');
				expect(actualData.since, new DateTime.fromMillisecondsSinceEpoch(1443547195), reason: 'since');

				expect(actualData.items.length, 1, reason: 'list length');

				expect(actualData.items['1052437824'].itemId, '1052437824', reason: 'list item 0');
				expect(actualData.items['1052437824'].resolvedId, '1052437824', reason: 'list item 0');
			});

			test('should parse since from json', () {
				
				PocketResponse actualData = new PocketResponse.fromJSON('{}');
				expect(actualData.since, null);

				actualData = new PocketResponse.fromJSON('{"since": 1443547100}');
				expect(actualData.since, new DateTime.fromMillisecondsSinceEpoch(1443547100));
			});

			test('should parse list from json', () {
				
				PocketResponse actualData = new PocketResponse.fromJSON('{}');
				expect(actualData.items, {});

				actualData = new PocketResponse.fromJSON('{"list":[]}');
				expect(actualData.items, {});

				String json = '''
				{
					"list": {
				    "1052437824": {
				      "item_id": "1052437824",
				      "resolved_id": "1052437824"
				    },
				    "1052437822": {
				      "item_id": "1052437822",
				      "resolved_id": "1052437858"
				    }
					 }
				}
				''';

				actualData = new PocketResponse.fromJSON(json);

				expect(actualData.items.length, 2, reason: 'list length');

				expect(actualData.items['1052437824'].itemId, '1052437824', reason: 'list item 0');
				expect(actualData.items['1052437824'].resolvedId, '1052437824', reason: 'list item 0');

				expect(actualData.items['1052437822'].itemId, '1052437822', reason: 'list item 1');
				expect(actualData.items['1052437822'].resolvedId, '1052437858', reason: 'list item 1');
			});
		});
	}
}

void main() {
	PocketResponseTests.run();
}