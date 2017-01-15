library pocket_client.user;

import 'dart:convert';

class User {

  String accessToken;
  String userName;

  User(this.userName, this.accessToken);

  User.fromJSON(String jsonString) {
    Map<String, String> json = JSON.decode(jsonString) as Map<String, String>;
    userName = json['username'];
    accessToken = json['access_token'];
  }
}