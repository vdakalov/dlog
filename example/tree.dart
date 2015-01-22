// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example.tree;

import "package:dlog/dlog.dart" as dlog;

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

  var users_tree = new dlog.Tree("Users");
  users_tree.openGroup();

  for (int i = 0; i < users.length; i++) {
    users_tree..add(users[i]["name"])
              ..openGroup()
              ..add("age: ${users[i]["age"]}")
              ..add("city: ${users[i]["city"]}")
              ..closeGroup()
              ;
  }

  // users_tree.closeGroup();
  print(users_tree..closeGroup());

}
