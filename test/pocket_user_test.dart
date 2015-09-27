
library pocket_client.user_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class PocketUserTests {

  static run() {
    test('PocketUser. Should convert json string to pocket user data', () {

      const json = '{"username":"Ne4istb", "access_token": "5678defg-5678-defg-5678-defg56"}';

      var actualData = new PocketUser.fromJSON(json);

      expect(actualData.userName, 'Ne4istb');
      expect(actualData.accessToken, '5678defg-5678-defg-5678-defg56');
    });
  }
}