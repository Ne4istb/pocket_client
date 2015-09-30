library pocket_client.author;

import 'dart:convert';

class PocketAuthor {

  String itemId;
  String authorId;
  String name;
  String url;


  PocketAuthor(this.itemId, this.authorId, this.name, {this.url});

  PocketAuthor.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    _initFromMap(json);
  }

  PocketAuthor.fromMap(Map<String, String> map) {
	  _initFromMap(map);
  }

  _initFromMap(Map<String, String> map) {
	  itemId = map['item_id'];
	  authorId = map['author_id'];
	  name = map['name'];
	  url = map['url'];
  }
}