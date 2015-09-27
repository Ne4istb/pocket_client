// Copyright (c) 2015, Ne4istb. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library pocket_client.test;

import 'authorization_test.dart';
import 'pocket_user_test.dart';

void main() {
  AuthorizationTests.run();
  PocketUserTests.run();
}
