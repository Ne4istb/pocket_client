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
			final url = '${PocketClientBase.ROOT_URL}${PocketClient.GET_URL}';

			test('should return data (without request options)', () {

				var client = Mocks.httpClient(response, url, (String body) {
					Map json = JSON.decode(body);
					expect(json.length, 2);
					expect(json['consumer_key'], consumerKey);
					expect(json['access_token'], accessToken);
				});

				var pocket = new PocketClient(consumerKey, client);
				pocket.getPocketData(accessToken).then(assertResponse);
			});

			test('should return data (with options)', () {

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

				var pocket = new PocketClient(consumerKey, client);
				pocket.getPocketData(accessToken, options: options).then(assertResponse);
			});

		});
	}
}

void main() {
	ClientTests.run();
}