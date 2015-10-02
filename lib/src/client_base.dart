library pocket_client.base;

import 'dart:async';
import 'package:http/http.dart' as http;

abstract class ClientBase {

	static final rootUrl = 'https://getpocket.com';

	final Map<String, String> headers = {
		'Content-Type': 'application/json; charset=UTF-8',
		'X-Accept': 'application/json'
	};

	String consumerKey;
	http.Client _httpClient;

	ClientBase(this.consumerKey, [http.Client httpClient = null]) {
		this._httpClient = (httpClient == null) ? new http.Client() : httpClient;
	}

	Future<http.Response> httpPost(String url, String body) {
		return _httpClient.post(url, headers: headers, body: body).then((http.Response response) {

			if (response.statusCode != 200)
				_processError(response);

			return response;
		});
	}

	_processError(http.Response response) {
		var headers = response.headers;

		if (response.statusCode >= 400 && response.statusCode < 500)
			throw new ArgumentError('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');

		if (response.statusCode >= 500)
			throw new http.ClientException('An error occurred: ${headers['x-error-code']}. ${headers['x-error']}');
	}
}
