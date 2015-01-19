// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example;

import "dart:math" as Math;
import 'package:dlog/dlog.dart' as DLog;

double rad(num deg) =>
  deg * (Math.PI / 180);

main() {

  var tree = new DLog.Tree<int>(title: "Simple tree [int only]")
      ..openGroup()
        ..add(1)
        ..openGroup()
          ..add(11)
          ..add(12)
          ..openGroup()
            ..add(121)
          ..closeGroup()
          ..add(13)
        ..closeGroup()
      ..closeGroup();

  print(tree);

  // create new table and specify number of columns
  var debug = new DLog.Table.fromHeader(["DEG°"]);

  // add more header
  debug.columns.addAll(["RADIAN"]);

  for (int angle = 0; angle < 360; angle++) {

    // add row (count of cell eq debug.columns.length)
    debug.data.addAll([angle, rad(angle)]);
  }

  var pi = debug.clone().crop(0, 180),
      pi2 = debug.clone().crop(180, 180);

  // output to console
  print(debug);

  // output range 0-179
//  print(pi);

  // output range 180-359
//  print(pi2);

}