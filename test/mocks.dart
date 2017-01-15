library pocket_client.mocks;

import 'dart:async';
import 'package:test/test.dart';

import 'package:http/http.dart';
import 'package:http/testing.dart';

class Mocks {
  static MockClient httpClient(Response response, String url, Function assertBody) {
    return new MockClient((Request request) {
      expect(request.url.toString(), url);
      expect(request.method, 'POST');
      assertBody(request.body);

      return new Future<Response>.value(response);
    });
  }
}
