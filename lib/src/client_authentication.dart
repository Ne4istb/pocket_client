// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.authentication;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:pocket_client/src/client_base.dart';
import 'package:pocket_client/src/user.dart';

class ClientAuthentication extends ClientBase {

	static const oauthRequestUrl = '/v3/oauth/request';
	static const oauthTokenUrl = '/auth/authorize';
	static const oauthAccessUrl = '/v3/oauth/authorize';

	ClientAuthentication(String consumerKey, [http.Client httpClient = null]) : super(consumerKey, httpClient);

	Future<String> getRequestToken(String redirectUri) {
		var url = '${ClientBase.rootUrl}$oauthRequestUrl';

		Map<String, String> body = {
			'consumer_key': consumerKey,
			'redirect_uri': redirectUri
		};

		var bodyJson = JSON.encode(body);

		return httpPost(url, bodyJson).then((http.Response response) => JSON.decode(response.body)['code']);
	}

	Future<User> getAccessToken(String requestToken) {
		var url = '${ClientBase.rootUrl}$oauthAccessUrl';

		Map<String, String> body = {
			'consumer_key': consumerKey,
			'code': requestToken
		};

		var bodyJson = JSON.encode(body);

		return httpPost(url, bodyJson).then((http.Response response) => new User.fromJSON(response.body));
	}

	static String getAuthorizeUrl(String requestToken, String redirectUri) {
		var encodedRedirectUrl = Uri.encodeQueryComponent(redirectUri);
		return '${ClientBase.rootUrl}$oauthTokenUrl?request_token=$requestToken&redirect_uri=$encodedRedirectUrl';
	}
}
