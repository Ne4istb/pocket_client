library pocket_client.user;

import 'dart:convert';

class PocketUser {

  String accessToken;
  String userName;

  PocketUser(this.userName, this.accessToken);

  PocketUser.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    userName = json['username'];
    accessToken = json['access_token'];
  }
}