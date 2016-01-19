
library pocket_client.user_test;

import 'package:pocket_client/pocket_client.dart';
import 'package:test/test.dart';

class UserTests {

  static run() {
    test('User. Should convert json string to pocket user data', () {

      const json = '{"username":"Ne4istb", "access_token": "5678defg-5678-defg-5678-defg56"}';

      var actualData = new User.fromJSON(json);

      expect(actualData.userName, 'Ne4istb');
      expect(actualData.accessToken, '5678defg-5678-defg-5678-defg56');
    });

    test('User. Should create user data', () {

      var actualData = new User('Ne4istb', '5678defg-5678-defg-5678-defg56');

      expect(actualData.userName, 'Ne4istb');
      expect(actualData.accessToken, '5678defg-5678-defg-5678-defg56');
    });
  }
}

void main() {
	UserTests.run();
}