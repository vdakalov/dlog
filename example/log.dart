// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example;

import "dart:math" as Math;
import "package:dlog/dlog.dart" as dlog;
import "dart:convert";

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

getJSON() {
  var data = '''
[
  {
    "_id": "54bde2ec6d0c45fe2aad89a1",
    "index": 0,
    "guid": "391ad3b0-e003-44fe-8f52-9a53b0d2ce52",
    "isActive": true,
    "balance": "\$3,385.54",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "blue",
    "name": "Burns Avery",
    "gender": "male",
    "company": "COMTRAIL",
    "email": "burnsavery@comtrail.com",
    "phone": "+1 (829) 415-3400",
    "address": "496 Hemlock Street, Hegins, New Mexico, 4698",
    "about": "Qui ex labore irure proident aute veniam sit minim Lorem irure. Est officia quis amet dolor duis velit pariatur culpa elit in aliqua aute magna. Occaecat et proident ut ea sit dolore aliquip. Ipsum minim esse ad et deserunt. Ad sit amet occaecat sint. Ipsum anim commodo ex eiusmod reprehenderit exercitation sit mollit proident aliqua. Occaecat reprehenderit mollit voluptate tempor nostrud qui anim veniam est laboris qui pariatur.\r\n",
    "registered": "2014-09-19T00:05:13 -05:00",
    "latitude": -2.302439,
    "longitude": 92.194414,
    "tags": [
      "commodo",
      "eu",
      "deserunt",
      "quis",
      "dolor",
      "nulla",
      "ad"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Katheryn Rogers"
      },
      {
        "id": 1,
        "name": "Corine Smith"
      },
      {
        "id": 2,
        "name": "Jacobson Christensen"
      }
    ],
    "greeting": "Hello, Burns Avery! You have 3 unread messages.",
    "favoriteFruit": "strawberry"
  }
]
'''.replaceAll(new RegExp("\n|\r"), "");
  return JSON.decode(data);
}

main() {

  /**************************************
   * Json
   */

  // create Json object and
  var json = new dlog.Json(
      title: "My",
      data: new List()
  );

  json.data = getJSON();
  json.title += " json";

  // max length for string (set null for output full string)
  json.maxStringLen = 50;

  // custom data parsers (custom parsers for List, Map and String types will be ignored)
  json.parsers["int"] = (int num) => "$num <-- int";

  // output
  print(json);


  /**************************************
   * Tree
   */

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

//  users_tree.closeGroup();
  print(users_tree..closeGroup());

  var tree = new dlog.Tree<int>("Simple tree [int only]")

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

  /**************************************
   * Table
   */

  // create new table and specify the column number
  var table = new dlog.Table(1);

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
