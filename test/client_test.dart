library pocket_client.client_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'mocks.dart';

class ClientTests {

	static run() {
		const consumerKey = '1234-abcd1234abcd1234abcd1234';
		const accessToken = '5678defg-5678-defg-5678-defg56';
		const responseJson = '''
				{
				  "status": 1,
				  "complete": 0,
				  "error": "Some error",
				  "since": 1443547195
				}''';

		assertResponse(PocketResponse result) {
			expect(result.status, 1);
			expect(result.complete, 0);
			expect(result.error, 'Some error');
			expect(result.status, 1);
			expect(result.list, {});
		}

		var response = new Response(responseJson, 200);

		group('getPocketData()', () {
			final url = '${PocketClientBase.rootUrl}${PocketClient.getSubUrl}';

			test('should return data (without request options)', () {

				var client = Mocks.httpClient(response, url, (String body) {
					Map json = JSON.decode(body);
					expect(json.length, 2);
					expect(json['consumer_key'], consumerKey);
					expect(json['access_token'], accessToken);
				});

				var pocket = new PocketClient(consumerKey, accessToken, client);
				pocket.getPocketData().then(assertResponse);
			});

			test('should return data (with options)', () {

				var options = new PocketRetrieveOptions()
					..since = new DateTime(2015, 5, 4)
					..contentType = PocketContentType.video
					..count = 100
					..offset = 10
					..detailType = PocketDetailType.complete
					..domain = 'http://domain.test'
					..search = 'Some search query'
					..isFavorite = true
					..sortType = PocketSortType.site
					..state = PocketState.archive
					..tag = 'cats';

				var client = Mocks.httpClient(response, url, (String body) {

					Map json = JSON.decode(body);

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
					expect(json['since'], '1430686800000', reason: 'domain');
				});

				var pocket = new PocketClient(consumerKey, accessToken, client);
				pocket.getPocketData(options: options).then(assertResponse);
			});

		});

		group('addItem()', () {

			final url = '${PocketClientBase.rootUrl}${PocketClient.addSubUrl}';

			test('should add url and return created item', () {

				var newUrl = 'http://test.com/';

				var client = Mocks.httpClient(response, url, (String body) {

					Map json = JSON.decode(body);

					expect(json.length, 3);
					expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
					expect(json['access_token'], accessToken, reason: 'access_token');
					expect(json['url'], 'http://test.com/', reason: 'url');
				});

				var pocket = new PocketClient(consumerKey, accessToken, client);
				pocket.addUrl(newUrl).then(assertResponse);
			});

			test('should add item and return created item', () {

				var newItem =  new PocketItemToAdd('http://test.com/')
					..title = 'Test title'
					..tweetId = '123456'
					..tags = ['first','second', 'last'];

				var client = Mocks.httpClient(response, url, (String body) {

					Map json = JSON.decode(body);

					expect(json.length, 6);
					expect(json['consumer_key'], consumerKey, reason: 'consumer_key');
					expect(json['access_token'], accessToken, reason: 'access_token');

					expect(json['url'], 'http://test.com/', reason: 'url');
					expect(json['title'], 'Test%20title', reason: 'title');
					expect(json['tweet_id'], '123456', reason: 'tweet_id');
					expect(json['tags'], 'first, second, last', reason: 'tags');
				});

				var pocket = new PocketClient(consumerKey, accessToken, client);
				pocket.addItem(newItem).then(assertResponse);
			});

		});
	}
}

void main() {
	ClientTests.run();
}