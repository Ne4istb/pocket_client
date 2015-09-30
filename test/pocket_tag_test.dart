library pocket_client.tag_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketTagTests {

  static run() {
    test('PocketTag. Should convert json string to pocket tag data', () {

      const json = '{"item_id":"1052437824","tag":"digest"}';

      var actualData = new PocketTag.fromJSON(json);

      expect(actualData.itemId, '1052437824');
      expect(actualData.tag, 'digest');
    });
  }
}

void main() {
	PocketTagTests.run();
}