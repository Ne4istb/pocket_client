library pocket_client.actions;

import 'dart:convert';

class ActionResults {

	bool hasErrors;
	List<bool> results;

	ActionResults.fromJSON(String jsonString) {
		Map json = JSON.decode(jsonString);
		hasErrors = json['status'] == 0;
		results = json['action_results'];
	}
}

abstract class Action {

	String actionName;
	int itemId;
	DateTime time;

	Action(this.actionName, this.itemId, {this.time});

	Map<String, String> toMap() {

		Map<String, String> result = {};

		result['action'] = actionName;
		result['item_id'] = itemId.toString();

		if (time != null)
			result['time'] = time.millisecondsSinceEpoch.toString();

		return result;
	}
}

class ArchiveAction extends Action{
	ArchiveAction(itemId, {time}): super('archive', itemId, time: time);
}

class ReAddAction extends Action{
	ReAddAction(itemId, {time}): super('readd', itemId, time: time);
}

class FavoriteAction extends Action{
	FavoriteAction(itemId, {time}): super('favorite', itemId, time: time);
}

class UnFavoriteAction extends Action{
	UnFavoriteAction(itemId, {time}): super('unfavorite', itemId, time: time);
}

class DeleteAction extends Action{
	DeleteAction(itemId, {time}): super('delete', itemId, time: time);
}

class ClearTagsAction extends Action{
	ClearTagsAction(itemId, {time}): super('tags_clear', itemId, time: time);
}