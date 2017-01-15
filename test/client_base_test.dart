library pocket_client.client_base_test;

import 'package:pocket_client/pocket_client.dart' as pocket;
import 'package:test/test.dart';

import 'package:http/http.dart';

import 'mocks.dart';

class TestClientBase extends pocket.ClientBase {
  TestClientBase(String consumerKey, [Client httpClient = null]) : super(consumerKey, httpClient);
}

class ClientBaseTests {
  static void run() {
    group('httpPost()', () {
      const String consumerKey = '1234-abcd1234abcd1234abcd1234';
      const String testUrl = 'http://test';
      const String testBody = 'test body';

      test('should return requested data', () {
        String expected = '{"test":"passed"}';
        Response response = new Response(expected, 200);

        Client client = Mocks.httpClient(response, testUrl, (String body) => expect(body, testBody));
        TestClientBase pocketBase = new TestClientBase(consumerKey, client);

        pocketBase.httpPost(testUrl, testBody).then((Response response) => expect(response.body, expected));
      });

      test('should throw an argument error with code and description ', () {
        Map<String, String> headers = {'x-error-code': '138', 'x-error': 'Missing consumer key.'};

        Response response = new Response('', 400, headers: headers);

        Client client = Mocks.httpClient(response, testUrl, (String body) => expect(body, testBody));
        TestClientBase pocketBase = new TestClientBase(consumerKey, client);

        expect(
            pocketBase.httpPost(testUrl, testBody),
            throwsA(predicate((Error e) =>
                e is ArgumentError &&
                e.message ==
                    'An error occurred: 138. Missing consumer key'
                    '.')));
      });

      test('should throw a client exception with code and description ', () {
        Map<String, String> headers = {'x-error-code': '199', 'x-error': 'Pocket server issue.'};

        Response response = new Response('', 500, headers: headers);

        Client client = Mocks.httpClient(response, testUrl, (String body) => expect(body, testBody));
        TestClientBase pocketBase = new TestClientBase(consumerKey, client);

        expect(
            pocketBase.httpPost(testUrl, testBody),
            throwsA(predicate((Exception e) =>
                e is ClientException &&
                e.message ==
                    'An error occurred: 199. Pocket server '
                    'issue'
                    '.')));
      });
    });
  }
}

void main() {
  ClientBaseTests.run();
}
