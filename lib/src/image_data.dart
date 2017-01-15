library pocket_client.image_data;

import 'dart:convert';

class ImageData {
  String itemId;
  String imageId;
  String sourceUrl;
  int width;
  int height;
  String credit;
  String caption;

  ImageData(this.itemId, this.imageId, this.sourceUrl, {this.width, this.height, this.credit, this.caption});

  ImageData.fromJSON(String jsonString) {
    Map<String, String> json = JSON.decode(jsonString) as Map<String, String>;
    _initFromMap(json);
  }

  ImageData.fromMap(Map<String, String> map) {
    _initFromMap(map);
  }

  void _initFromMap(Map<String, String> map) {
    itemId = map['item_id'];
    imageId = map['image_id'];
    credit = map['credit'];
    caption = map['caption'];
    sourceUrl = map['src'];
    width = map['width'] == null ? null : int.parse(map['width']);
    height = map['height'] != null ? int.parse(map['height']) : null;
  }
}
