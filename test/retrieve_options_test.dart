library pocket_client.retreive_options_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class RetrieveOptionsTests {
  static void run() {
    group('RetrieveOptions.toMap()', () {
      test('should return empty json', () {
        RetrieveOptions options = new RetrieveOptions();

        expect(options.toMap(), {});
      });

      test('should return a json with state', () {
        RetrieveOptions options = new RetrieveOptions(state: State.unread);

        expect(options.toMap(), {"state":"unread"});

        options.state = State.archive;
        expect(options.toMap(), {"state":"archive"});

        options.state = State.all;
        expect(options.toMap(), {"state":"all"});
      });

      test('should return a json with favorite', () {
        RetrieveOptions options = new RetrieveOptions(isFavorite: true);
        expect(options.toMap(), {"favorite":"1"});

        options.isFavorite = false;
        expect(options.toMap(), {"favorite":"0"});
      });

      test('should return a json with tag', () {
        RetrieveOptions options = new RetrieveOptions(tag: 'some_tag');
        expect(options.toMap(), {"tag":"some_tag"});
      });

      test('should return a json with content type', () {
        RetrieveOptions options = new RetrieveOptions(contentType: ContentType.article);
        expect(options.toMap(), {"contentType":"article"});

        options.contentType = ContentType.video;
        expect(options.toMap(), {"contentType":"video"});

        options.contentType = ContentType.image;
        expect(options.toMap(), {"contentType":"image"});
      });

      test('should return a json with sort type', () {
        RetrieveOptions options = new RetrieveOptions(sortType: SortType.newest);
        expect(options.toMap(), {"sort":"newest"});

        options.sortType = SortType.oldest;
        expect(options.toMap(), {"sort":"oldest"});

        options.sortType = SortType.site;
        expect(options.toMap(), {"sort":"site"});

        options.sortType = SortType.title;
        expect(options.toMap(), {"sort":"title"});
      });

      test('should return a json with detail type', () {
        RetrieveOptions options = new RetrieveOptions(detailType: DetailType.simple);
        expect(options.toMap(), {"detailType":"simple"});

        options.detailType = DetailType.complete;
        expect(options.toMap(), {"detailType":"complete"});
      });

      test('should return a json with search', () {
        RetrieveOptions options = new RetrieveOptions(search: 'some_search_pattern');
        expect(options.toMap(), {"search":"some_search_pattern"});
      });

      test('should return a json with domain', () {
        RetrieveOptions options = new RetrieveOptions(domain: 'http://domain.test');
        expect(options.toMap(), {"domain":"http://domain.test"});
      });

      test('should return a json with count', () {
        RetrieveOptions options = new RetrieveOptions(count: 10);
        expect(options.toMap(), {"count":"10"});
      });

      test('should return a json with offset', () {
        RetrieveOptions options = new RetrieveOptions(offset: 10);
        expect(options.toMap(), {});

        options.count = 50;
        expect(options.toMap(), {"count":"50", "offset":"10"});
      });

      test('should return a json with since', () {
        RetrieveOptions options = new RetrieveOptions(since: new DateTime.utc(2015, 10, 20));
        expect(options.toMap(), {"since":"1445299200000"});
      });

      test('should return json with all options', () {
        RetrieveOptions options = new RetrieveOptions()
          ..since = new DateTime.utc(2015, 5, 4)
          ..contentType = ContentType.video
          ..count = 100
          ..offset = 10
          ..detailType = DetailType.complete
          ..domain = 'http://domain.test'
          ..search = 'Some search query'
          ..isFavorite = true
          ..sortType = SortType.site
          ..state = State.archive
          ..tag = 'cats';

        Map<String, String> expected = {
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
          'since':'1430697600000'
        };

        expect(options.toMap(), expected);
      });
    });
  }
}

void main() {
	RetrieveOptionsTests.run();
}