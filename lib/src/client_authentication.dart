// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.authentication;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:pocket_client/src/client_base.dart';
import 'package:pocket_client/src/user.dart';

class ClientAuthentication extends ClientBase {
  static const String oauthRequestUrl = '/v3/oauth/request';
  static const String oauthTokenUrl = '/auth/authorize';
  static const String oauthAccessUrl = '/v3/oauth/authorize';

  ClientAuthentication(String consumerKey, [http.Client httpClient = null]) : super(consumerKey, httpClient);

  Future<String> getRequestToken(String redirectUri) {
    String url = '${ClientBase.rootUrl}$oauthRequestUrl';

    Map<String, String> body = new Map<String, String>()
      ..['consumer_key'] = consumerKey
      ..['redirect_uri'] = redirectUri;

    String bodyJson = JSON.encode(body);

    return httpPost(url, bodyJson).then((http.Response response) => JSON.decode(response.body)['code']);
  }

  Future<User> getAccessToken(String requestToken) {
    String url = '${ClientBase.rootUrl}$oauthAccessUrl';

    Map<String, String> body = new Map<String, String>()
      ..['consumer_key'] = consumerKey
      ..['code'] = requestToken;

    String bodyJson = JSON.encode(body);

    return httpPost(url, bodyJson).then((http.Response response) => new User.fromJSON(response.body));
  }

  static String getAuthorizeUrl(String requestToken, String redirectUri) {
    String encodedRedirectUrl = Uri.encodeQueryComponent(redirectUri);
    return '${ClientBase.rootUrl}$oauthTokenUrl?request_token=$requestToken&redirect_uri=$encodedRedirectUrl';
  }
}
