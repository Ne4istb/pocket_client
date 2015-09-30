library pocket_client.authorization_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class AuthorizationTests{

  static run(){
    group('getRequestToken()', () {
      const consumer_key = '1234-abcd1234abcd1234abcd1234';
      const redirectUri = 'http://som_redirect_uri';

      MockClient mockHttpClient(response) {
        return new MockClient((Request request) {
          expect(
          request.url.toString(), '${Pocket.ROOT_URL}${Pocket.OAUTH_REQUEST_URL}');
          expect(request.method, 'POST');

          var body = JSON.decode(request.body);
          expect(body['consumer_key'], consumer_key);
          expect(body['redirect_uri'], redirectUri);

          return response;
        });
      }

      test('should return request token', () {
        const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        var response = new Response('{"code":"$requestCode"}', 200);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        pocket.getRequestToken(redirectUri).then((result) {
          expect(result, requestCode);
        });
      });

      test('should throw an argument error with code and description ', () {
        Map<String, String> headers = {
          'x-error-code': '138',
          'x-error': 'Missing consumer key.'
        };

        var response = new Response('', 400, headers: headers);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        expect(
        pocket.getRequestToken(redirectUri),
        throwsA(predicate((e) => e is ArgumentError && e.message == 'An error occurred: 138. Missing consumer key.')));
      });

      test('should throw a client exception with code and description ', () {
        Map<String, String> headers = {
          'x-error-code': '199',
          'x-error': 'Pocket server issue.'
        };

        var response = new Response('', 500, headers: headers);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        expect(
        pocket.getRequestToken(redirectUri),
        throwsA(predicate((e) => e is ClientException && e.message == 'An error occurred: 199. Pocket server issue.')));
      });
    });

    group('getAccessToken()', () {

      const consumer_key = '1234-abcd1234abcd1234abcd1234';
      const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

      MockClient mockHttpClient(response) {
        return new MockClient((Request request) {
          expect(
          request.url.toString(), '${Pocket.ROOT_URL}${Pocket.OAUTH_ACCESS_URL}');
          expect(request.method, 'POST');

          var body = JSON.decode(request.body);
          expect(body['consumer_key'], consumer_key);
          expect(body['code'], requestCode);

          return response;
        });
      }

      test('should return pocket user', () {

        const accessToken = '5678defg-5678-defg-5678-defg56';
        const userName = 'Ne4istb';

        var response = new Response('{"access_token":"$accessToken","username":"$userName"}', 200);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        pocket.getAccessToken(requestCode).then((result) {
          expect(result is PocketUser, isTrue);
          expect(result.userName, userName);
          expect(result.accessToken, accessToken);
        });
      });

      test('should throw an argument error with code and description ', () {
        Map<String, String> headers = {
          'x-error-code': '185',
          'x-error': 'Code not found.'
        };

        var response = new Response('', 400, headers: headers);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        expect(
        pocket.getAccessToken(requestCode),
        throwsA(predicate((e) => e is ArgumentError && e.message == 'An error occurred: 185. Code not found.')));
      });

      test('should throw a client exception with code and description ', () {
        Map<String, String> headers = {
          'x-error-code': '199',
          'x-error': 'Pocket server issue.'
        };

        var response = new Response('', 500, headers: headers);

        var client = mockHttpClient(response);
        var pocket = new Pocket(consumer_key, client);

        expect(
        pocket.getAccessToken(requestCode),
        throwsA(predicate((e) => e is ClientException && e.message == 'An error occurred: 199. Pocket server issue.')));
      });
    });

    group('getAuthorizeUrl()', () {

      test('should return authorization url', () {

        const redirectUri = 'http://som_redirect_uri?test=me';
        const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        var actualUrl = Pocket.getAuthorizeUrl(requestCode, redirectUri);

        expect(actualUrl, 'https://getpocket.com/auth/authorize?request_token=dcba4321-dcba-4321-dcba-4321dc&redirect_uri=http%3A%2F%2Fsom_redirect_uri%3Ftest%3Dme');
      });
    });
  }
}

void main() {
	AuthorizationTests.run();
}