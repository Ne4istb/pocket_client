library pocket_client.item_to_add;

class ItemToAdd {

	String url;
	String title;
	List<String> tags;
	String tweetId;

	ItemToAdd(this.url, {this.title, this.tags, this.tweetId});

	Map<String, String> toMap() {
		Map<String, String> result = new Map<String, String>();

		result['url'] = Uri.encodeFull(url);

		if (title != null && title.isNotEmpty)
			result['title'] = Uri.encodeComponent(title);

		if (tweetId != null && tweetId.isNotEmpty)
			result['tweet_id'] = tweetId;

		if (tags != null && tags.length > 0)
			result['tags'] = tags.join(', ');

		return result;
	}
}