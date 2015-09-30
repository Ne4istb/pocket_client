library pocket_client.retreive_options_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketRetrieveOptionsTests {
  static run() {
    group('PocketRetrieveOptions.toMap()', () {
      test('should return empty json', () {
        var options = new PocketRetrieveOptions();

        expect(options.toMap(), {});
      });

      test('should return a json with state', () {
        var options = new PocketRetrieveOptions(state: PocketState.Unread);

        expect(options.toMap(), {"state":"unread"});

        options.state = PocketState.Archive;
        expect(options.toMap(), {"state":"archive"});

        options.state = PocketState.All;
        expect(options.toMap(), {"state":"all"});
      });

      test('should return a json with favorite', () {
        var options = new PocketRetrieveOptions(isFavorite: true);
        expect(options.toMap(), {"favorite":"1"});

        options.isFavorite = false;
        expect(options.toMap(), {"favorite":"0"});
      });

      test('should return a json with tag', () {
        var options = new PocketRetrieveOptions(tag: 'some_tag');
        expect(options.toMap(), {"tag":"some_tag"});
      });

      test('should return a json with content type', () {
        var options = new PocketRetrieveOptions(contentType: PocketContentType.Article);
        expect(options.toMap(), {"contentType":"article"});

        options.contentType = PocketContentType.Video;
        expect(options.toMap(), {"contentType":"video"});

        options.contentType = PocketContentType.Image;
        expect(options.toMap(), {"contentType":"image"});
      });

      test('should return a json with sort type', () {
        var options = new PocketRetrieveOptions(sortType: PocketSortType.Newest);
        expect(options.toMap(), {"sort":"newest"});

        options.sortType = PocketSortType.Oldest;
        expect(options.toMap(), {"sort":"oldest"});

        options.sortType = PocketSortType.Site;
        expect(options.toMap(), {"sort":"site"});

        options.sortType = PocketSortType.Title;
        expect(options.toMap(), {"sort":"title"});
      });

      test('should return a json with detail type', () {
        var options = new PocketRetrieveOptions(detailType: PocketDetailType.Simple);
        expect(options.toMap(), {"detailType":"simple"});

        options.detailType = PocketDetailType.Complete;
        expect(options.toMap(), {"detailType":"complete"});
      });

      test('should return a json with search', () {
        var options = new PocketRetrieveOptions(search: 'some_search_pattern');
        expect(options.toMap(), {"search":"some_search_pattern"});
      });

      test('should return a json with domain', () {
        var options = new PocketRetrieveOptions(domain: 'http://domain.test');
        expect(options.toMap(), {"domain":"http://domain.test"});
      });

      test('should return a json with count', () {
        var options = new PocketRetrieveOptions(count: 10);
        expect(options.toMap(), {"count":"10"});
      });

      test('should return a json with offset', () {
        var options = new PocketRetrieveOptions(offset: 10);
        expect(options.toMap(), {});

        options.count = 50;
        expect(options.toMap(), {"count":"50", "offset":"10"});
      });

      test('should return a json with since', () {
        var options = new PocketRetrieveOptions(since: new DateTime(2015, 10, 20));
        expect(options.toMap(), {"since":"1445288400000"});
      });

      test('should return json with all options', () {
        var options = new PocketRetrieveOptions()
          ..since = new DateTime(2015, 5, 4)
          ..contentType = PocketContentType.Video
          ..count = 100
          ..offset = 10
          ..detailType = PocketDetailType.Complete
          ..domain = 'http://domain.test'
          ..search = 'Some search query'
          ..isFavorite = true
          ..sortType = PocketSortType.Site
          ..state = PocketState.Archive
          ..tag = 'cats';

        var expected = {
          'state':'archive',
          'favorite':'1',
          'tag':'cats',
          'contentType':'video',
          'sort':'site',
          'detailType':'complete',
          'search':'Some search query',
          'domain':'http://domain.test',
          'count':'100',
          'offset':'10',
          'since':'1430686800000'
        };

        expect(options.toMap(), expected);
      });
    });
  }
}

void main() {
	PocketRetrieveOptionsTests.run();
}