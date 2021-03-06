library pocket_client.action_results_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class TestAction extends Action {
  TestAction(int itemId, {DateTime time}) : super('test', itemId, time: time);
}

class TestTagsAction extends TagsAction {
  TestTagsAction(int itemId, List<String> tags, {DateTime time}) : super('test_tags', itemId, tags, time: time);
}

class ActionsTests {
  static void run() {
    group('ActionResults.fromJSON()', () {
      test('Should convert json string to pocket action results with errors', () {
        const String json = '{"action_results":[true, false, true],"status":0}';

        ActionResults actualData = new ActionResults.fromJSON(json);

        expect(actualData.hasErrors, true);
        expect(actualData.results, [true, false, true]);
      });

      test('Should convert json string to pocket action results without errors', () {
        const String json = '{"action_results":[true, true, true],"status":1}';

        ActionResults actualData = new ActionResults.fromJSON(json);

        expect(actualData.hasErrors, false);
        expect(actualData.results, [true, true, true]);
      });
    });

    group('Action', () {
      test('Should convert action with time to json', () {
        TestAction action = new TestAction(1234, time: new DateTime.fromMillisecondsSinceEpoch(1430686800000));

        Map<String, String> actualData = action.toMap();

        expect(actualData['action'], 'test');
        expect(actualData['item_id'], '1234');
        expect(actualData['time'], '1430686800000');
      });

      test('Should convert action without time to json', () {
        TestAction action = new TestAction(1234);

        Map<String, String> actualData = action.toMap();

        expect(actualData['action'], 'test');
        expect(actualData['item_id'], '1234');
      });
    });

    group('Tags Action', () {
      test('Should convert action to json', () {
        TestTagsAction action =
            new TestTagsAction(1234, ['tag1', 'tag2'], time: new DateTime.fromMillisecondsSinceEpoch(1430686800000));

        Map<String, String> actualData = action.toMap();

        expect(actualData['action'], 'test_tags');
        expect(actualData['item_id'], '1234');
        expect(actualData['tags'], 'tag1, tag2');
        expect(actualData['time'], '1430686800000');
      });
    });

    group('Add Action', () {
      test('Should convert action to json', () {
        AddAction action = new AddAction(1234,
            tweetId: '12324566',
            tags: ['1232346', 'newtag'],
            title: 'Some title',
            url: 'http://test.com/123',
            time: new DateTime.fromMillisecondsSinceEpoch(1430686800000));

        Map<String, String> actualData = action.toMap();

        expect(actualData['action'], 'add');
        expect(actualData['item_id'], '1234');
        expect(actualData['ref_id'], '12324566');
        expect(actualData['tags'], '1232346, newtag');
        expect(actualData['title'], 'Some title');
        expect(actualData['url'], 'http://test.com/123');
        expect(actualData['time'], '1430686800000');
      });
    });
  }
}

void main() {
  ActionsTests.run();
}
