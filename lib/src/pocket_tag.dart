library pocket_client.tag;

import 'dart:convert';

class PocketTag {

  String itemId;
  String tag;

  PocketTag.fromMap(Map<String, String> map) {
	  _initFromMap(map);
  }

  PocketTag.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    _initFromMap(json);
  }

  _initFromMap(Map<String, String> map) {
	  itemId = map['item_id'];
	  tag = map['tag'];
  }
}