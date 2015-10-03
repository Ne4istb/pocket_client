# pocket_client

A library for authenticating and accessing the Pocket API from Dart

## Quick start

###### Authorization:
```dart
import 'package:pocket_client/pocket_client.dart';

const consumerKey = '1234-abcd1234abcd1234abcd1234';
const redirectUrl = 'http://some.redirect.uri/autorizationFinished';

main() {
	var authorization = new ClientAuthorization(consumerKey);

	var requestToken;

	authorization.getRequestToken(redirectUrl).then((code) {
		requestToken = code;

		var url = ClientAuthorization.getAuthorizeUrl(requestToken, redirectUrl);
		// work whatever redirect magic you need here
	});

	//..

	authorization.getAccessToken(requestToken).then(onAuthorizationFinished);
}
onAuthorizationFinished(User userData) {
	var accessToken = userData.accessToken;
	// now you have everything to communicate with Pocket 
}
```

###### Working with Pocket:
```dart
import 'package:pocket_client/pocket_client.dart';

const consumerKey = '1234-abcd1234abcd1234abcd1234';
const accessToken = '5678defg-5678-defg-5678-defg56';

main() {
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

	client.getData(options: options).then((PocketResponse response) {
		Map<String, PocketData> items = response.items;
		// do whatever you want with pocket items
	});

	var newItem = new ItemToAdd('http://www.funnycatpix.com/')
		..title = 'FUNNY CAT PICTURES'
		..tweetId = '123456'
		..tags = ['cats', 'cool', 'share'];

	client.addItem(newItem).then((PocketData data) {
		// do whatever you want with received data
	});
}
```

## Api

See the [Api documentation](https://github.com/Ne4istb/pocket_client/blob/master/API.md).

## Examples

The basic example is in [example](https://github.com/Ne4istb/pocket_client/blob/master/example/pocket_client.dart);

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Ne4istb/pocket_client/issues


## License

pocket\_client is distributed under the [MIT license](https://github.com/Ne4istb/pocket_client/blob/master/LICENSE).



