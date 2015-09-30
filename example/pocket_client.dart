// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.example;

import 'package:pocket_client/pocket_client.dart';

main() {
	const consumer_key = '46214-7e17b7d5c796445b095309ef';
	var pocket = new Pocket(consumer_key);

// pocket.getRequestToken("http://som_redirect_uri").then((code){
// print(Pocket.getAuthorizeUrl(code, "http://google.com"));
// });

// pocket.getAccessToken('562fcec9-e170-18c9-d256-211221').then((code){
// print(code.accessToken);
// print(code.userName);
//
// });

	var options = new PocketRetrieveOptions()
		..count = 100
		..detailType = PocketDetailType.Complete
		..tag = 'digest';
	pocket.getPocketData('cfd6484b-0f8f-87e7-5aee-c55c1a', options: options).then(print);
//https://www.google.com.ua/?gfe_rd=cr&ei=vegHVv1Ek..
// cfd6484b-0f8f-87e7-5aee-c55c1a
// Ne4istb

}