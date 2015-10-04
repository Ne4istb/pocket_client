// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.test;

import 'authentication_test.dart';
import 'client_base_test.dart';
import 'client_test.dart';
import 'user_test.dart';
import 'pocket_data_test.dart';
import 'tag_test.dart';
import 'author_test.dart';
import 'video_data_test.dart';
import 'image_data_test.dart';
import 'retrieve_options_test.dart';
import 'pocket_response_test.dart';
import 'item_to_add_test.dart';
import 'actions_test.dart';

void main() {
  AuthenticationTests.run();
  ClientBaseTests.run();
  ClientTests.run();
  UserTests.run();
  RetrieveOptionsTests.run();
  PocketDataTests.run();
  VideoDataTests.run();
  ImageDataTests.run();
  TagTests.run();
  AuthorTests.run();
  PocketResponseTests.run();
  ItemToAddTests.run();
  ActionsTests.run();
}
