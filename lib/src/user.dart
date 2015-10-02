library pocket_client.user;

import 'dart:convert';

class User {

  String accessToken;
  String userName;

  User(this.userName, this.accessToken);

  User.fromJSON(String jsonString) {
    Map json = JSON.decode(jsonString);
    userName = json['username'];
    accessToken = json['access_token'];
  }
}