// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.test;

import 'authorization_test.dart';
import 'client_base_test.dart';
import 'client_test.dart';
import 'pocket_user_test.dart';
import 'pocket_data_test.dart';
import 'pocket_tag_test.dart';
import 'pocket_author_test.dart';
import 'pocket_video_data_test.dart';
import 'pocket_image_data_test.dart';
import 'pocket_retrieve_options_test.dart';
import 'pocket_response_test.dart';

void main() {
  AuthorizationTests.run();
  ClientBaseTests.run();
  ClientTests.run();
  PocketUserTests.run();
  PocketRetrieveOptionsTests.run();
  PocketDataTests.run();
  PocketVideoDataTests.run();
  PocketImageDataTests.run();
  PocketTagTests.run();
  PocketAuthorTests.run();
  PocketResponseTests.run();
}
