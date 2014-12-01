// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library deluxjs.example;

import 'package:deluxjs/deluxjs.dart';

main() {
  Action testAction = new Action(eventLabel: "actionTest", sync: true);
  testAction();
  Function unsubscribe = testAction.listen(() => (print("TEST!")));
  testAction();
  unsubscribe();
  testAction();


}
