// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library log.example;

import 'package:log/log.dart' as Log;

gen(int rows, int cols, List target) {
  cols = rows * cols;
  while (rows-- > 0) {
    while (cols-- > 0) {
      target.add("$rows-$cols");
    }
  }
}

main() {

  var someData = {
    "Vasya": 21,
    "Vanya": 27,
    "Nikolay": 30
  };

  // create table without header (3 column)
  var debugNames = new Log.Table(2);

  // specity header (optional)
  // this number of overwrite what was specified in the constructor,
  // and vice versa
  debugNames.columns.addAll(["#", "name", "chars", "age"]);

  // set data
  int index = 1;
  someData.forEach((name, age){
    // the number of times specified in constructor or columns
    // the remainder will be skipped
    // > numSkipped = data.length % (columns.length|size)
    debugNames.data.addAll([index++, name, name.length, age]);
  });

  // output for debugging :)
  print(debugNames);

  Log.Table t1 = new Log.Table(3);
  t1.columns.addAll(["1","2","3"]);
  gen(10, 3, t1.data);
  print(t1);

  // Dartium (win8-64 i5 34GHz/8Gb): 50000 rows and 4 column = ~315ms
  // (output in the console will be slower)

//  ┌───┬─────────┬───────┬─────┐
//  │ # │ NAME    │ CHARS │ AGE │
//  ├───┼─────────┼───────┼─────┤
//  │ 1 │ Vasya   │ 5     │ 21  │
//  ├───┼─────────┼───────┼─────┤
//  │ 2 │ Vanya   │ 5     │ 27  │
//  ├───┼─────────┼───────┼─────┤
//  │ 3 │ Nikolay │ 7     │ 30  │
//  └───┴─────────┴───────┴─────┘


}
