// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.base;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import 'package:pocket_client/src/pocket_user.dart';
import 'package:pocket_client/src/pocket_retrieve_options.dart';

class Pocket {
  
  static const ROOT_URL = 'https://getpocket.com';
  static const ADD_URL = '/v3/add';
  static const SEND_URL = '/v3/send';
  static const GET_URL = '/v3/get';
  static const OAUTH_REQUEST_URL = '/v3/oauth/request';
  static const OAUTH_TOKEN_URL = '/auth/authorize';
  static const OAUTH_ACCESS_URL = '/v3/oauth/authorize';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'X-Accept': 'application/json'
  };

  String _consumerKey;
  Client _httpClient;

  Pocket(this._consumerKey, [Client httpClient = null]) {
    _httpClient = (httpClient == null) ? new Client() : httpClient;
  }

  Future<String> getRequestToken(String redirectUri) {

    var url = '$ROOT_URL$OAUTH_REQUEST_URL';

    Map<String, String> body = {
      'consumer_key': _consumerKey,
      'redirect_uri': redirectUri
    };

    var bodyJson = JSON.encode(body);

    return _httpClient
      .post(url, headers: _headers, body: bodyJson)
      .then((Response response) {

        if (response.statusCode != 200)
          _processError(response);

        return JSON.decode(response.body)['code'];
      });
  }

  Future<PocketUser> getAccessToken(String requestToken) {

    var url = '$ROOT_URL$OAUTH_ACCESS_URL';

    Map<String, String> body = {
      'consumer_key': _consumerKey,
      'code': requestToken
    };

    var bodyJson = JSON.encode(body);

    return _httpClient
    .post(url, headers: _headers, body: bodyJson)
    .then((Response response) {

      if (response.statusCode != 200)
        _processError(response);

      return new PocketUser.fromJSON(response.body);
    });
  }

  Future<String> getPocketData(String accessToken, {PocketRetrieveOptions options}) {

    var url = '$ROOT_URL$GET_URL';

    Map<String, String> body = {
      'consumer_key': _consumerKey,
      'access_token': accessToken
    };

    if (options !=null)
      body.addAll(options.toMap());

    var bodyJson = JSON.encode(body);

    return _httpClient
    .post(url, headers: _headers, body: bodyJson)
    .then((Response response) {

      if (response.statusCode != 200)
        _processError(response);

      return response.body;
    });
  }

  static String getAuthorizeUrl(String requestToken, String redirectUri) {
    var encodedRedirectUrl = Uri.encodeQueryComponent(redirectUri);
    return '$ROOT_URL$OAUTH_TOKEN_URL?request_token=$requestToken&redirect_uri=$encodedRedirectUrl';
  }

  _processError(Response response) {

    var headers = response.headers;

    if (response.statusCode >= 400 && response.statusCode < 500)
      throw new ArgumentError('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');

    if (response.statusCode >= 500)
      throw new ClientException('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');
  }
}
