library pocket_client.base;

import 'dart:async';
import 'package:http/http.dart';

abstract class PocketClientBase {

	static final ROOT_URL = 'https://getpocket.com';

	final Map<String, String> headers = {
		'Content-Type': 'application/json; charset=UTF-8',
		'X-Accept': 'application/json'
	};

	String consumerKey;
	Client _httpClient;

	PocketClientBase(this.consumerKey, [Client httpClient = null]) {
		this._httpClient = (httpClient == null) ? new Client() : httpClient;
	}

	Future<Response> httpPost(String url, String body) {

		return _httpClient.post(url, headers: headers, body: body).then((Response response) {

				if (response.statusCode != 200)
				_processError(response);

			return response;
		});
	}

	_processError(Response response) {
		var headers = response.headers;

		if (response.statusCode >= 400 && response.statusCode < 500)
			throw new ArgumentError('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');

		if (response.statusCode >= 500)
			throw new ClientException('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');
	}
}
