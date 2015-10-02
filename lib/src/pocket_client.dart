// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.client;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

import 'package:pocket_client/src/pocket_client_base.dart';

import 'package:pocket_client/src/pocket_retrieve_options.dart';
import 'package:pocket_client/src/pocket_item_to_add.dart';
import 'package:pocket_client/src/pocket_response.dart';

class PocketClient extends PocketClientBase {

	static const addUrl = '/v3/add';
	static const sendUrl = '/v3/send';
	static const getUrl = '/v3/get';

	String accessToken;

	PocketClient(String consumerKey, this.accessToken, [Client httpClient = null]) : super(consumerKey, httpClient);

	Future<PocketResponse> getPocketData({PocketRetrieveOptions options}) {

		var url = '${PocketClientBase.rootUrl}$getUrl';

		Map<String, String> body = {
			'consumer_key': consumerKey,
			'access_token': accessToken
		};

		if (options != null)
			body.addAll(options.toMap());

		var bodyJson = JSON.encode(body);

		return httpPost(url, bodyJson).then((Response response) => new PocketResponse.fromJSON(response.body));
	}

	Future<PocketResponse> addItem(PocketItemToAdd newItem) {

		var url = '${PocketClientBase.rootUrl}$addUrl';

		Map<String, String> body = {
			'consumer_key': consumerKey,
			'access_token': accessToken
		};

		body.addAll(newItem.toMap());

		var bodyJson = JSON.encode(body);

		return httpPost(url, bodyJson).then((Response response) => new PocketResponse.fromJSON(response.body));
	}
}
