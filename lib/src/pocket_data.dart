library pocket_client.data;

import 'dart:convert';

class PocketData {

  String accessToken;
  String userName;

  PocketData(this.userName, this.accessToken);

  PocketData.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    userName = json['username'];
    accessToken = json['access_token'];
  }
}