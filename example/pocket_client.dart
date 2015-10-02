// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.example;

import 'package:pocket_client/pocket_client.dart';

main() {
	const consumer_key = '46214-7e17b7d5c796445b095309ef';
	var pocket = new Client(consumer_key);

// pocket.getRequestToken("http://som_redirect_uri").then((code){
// print(Pocket.getAuthorizeUrl(code, "http://google.com"));
// });

// pocket.getAccessToken('562fcec9-e170-18c9-d256-211221').then((code){
// print(code.accessToken);
// print(code.userName);
//
// });

	var options = new RetrieveOptions()
		..count = 100
		..detailType = DetailType.complete
		..tag = 'digest';
	pocket.getData('cfd6484b-0f8f-87e7-5aee-c55c12', options: options).then((r){
		print(r);
	});

}