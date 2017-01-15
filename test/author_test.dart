library pocket_client.author_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class AuthorTests {
  static void run() {
    test('Author. Should convert json string to pocket tag data', () {
      const String json = '''
      {
        "item_id": "1033645339",
        "author_id": "33265953",
        "name": "zsolt-nagy",
        "url": "http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/"
      }
      ''';

      Author actualData = new Author.fromJSON(json);

      expect(actualData.itemId, '1033645339');
      expect(actualData.authorId, '33265953');
      expect(actualData.name, 'zsolt-nagy');
      expect(actualData.url, 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/');
    });

    test('Author. Should put correct data via constructor', () {
      Author actualData =
          new Author('1033645339', '33265953', 'zsolt-nagy', url: 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/');

      expect(actualData.itemId, '1033645339');
      expect(actualData.authorId, '33265953');
      expect(actualData.name, 'zsolt-nagy');
      expect(actualData.url, 'http:\/\/www.zsoltnagy.eu\/author\/zsolt555\/');
    });
  }
}

void main() {
  AuthorTests.run();
}
