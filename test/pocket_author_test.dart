library pocket_client.author_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketAuthorTests {

  static run() {
    test('PocketAuthor. Should convert json string to pocket tag data', () {

      const json = '''
      {
        "item_id": "1033645339",
        "author_id": "33265953",
        "name": "zsolt-nagy",
        "url": "http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/"
      }
      ''';

      var actualData = new PocketAuthor.fromJSON(json);

      expect(actualData.itemId, '1033645339');
      expect(actualData.authorId, '33265953');
      expect(actualData.name, 'zsolt-nagy');
      expect(actualData.url, 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/');
    });
  }
}

void main() {
	PocketAuthorTests.run();
}