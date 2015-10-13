# pocket_client

A library for authenticating and accessing the Pocket API from Dart

## Quick start

###### Authentication:
```dart
import 'package:pocket_client/pocket_client.dart';

const consumerKey = '1234-abcd1234abcd1234abcd1234';
const redirectUrl = 'http://some.redirect.uri/autorizationFinished';

main() async {
  var authentication = new ClientAuthentication(consumerKey);

  var requestToken = await authentication.getRequestToken(redirectUrl)

  var url = ClientAuthentication.getAuthorizeUrl(requestToken, redirectUrl);
  
  // work whatever redirect magic you need here

  await authentication.getAccessToken(requestToken)
  onAuthorizationFinished();
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

main() async {
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
  
  // do whatever you want with pocket items
  Map<String, PocketData> items = response.items;
  
  var newItem = new ItemToAdd('http://www.funnycatpix.com/')
    ..title = 'FUNNY CAT PICTURES'
    ..tweetId = '123456'
    ..tags = ['cats', 'cool', 'share'];

  // do whatever you want with received data
  PocketData data = client.addItem(newItem);
}
```

## Api

See the [Api documentation](https://github.com/Ne4istb/pocket_client/blob/master/API.md).

## Examples

The basic example is in [example file](https://github.com/Ne4istb/pocket_client/blob/master/example/pocket_client.dart)

## Features and bugs

Please fill feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Ne4istb/pocket_client/issues

## License

pocket_client is distributed under the [BSD license](https://github.com/Ne4istb/pocket_client/blob/master/LICENSE).
