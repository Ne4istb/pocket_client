library pocket_client.author;

import 'dart:convert';

class Author {

  String itemId;
  String authorId;
  String name;
  String url;


  Author(this.itemId, this.authorId, this.name, {this.url});

  Author.fromJSON(String jsonString) {
    Map<String, String> json = JSON.decode(jsonString) as Map<String, String>;
    _initFromMap(json);
  }

  Author.fromMap(Map<String, String> map) {
	  _initFromMap(map);
  }

  void _initFromMap(Map<String, String> map) {
	  itemId = map['item_id'];
	  authorId = map['author_id'];
	  name = map['name'];
	  url = map['url'];
  }
}