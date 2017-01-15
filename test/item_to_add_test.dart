library pocket_client.item_to_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class ItemToAddTests {
  static void run() {
    group('ItemToAdd.toMap()', () {
      const String url = 'http://test.com/';

      test('should return a json with url', () {
        ItemToAdd items = new ItemToAdd(url);
        expect(items.toMap(), {'url': 'http://test.com/'});

        String complexUrl = "http://test.com/deep?with='not encoded params&?'";
        items = new ItemToAdd(complexUrl);
        expect(items.toMap(), {'url': 'http://test.com/deep?with=\'not%20encoded%20params&?\''});
      });

      test('should return a json with url and title', () {
        ItemToAdd items = new ItemToAdd(url, title: 'Some mega test title &?#@!!');
        expect(items.toMap(), {'url': 'http://test.com/', 'title': 'Some%20mega%20test%20title%20%26%3F%23%40!!'});
      });

      test('should return a json with url and tags', () {
        ItemToAdd items = new ItemToAdd(url, tags: ['first', 'second', 'last']);
        expect(items.toMap(), {'url': 'http://test.com/', 'tags': 'first, second, last'});
      });

      test('should return json with all options', () {
        ItemToAdd items = new ItemToAdd(url)
          ..title = 'Test title'
          ..tweetId = '123456'
          ..tags = ['first', 'second', 'last'];

        Map<String, String> expected = {
          'url': 'http://test.com/',
          'title': 'Test%20title',
          'tweet_id': '123456',
          'tags': 'first, second, last'
        };

        expect(items.toMap(), expected);
      });
    });
  }
}

void main() {
  ItemToAddTests.run();
}
