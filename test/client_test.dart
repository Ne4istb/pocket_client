library pocket_client.client_test;

import 'package:pocket_client/pocket_client.dart' as pocket;
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'mocks.dart';

class ClientTests {
  static void run() {
    const String consumerKey = '1234-abcd1234abcd1234abcd1234';
    const String accessToken = '5678defg-5678-defg-5678-defg56';

    const String responseJson = '''
				{
				  "status": 1,
				  "complete": 0,
				  "error": "Some error",
				  "since": 1443547195
				}''';

    void _assertResponse(pocket.PocketResponse result) {
      expect(result.status, 1);
      expect(result.complete, 0);
      expect(result.error, 'Some error');
      expect(result.items, {});
    }

    Response response = new Response(responseJson, 200);

    const String addItemResponseJson = '''
		{
			"item": {
			  "item_id": "229279689",
			  "resolved_id": "229279689",
			  "given_url": "http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview",
			  "given_title": "The Massive Ryder Cup Preview - The Triangle Blog - Grantland"
		  }
	  }''';

    void _assertAddItemResponse(pocket.PocketData result) {
      expect(result.itemId, '229279689');
      expect(result.resolvedId, '229279689');
      expect(result.givenUrl, 'http:\/\/www.grantland.com\/blog\/the-triangle\/post\/_\/id\/38347\/ryder-cup-preview');
      expect(result.givenTitle, 'The Massive Ryder Cup Preview - The Triangle Blog - Grantland');
    }

    Response addItemResponse = new Response(addItemResponseJson, 200);

    const String actionResultsJson = '{"status": 0, "action_results":[true, false,true]}';

    void _assertActionResults(pocket.ActionResults result) {
      expect(result.hasErrors, true);
      expect(result.results, [true, false, true]);
    }

    Response actionResultsResponse = new Response(actionResultsJson, 200);

    group('Get data.', () {
      final String url = '${pocket.ClientBase.rootUrl}${pocket.Client.getSubUrl}';

      test('should return data (without request options)', () {
        Client client = Mocks.httpClient(response, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);
          expect(json.length, 2);
          expect(json['consumer_key'], consumerKey);
          expect(json['access_token'], accessToken);
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient.getData().then(_assertResponse);
      });

      test('should return data (with options)', () {
        pocket.RetrieveOptions options = new pocket.RetrieveOptions()
          ..since = new DateTime.utc(2015, 5, 4)
          ..contentType = pocket.ContentType.video
          ..count = 100
          ..offset = 10
          ..detailType = pocket.DetailType.complete
          ..domain = 'http://domain.test'
          ..search = 'Some search query'
          ..isFavorite = true
          ..sortType = pocket.SortType.site
          ..state = pocket.State.archive
          ..tag = 'cats';

        Client client = Mocks.httpClient(response, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 13);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');
          expect(json['state'], 'archive', reason: 'state');
          expect(json['favorite'], '1', reason: 'favorite');
          expect(json['tag'], 'cats', reason: 'tag');
          expect(json['contentType'], 'video', reason: 'contentType');
          expect(json['sort'], 'site', reason: 'sort');
          expect(json['detailType'], 'complete', reason: 'detailType');
          expect(json['search'], 'Some search query', reason: 'search');
          expect(json['domain'], 'http://domain.test', reason: 'domain');
          expect(json['count'], '100', reason: 'count');
          expect(json['offset'], '10', reason: 'offset');
          expect(json['since'], '1430697600000', reason: 'domain');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient.getData(options: options).then(_assertResponse);
      });
    });

    group('Add item.', () {
      final String url = '${pocket.ClientBase.rootUrl}${pocket.Client.addSubUrl}';

      test('should add url and return created item', () {
        String newUrl = 'http://test.com/';

        Client client = Mocks.httpClient(addItemResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');
          expect(json['url'], 'http://test.com/', reason: 'url');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient.addUrl(newUrl).then(_assertAddItemResponse);
      });

      test('should add item and return created item', () {
        pocket.ItemToAdd newItem = new pocket.ItemToAdd('http://test.com/')
          ..title = 'Test title'
          ..tweetId = '123456'
          ..tags = ['first', 'second', 'last'];

        Client client = Mocks.httpClient(addItemResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 6);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          expect(json['url'], 'http://test.com/', reason: 'url');
          expect(json['title'], 'Test%20title', reason: 'title');
          expect(json['tweet_id'], '123456', reason: 'tweet_id');
          expect(json['tags'], 'first, second, last', reason: 'tags');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient.addItem(newItem).then(_assertAddItemResponse);
      });
    });

    group('Actions.', () {
      final String url = '${pocket.ClientBase.rootUrl}${pocket.Client.sendSubUrl}';

      test('should send actions', () {
        List<pocket.Action> actions = [
          new pocket.DeleteAction(12340, time: new DateTime.fromMillisecondsSinceEpoch(1430686800000)),
          new pocket.ArchiveAction(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001)),
          new pocket.FavoriteAction(12342, time: new DateTime.fromMillisecondsSinceEpoch(1430686800002))
        ];

        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];
          expect(actionsJson.length, 3, reason: 'actions length');
          expect(actionsJson[0]['action'], 'delete', reason: 'actions delete');
          expect(actionsJson[0]['item_id'], '12340', reason: 'actions delete');
          expect(actionsJson[0]['time'], '1430686800000', reason: 'actions delete');

          expect(actionsJson[1]['action'], 'archive', reason: 'actions archive');
          expect(actionsJson[1]['item_id'], '12341', reason: 'actions archive');
          expect(actionsJson[1]['time'], '1430686800001', reason: 'actions archive');

          expect(actionsJson[2]['action'], 'favorite', reason: 'actions favorite');
          expect(actionsJson[2]['item_id'], '12342', reason: 'actions favorite');
          expect(actionsJson[2]['time'], '1430686800002', reason: 'actions favorite');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient.modify(actions).then(_assertActionResults);
      });

      test('should archive item', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'archive', reason: 'actions archive');
          expect(actionsJson[0]['item_id'], '12341', reason: 'actions archive');
          expect(actionsJson[0]['time'], '1430686800001', reason: 'actions archive');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .archive(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
            .then(_assertActionResults);
      });

      test('should delete item', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'delete', reason: 'actions delete');
          expect(actionsJson[0]['item_id'], '12342', reason: 'actions delete');
          expect(actionsJson[0]['time'], '1430686800002', reason: 'actions delete');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .delete(12342, time: new DateTime.fromMillisecondsSinceEpoch(1430686800002))
            .then(_assertActionResults);
      });

      test('should favorite item', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'favorite', reason: 'actions favorite');
          expect(actionsJson[0]['item_id'], '12343', reason: 'actions favorite');
          expect(actionsJson[0]['time'], '1430686800003', reason: 'actions favorite');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .favorite(12343, time: new DateTime.fromMillisecondsSinceEpoch(1430686800003))
            .then(_assertActionResults);
      });

      test('should unfavorite item', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'unfavorite', reason: 'actions unfavorite');
          expect(actionsJson[0]['item_id'], '12344', reason: 'actions unfavorite');
          expect(actionsJson[0]['time'], '1430686800004', reason: 'actions unfavorite');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .unFavorite(12344, time: new DateTime.fromMillisecondsSinceEpoch(1430686800004))
            .then(_assertActionResults);
      });

      test('should readd item', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'readd', reason: 'actions readd');
          expect(actionsJson[0]['item_id'], '12345', reason: 'actions readd');
          expect(actionsJson[0]['time'], '1430686800005', reason: 'actions readd');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .reAdd(12345, time: new DateTime.fromMillisecondsSinceEpoch(1430686800005))
            .then(_assertActionResults);
      });

      test('should clear tags', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'tags_clear', reason: 'actions tags_clear');
          expect(actionsJson[0]['item_id'], '12346', reason: 'actions tags_clear');
          expect(actionsJson[0]['time'], '1430686800006', reason: 'actions tags_clear');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .clearTags(12346, time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
            .then(_assertActionResults);
      });

      test('should add tags', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'tags_add', reason: 'actions tags_add');
          expect(actionsJson[0]['item_id'], '12346', reason: 'actions tags_add');
          expect(actionsJson[0]['tags'], 'firstTag, secondTag', reason: 'actions tags_add');
          expect(actionsJson[0]['time'], '1430686800006', reason: 'actions tags_add');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .addTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
            .then(_assertActionResults);
      });

      test('should remove tags', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'tags_remove', reason: 'actions tags_remove');
          expect(actionsJson[0]['item_id'], '12346', reason: 'actions tags_remove');
          expect(actionsJson[0]['tags'], 'firstTag, secondTag', reason: 'actions tags_remove');
          expect(actionsJson[0]['time'], '1430686800006', reason: 'actions tags_remove');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .removeTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
            .then(_assertActionResults);
      });

      test('should replace tags', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'tags_replace', reason: 'actions tags_replace');
          expect(actionsJson[0]['item_id'], '12346', reason: 'actions tags_replace');
          expect(actionsJson[0]['tags'], 'firstTag, secondTag', reason: 'actions tags_replace');
          expect(actionsJson[0]['time'], '1430686800006', reason: 'actions tags_replace');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .replaceTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
            .then(_assertActionResults);
      });

      test('should rename tag', () {
        Client client = Mocks.httpClient(actionResultsResponse, url, (String body) {
          Map<String, dynamic> json = JSON.decode(body);

          expect(json.length, 3);
          expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
          expect(json['access_token'], accessToken, reason: 'access_token');

          List<Map<String, dynamic>> actionsJson = json['actions'];

          expect(actionsJson.length, 1, reason: 'actions length');
          expect(actionsJson[0]['action'], 'tag_rename', reason: 'actions tag_rename');
          expect(actionsJson[0]['item_id'], '12346', reason: 'actions tag_rename');
          expect(actionsJson[0]['old_tag'], 'firstTag', reason: 'actions tag_rename');
          expect(actionsJson[0]['new_tag'], 'secondTag', reason: 'actions tag_rename');
          expect(actionsJson[0]['time'], '1430686800006', reason: 'actions tag_rename');
        });

        pocket.Client pocketClient = new pocket.Client(consumerKey, accessToken, client);
        pocketClient
            .renameTag(12346, 'firstTag', 'secondTag', time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
            .then(_assertActionResults);
      });
    });
  }
}

void main() {
  ClientTests.run();
}
