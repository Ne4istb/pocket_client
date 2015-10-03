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

	String action;
	int itemId;
	DateTime time;

	Action(this.action, this.itemId, {this.time});

	Map<String, String> toMap() {

		Map<String, String> result = {
			'action': action,
			'item_id' : itemId.toString()
		};

		if (time != null)
			result['time'] = time.millisecondsSinceEpoch.toString();

		return result;
	}
}

class ArchiveAction extends Action {
	ArchiveAction(itemId, {time}) : super('archive', itemId, time: time);
}

class ReAddAction extends Action {
	ReAddAction(itemId, {time}) : super('readd', itemId, time: time);
}

class FavoriteAction extends Action {
	FavoriteAction(itemId, {time}) : super('favorite', itemId, time: time);
}

class UnFavoriteAction extends Action {
	UnFavoriteAction(itemId, {time}) : super('unfavorite', itemId, time: time);
}

class DeleteAction extends Action {
	DeleteAction(itemId, {time}) : super('delete', itemId, time: time);
}

class ClearTagsAction extends Action {
	ClearTagsAction(itemId, {time}) : super('tags_clear', itemId, time: time);
}

class RenameTagAction extends Action {

	String oldTag;
	String newTag;

	RenameTagAction(int itemId, this.oldTag, this.newTag, {DateTime time}) : super('tag_rename', itemId, time: time);

	Map<String, String> toMap() {
		return super.toMap()
			..['old_tag'] = oldTag
			..['new_tag'] = newTag;
	}
}

abstract class TagsAction extends Action {

	List<String> tags;

	TagsAction(String action, int itemId, this.tags, {DateTime time}) : super(action, itemId, time: time);

	Map<String, String> toMap() {
		return super.toMap()..['tags'] = tags.join(', ');
	}
}

class AddTagsAction extends TagsAction{
  AddTagsAction(int itemId, List<String> tags, {time}) : super('tags_add', itemId, tags, time: time);
}

class RemoveTagsAction extends TagsAction{
	RemoveTagsAction(int itemId, List<String> tags, {time}) : super('tags_remove', itemId, tags, time: time);
}

class ReplaceTagsAction extends TagsAction{
	ReplaceTagsAction(int itemId, List<String> tags, {time}) : super('tags_replace', itemId, tags, time: time);
}

