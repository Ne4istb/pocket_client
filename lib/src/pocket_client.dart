// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.client;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import 'package:pocket_client/src/pocket_client_base.dart';

import 'package:pocket_client/src/pocket_user.dart';
import 'package:pocket_client/src/pocket_retrieve_options.dart';
import 'package:pocket_client/src/pocket_response.dart';

class PocketClient extends PocketClientBase {

	static const ADD_URL = '/v3/add';
	static const SEND_URL = '/v3/send';
	static const GET_URL = '/v3/get';

	PocketClient(String consumerKey, [Client httpClient = null]) : super(consumerKey, httpClient);

	Future<PocketResponse> getPocketData(String accessToken, {PocketRetrieveOptions options}) {

		var url = '${PocketClientBase.ROOT_URL}$GET_URL';

		Map<String, String> body = {
			'consumer_key': consumerKey,
			'access_token': accessToken
		};

		if (options != null)
			body.addAll(options.toMap());

		var bodyJson = JSON.encode(body);

		return httpPost(url, bodyJson).then((Response response) => new PocketResponse.fromJSON(response.body));
	}
}
