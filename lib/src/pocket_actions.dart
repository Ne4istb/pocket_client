library pocket_client.actions;

import 'dart:convert';

class PocketActionResults {

	bool hasErrors;
	List<bool> results;

	PocketActionResults.fromJSON(String jsonString) {
		Map json = JSON.decode(jsonString);
		hasErrors = json['status'] == 0;
		results = json['action_results'];
	}
}

abstract class PocketAction {

	String actionName;
	int itemId;
	DateTime time;

	PocketAction(this.actionName, this.itemId, {this.time});

	Map<String, String> toMap() {

		Map<String, String> result = {};

		result['action'] = actionName;
		result['item_id'] = itemId.toString();

		if (time != null)
			result['time'] = time.millisecondsSinceEpoch.toString();

		return result;
	}
}

class PocketArchiveAction extends PocketAction{
	PocketArchiveAction(itemId, {time}): super('archive', itemId, time: time);
}

class PocketReAddAction extends PocketAction{
	PocketReAddAction(itemId, {time}): super('readd', itemId, time: time);
}

class PocketFavoriteAction extends PocketAction{
	PocketFavoriteAction(itemId, {time}): super('favorite', itemId, time: time);
}

class PocketUnFavoriteAction extends PocketAction{
	PocketUnFavoriteAction(itemId, {time}): super('unfavorite', itemId, time: time);
}

class PocketDeleteAction extends PocketAction{
	PocketDeleteAction(itemId, {time}): super('delete', itemId, time: time);
}

class PocketClearTagsAction extends PocketAction{
	PocketClearTagsAction(itemId, {time}): super('tags_clear', itemId, time: time);
}