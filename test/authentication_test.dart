library pocket_client.authentication_test;

import 'package:pocket_client/pocket_client.dart' as pocket;
import 'package:test/test.dart';

import 'dart:convert';
import 'package:http/http.dart';

import 'mocks.dart';

class AuthenticationTests {
  static void run() {
    group('getRequestToken()', () {
      const String consumerKey = '1234-abcd1234abcd1234abcd1234';
      const String redirectUri = 'http://som_redirect_uri';

      test('should return request token', () {
        const String requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        Response response = new Response('{"code":"$requestCode"}', 200);

        String url = '${pocket.ClientBase.rootUrl}${pocket.ClientAuthentication.oauthRequestUrl}';

        Client client = Mocks.httpClient(response, url, (String body) {
          Map<String, String> json = JSON.decode(body);
          expect(json['consumer_key'], consumerKey);
          expect(json['redirect_uri'], redirectUri);
        });

        pocket.ClientAuthentication pocketClient = new pocket.ClientAuthentication(consumerKey, client);

        pocketClient.getRequestToken(redirectUri).then((String result) {
          expect(result, requestCode);
        });
      });
    });

    group('getAccessToken()', () {
      const String consumerKey = '1234-abcd1234abcd1234abcd1234';
      const String requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

      test('should return pocket user', () {
        const String accessToken = '5678defg-5678-defg-5678-defg56';
        const String userName = 'Ne4istb';

        Response response = new Response('{"access_token":"$accessToken","username":"$userName"}', 200);

        String url = '${pocket.ClientBase.rootUrl}${pocket.ClientAuthentication.oauthAccessUrl}';

        Client client = Mocks.httpClient(response, url, (String body) {
          Map<String, String> json = JSON.decode(body);
          expect(json['consumer_key'], consumerKey);
          expect(json['code'], requestCode);
        });

        pocket.ClientAuthentication pocketClient = new pocket.ClientAuthentication(consumerKey, client);

        pocketClient.getAccessToken(requestCode).then((pocket.User result) {
          expect(result is pocket.User, isTrue);
          expect(result.userName, userName);
          expect(result.accessToken, accessToken);
        });
      });
    });

    group('getAuthorizeUrl()', () {
      test('should return authorization url', () {
        const String redirectUri = 'http://som_redirect_uri?test=me';
        const String requestCode = 'dcba4321-dcba-4321-dcba-4321dc';

        String actualUrl = pocket.ClientAuthentication.getAuthorizeUrl(requestCode, redirectUri);

        expect(actualUrl,
            'https://getpocket.com/auth/authorize?request_token=dcba4321-dcba-4321-dcba-4321dc&redirect_uri=http%3A%2F%2Fsom_redirect_uri%3Ftest%3Dme');
      });
    });
  }
}

void main() {
  AuthenticationTests.run();
}
