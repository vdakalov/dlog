// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example;

import "dart:math" as Math;
import 'package:dlog/dlog.dart' as DLog;

double rad(num deg) =>
  deg * (Math.PI / 180);

main() {

  // create new table and specify number of columns
  var debug = new DLog.Table.fromHeader(
              ["DEG°", "RADIAN", "NORMAL"]);

  // add more header
  debug.columns.addAll(["VECTOR (X, Y)"]);

  for (int angle = 0; angle < 360; angle++) {
    double x = 1 * Math.cos(rad(angle)),
           y = 1 * Math.sin(rad(angle)),
           normal = 1.0 * x + 0.0 * y;

    // add row (count of cell eq debug.columns.length)
    debug.data.addAll([angle, rad(angle), normal, [x,y]]);
  }

  var pi = debug.clone().crop(0, 180),
      pi2 = debug.clone().crop(180, 180);

  // output to console
  print(debug);

  // output range 0-179
  print(pi);

  // output range 180-359
  print(pi2);

}