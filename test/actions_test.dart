library pocket_client.action_results_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class TestAction extends Action{
  TestAction(int itemId, {DateTime time}) : super('test', itemId, time: time);
}

class TestTagsAction extends TagsAction{
	TestTagsAction(int itemId, List<String> tags, {DateTime time}) : super('test_tags', itemId, tags, time: time);
}

class ActionsTests {

  static run() {
	  group('ActionResults.fromJSON()', () {
		  test('Should convert json string to pocket action results with errors', () {
			  const json = '{"action_results":[true, false, true],"status":0}';

			  var actualData = new ActionResults.fromJSON(json);

			  expect(actualData.hasErrors, true);
			  expect(actualData.results, [true, false, true]);
		  });

		  test('Should convert json string to pocket action results without errors', () {
			  const json = '{"action_results":[true, true, true],"status":1}';

			  var actualData = new ActionResults.fromJSON(json);

			  expect(actualData.hasErrors, false);
			  expect(actualData.results, [true, true, true]);
		  });
	  });

	  group('Action', () {

		  test('Should convert action with time to json', () {

			  var action = new TestAction(1234, time: new DateTime.fromMillisecondsSinceEpoch(1430686800000));

			  var actualData = action.toMap();

			  expect(actualData['action'], 'test');
			  expect(actualData['item_id'], '1234');
			  expect(actualData['time'], '1430686800000');
		  });

		  test('Should convert action without time to json', () {

			  var action = new TestAction(1234);

			  var actualData = action.toMap();

			  expect(actualData['action'], 'test');
			  expect(actualData['item_id'], '1234');
		  });

	  });

	  group('Tags Action', () {

		  test('Should convert action to json', () {

			  var action = new TestTagsAction(1234, ['tag1', 'tag2'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800000));

			  var actualData = action.toMap();

			  expect(actualData['action'], 'test_tags');
			  expect(actualData['item_id'], '1234');
			  expect(actualData['tags'], 'tag1, tag2');
			  expect(actualData['time'], '1430686800000');
		  });
	  });
  }
}

void main() {
	ActionsTests.run();
}