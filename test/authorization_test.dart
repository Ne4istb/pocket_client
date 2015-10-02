library pocket_client.authorization_test;

import 'package:pocket_client/pocket_client.dart' as pocket;
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';

import 'mocks.dart';

class AuthorizationTests{

  static run(){

    group('getRequestToken()', () {

      const consumer_key = '1234-abcd1234abcd1234abcd1234';
      const redirectUri = 'http://som_redirect_uri';

      test('should return request token', () {

        const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        var response = new Response('{"code":"$requestCode"}', 200);

        var url = '${pocket.ClientBase.rootUrl}${pocket.ClientAuthorization.oauthRequestUrl}';

        var client = Mocks.httpClient(response, url, (String body) {
	        var json = JSON.decode(body);
	        expect(json['consumer_key'], consumer_key);
	        expect(json['redirect_uri'], redirectUri);
        });

        var pocketClient = new pocket.ClientAuthorization(consumer_key, client);

        pocketClient.getRequestToken(redirectUri).then((result) {
          expect(result, requestCode);
        });
      });
    });

    group('getAccessToken()', () {

      const consumer_key = '1234-abcd1234abcd1234abcd1234';
      const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

      test('should return pocket user', () {

        const accessToken = '5678defg-5678-defg-5678-defg56';
        const userName = 'Ne4istb';

        var response = new Response('{"access_token":"$accessToken","username":"$userName"}', 200);

        var url = '${pocket.ClientBase.rootUrl}${pocket.ClientAuthorization.oauthAccessUrl}';

        var client = Mocks.httpClient(response, url, (String body) {
	        var json = JSON.decode(body);
	        expect(json['consumer_key'], consumer_key);
	        expect(json['code'], requestCode);
        });

        var pocketClient = new pocket.ClientAuthorization(consumer_key, client);

        pocketClient.getAccessToken(requestCode).then((result) {
          expect(result is pocket.User, isTrue);
          expect(result.userName, userName);
          expect(result.accessToken, accessToken);
        });
      });
    });

    group('getAuthorizeUrl()', () {

      test('should return authorization url', () {

        const redirectUri = 'http://som_redirect_uri?test=me';
        const requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        var actualUrl = pocket.ClientAuthorization.getAuthorizeUrl(requestCode, redirectUri);

        expect(actualUrl, 'https://getpocket.com/auth/authorize?request_token=dcba4321-dcba-4321-dcba-4321dc&redirect_uri=http%3A%2F%2Fsom_redirect_uri%3Ftest%3Dme');
      });
    });
  }
}

void main() {
	AuthorizationTests.run();
}