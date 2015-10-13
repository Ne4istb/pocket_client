// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.example;

import 'package:pocket_client/pocket_client.dart';

const consumerKey = '1234-abcd1234abcd1234abcd1234';
const redirectUrl = 'http://some.redirect.uri/autorizationFinished';
const accessToken = '5678defg-5678-defg-5678-defg56';

main() async {
  var authentication = new ClientAuthentication(consumerKey);

  var requestToken = await authentication.getRequestToken(redirectUrl);
  var url = ClientAuthentication.getAuthorizeUrl(requestToken, redirectUrl);
  // work whatever redirect magic you need here

  //..

  var userData = await authentication.getAccessToken(requestToken);
  onAuthorizationFinished(userData.accessToken);
}

onAuthorizationFinished(String accessToken) async {
  var client = new Client(consumerKey, accessToken);

  var options = new RetrieveOptions()
    ..since = new DateTime(2015, 5, 4)
    ..search = 'Some search query'
    ..domain = 'http://domain.test'
    ..contentType = ContentType.video
    ..detailType = DetailType.complete
    ..isFavorite = true
    ..sortType = SortType.site
    ..state = State.all
    ..tag = 'cats'
    ..count = 100
    ..offset = 10;

  var response = await client.getData(options: options);
  Map<String, PocketData> items = response.items;
  // do whatever you want with pocket items

  var newItem = new ItemToAdd('http://www.funnycatpix.com/')
    ..title = 'FUNNY CAT PICTURES'
    ..tweetId = '123456'
    ..tags = ['cats', 'cool', 'share'];

  PocketData data = await client.addItem(newItem);
  // do whatever you want with received data
}