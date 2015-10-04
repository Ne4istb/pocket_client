# API

## Authentication

The Pocket Authentication API uses a variant of OAuth 2.0 for authentication. OAuth 2.0 is meant to be straightforward to implement, and also provides increased security for user authentication because 3rd party client apps no longer need to request or store a user's login information to authenticate with Pocket.
Check [Pocket Authentication API](https://getpocket.com/developer/docs/authentication) for more details.
 
####You have to do several steps to authorize in Pocket:
#####Step 1. Obtain a Platform Consumer Key
#####Step 2. Get a request token
```dart
var authentication = new ClientAuthentication(consumerKey);

authentication.getRequestToken(redirectUrl).then((requestToken) {
	//...
});
```

#####Step 3: Get authorization url to redirect user to Pocket to continue authorization
You can do it using the request token recieved in step 2
 ```dart
var url = ClientAuthentication.getAuthorizeUrl(requestToken, redirectUrl);
// provide this url to user 
```

#####Step 4: Receive the callback from Pocket
When the user has authorized (or rejected) your application's request token, Pocket will return the user to your application by opening the redirectUrl that you provided in step 2.

#####Step 5: Convert a request token into a Pocket access token
When user is authorized in Pocket you can convert the request token to an access token
 ```dart
authentication.getAccessToken(requestToken).then((userData) {
	var accessToken = userData.accessToken;
	var userName = userData.userNAme;
	// use this data to work with Pocket
});
```	

## Pocket Client
Once you got access token you can create Pocket client
```dart
var client = new Client(consumerKey, accessToken);
```

######Here is the list of available methods. All methods are async and return Future: 

| Method             |  Description
|--------------------|------------------
| getData({RetrieveOptions options})   | get list of pocket items base on retrieve options
| addItem(ItemToAdd newItem)           | add new item
| addUrl(String newUrl)                | add new item based on provided url
| modify(List<Action> actions)         | bulk modification of pocket items based on provided list of actions
| archive(int itemId, {DateTime time}) | move an item to the user's archive
| delete(int itemId, {DateTime time}) | permanently remove an item from the user's account
| favorite(int itemId, {DateTime time}) | mark an item as a favorite
| unFavorite(int itemId, {DateTime time}) | remove an item from the user's favorites  
| reAdd(int itemId, {DateTime time}) | move an item from the user's archive back into their unread list
| clearTags(int itemId, {DateTime time}) | remove all tags from an item
| addTags(int itemId, List<String> tags, {DateTime time}) | add one or more tags to an item
| removeTags(int itemId, List<String> tags, {DateTime time}) | remove one or more tags from an item
| replaceTags(int itemId, List<String> tags, {DateTime time}) | replace all of the tags for an item with the one or more provided tags
| renameTag(int itemId, String oldTag, String newTag, {DateTime time}) | rename a tag. This affects all items with this tag

######Here is the list of available actions: 
|Action|
|------|
|AddAction|
|ArchiveAction|
|ReAddAction|
|FavoriteAction|
|UnFavoriteAction|
|DeleteAction|
|ClearTagsAction|
|RenameTagAction|
|AddTagsAction|
|RemoveTagsAction|
|ReplaceTagsAction|


###Examples

##### getData({RetrieveOptions options})
```dart
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
```

##### addItem(ItemToAdd newItem)
```dart
var newItem = new ItemToAdd('http://www.funnycatpix.com/')
	..title = 'FUNNY CAT PICTURES'
	..tweetId = '123456'
	..tags = ['cats', 'cool', 'share'];

client.addItem(newItem).then((PocketData data) {
	// do whatever you want with received data
});
```

##### addItem(ItemToAdd newItem)
```dart
client.addUrl(newUrl).then((PocketData data) {
	// do whatever you want with received data
});
```

##### modify(List<Action> actions)  
```dart
var actions = [
	new DeleteAction(12340, time: new DateTime.fromMillisecondsSinceEpoch(1430686800000)),
	new ArchiveAction(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001)),
	new FavoriteAction(12342, time: new DateTime.fromMillisecondsSinceEpoch(1430686800002))
];

client.modify(actions).then((ActionResults result) {
	// ...
});
```

##### archive(int itemId, {DateTime time})
```dart
client
	.archive(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### delete(int itemId, {DateTime time})
```dart
client
	.delete(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### favorite(int itemId, {DateTime time})
```dart
client
	.favorite(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### unFavorite(int itemId, {DateTime time})
```dart
client
	.unFavorite(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### reAdd(int itemId, {DateTime time})
```dart
client
	.reAdd(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### clearTags(int itemId, {DateTime time})
```dart
client
	.clearTags(12341, time: new DateTime.fromMillisecondsSinceEpoch(1430686800001))
	.then((ActionResults result) {
		// ...
	});
```

##### addTags(int itemId, List<String> tags, {DateTime time})
```dart
client
	.addTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
	.then((ActionResults result) {
		// ...
	});
```

##### removeTags(int itemId, List<String> tags, {DateTime time})
```dart
client
	.removeTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
	.then((ActionResults result) {
		// ...
	});
```

##### replaceTags(int itemId, List<String> tags, {DateTime time})
```dart
client
	.replaceTags(12346, ['firstTag', 'secondTag'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
	.then((ActionResults result) {
		// ...
	});
```

##### renameTag(int itemId, String oldTag, String newTag, {DateTime time})
```dart
client
	.renameTag(12346, 'firstTag', 'secondTag', time: new DateTime.fromMillisecondsSinceEpoch(1430686800006))
	.then((ActionResults result) {
		// ...
	});
```



