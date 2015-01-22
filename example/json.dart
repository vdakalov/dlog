// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example.json;

import "package:dlog/dlog.dart" as dlog;
import "dart:convert";

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

  // create Json object and
  var debug = new dlog.Json(
      title: "My",
      data: new List()
  );

  debug.data = getJSON();
  debug.title += " json";

  // max length for string (set null for output full string)
  debug.maxStringLen = 50;

  // custom data parsers (custom parsers for List, Map and String types will be ignored)
  debug.parsers["int"] = (int num) => "$num <-- int";

  // output
  print(debug);

  // no clear buffer [by default: true]
  debug.flush = false;
  debug.maxStringLen = 10;
  print(debug);

}
