library pocket_client.client_base_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'mocks.dart';

class TestClientBase extends PocketClientBase {
	TestClientBase(String consumerKey, [Client httpClient = null]) : super(consumerKey, httpClient);
}

class ClientBaseTests {

	static run() {
		group('httpPost()', () {
			const consumer_key = '1234-abcd1234abcd1234abcd1234';
			const testUrl = 'http://test';
			const testBody = 'test body';

			test('should return requested data', () {
				var expected = '{"test":"passed"}';
				var response = new Response(expected, 200);

				var client = Mocks.httpClient(response, testUrl, (body) => expect(body, testBody));
				var pocketBase = new TestClientBase(consumer_key, client);

				pocketBase.httpPost(testUrl, testBody).then((Response response) => expect(response.body, expected));
			});


			test('should throw an argument error with code and description ', () {
				Map<String, String> headers = {
					'x-error-code': '138',
					'x-error': 'Missing consumer key.'
				};

				var response = new Response('', 400, headers: headers);

				var client = Mocks.httpClient(response, testUrl, (body) => expect(body, testBody));
				var pocketBase = new TestClientBase(consumer_key, client);

				expect(
				pocketBase.httpPost(testUrl, testBody),
				throwsA(predicate((e) => e is ArgumentError && e.message == 'An error occurred: 138. Missing consumer key.')));
			});

			test('should throw a client exception with code and description ', () {
				Map<String, String> headers = {
					'x-error-code': '199',
					'x-error': 'Pocket server issue.'
				};

				var response = new Response('', 500, headers: headers);

				var client = Mocks.httpClient(response, testUrl, (body) => expect(body, testBody));
				var pocketBase = new TestClientBase(consumer_key, client);

				expect(
				pocketBase.httpPost(testUrl, testBody),
				throwsA(predicate((e) => e is ClientException && e.message == 'An error occurred: 199. Pocket server issue.')));
			});
		});
	}
}

void main() {
	ClientBaseTests.run();
}