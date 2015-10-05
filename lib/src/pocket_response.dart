library pocket_client.response;

import 'dart:convert';
import 'package:pocket_client/src/pocket_data.dart';

class PocketResponse {

	int status;
	int complete;
	Map<String, PocketData> items;
	String error;
	DateTime since;

	PocketResponse.fromJSON(String jsonString) {
		Map json = JSON.decode(jsonString);

		status = json['status'];
		complete = json['complete'];
		items = _convertToPocketDataList(json['list']);
		error = json['error'];
		since = json['since'] != null ? new DateTime.fromMillisecondsSinceEpoch(json['since']) : null;
	}

	Map<String, PocketData> _convertToPocketDataList(list) {
		Map<String, PocketData> result = {};

		if (list != null && list.length > 0)
			list.forEach((id, item) => result[id] = new PocketData.fromMap(item));

		return result;
	}
}