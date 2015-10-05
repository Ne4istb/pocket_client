# pocket_client

A library for authenticating and accessing the Pocket API from Dart

## Quick start

###### Authentication:
```dart
import 'package:pocket_client/pocket_client.dart';

const consumerKey = '1234-abcd1234abcd1234abcd1234';
const redirectUrl = 'http://some.redirect.uri/autorizationFinished';

main() {
	var authentication = new ClientAuthentication(consumerKey);

	var requestToken;

	authentication.getRequestToken(redirectUrl).then((code) {
		requestToken = code;

		var url = ClientAuthentication.getAuthorizeUrl(requestToken, redirectUrl);
		// work whatever redirect magic you need here
	});

	//..

	authentication.getAccessToken(requestToken).then(onAuthorizationFinished);
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

Please fill feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Ne4istb/pocket_client/issues


## License

pocket\_client is distributed under the [BSD license](https://github.com/Ne4istb/pocket_client/blob/master/LICENSE).



