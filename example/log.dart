// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example;

import "dart:math" as Math;
import 'package:dlog/dlog.dart' as DLog;

double rad(num deg) =>
  deg * (Math.PI / 180);

List<Map> users = [
  {
    "name": "Dmitry",
    "age": 23,
    "city": "Yekaterinburg"
  },
  {
    "name": "Vasya",
    "age": 28,
    "city": "Moskow"
  }
];

main() {

  var users_tree = new DLog.Tree("Users");

  users_tree.openGroup();

  for (int i = 0; i < users.length; i++) {
    users_tree..add(users[i]["name"])
              ..openGroup()
              ..add("age: ${users[i]["age"]}")
              ..add("city: ${users[i]["city"]}")
              ..closeGroup()
              ;
  }

//  users_tree.closeGroup();
  print(users_tree..closeGroup());

  var tree = new DLog.Tree<int>("Simple tree [int only]")

      // open main group
      ..openGroup()
        // add item
        ..add(1)
        // title for this group is previous item
        ..openGroup()
          // sub items for item "1"
          ..add(11)
          ..add(12)
          ..openGroup()
            ..add(121)
          // clone group
          ..closeGroup()
          ..add(13)
        ..closeGroup()
      // close main group
      ..closeGroup()
      ;

  // output tree
  print(tree);

  // create new table and specify the column number
  var table = new DLog.Table(1);

  // you can add header names (optional)
  // in this case the number of columns is changed to 3
  table.columns.add("deg°");
  table.columns.addAll(["radian", "vector (x, y)"]);

  for (int angle = 0; angle < 360; angle++) {

    String x = (1 * Math.sin(angle)).toStringAsFixed(4),
           y = (1 * Math.cos(angle)).toStringAsFixed(4);

    // add row (number of cell equal columns number)
    table.data.addAll([
      angle,       // deg°
      rad(angle),  // radian
      [x, y]       // vector (x, y)
    ]);
  }

  // cut part of table
  var pi = table.clone().crop(0, 180),
      pi2 = table.clone().crop(180, 180);

  // output to console
  print(table);

  // output range 0-179
  print(pi);

  // output range 180-359
  print(pi2);

}
