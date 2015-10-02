library pocket_client.tag;

import 'dart:convert';

class Tag {

  String itemId;
  String tag;

  Tag.fromMap(Map<String, String> map) {
	  _initFromMap(map);
  }

  Tag.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    _initFromMap(json);
  }

  _initFromMap(Map<String, String> map) {
	  itemId = map['item_id'];
	  tag = map['tag'];
  }
}