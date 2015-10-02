library pocket_client.author;

import 'dart:convert';

class Author {

  String itemId;
  String authorId;
  String name;
  String url;


  Author(this.itemId, this.authorId, this.name, {this.url});

  Author.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    _initFromMap(json);
  }

  Author.fromMap(Map<String, String> map) {
	  _initFromMap(map);
  }

  _initFromMap(Map<String, String> map) {
	  itemId = map['item_id'];
	  authorId = map['author_id'];
	  name = map['name'];
	  url = map['url'];
  }
}