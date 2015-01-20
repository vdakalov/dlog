// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:unittest/unittest.dart';
import 'package:dlog/dlog.dart';

main() {

  test("Tree flat", (){

    var tree = new Tree("Tree flat");
    var output = [
      'Tree flat',
      '│ ├ 0',
      '│ ├ 1',
      '│ ├ 2',
      '│ ├ 3',
      '│ ├ 4',
      '│ ├ 5',
      '│ ├ 6',
      '│ ├ 7',
      '│ ├ 8',
      '│ └ 9',
      ''
    ];

    tree.openGroup();
    for (int i = 0; i < 10; i++) {
      tree.add(i);
    }
    tree.closeGroup();

    expect(tree.toString(), output.join(tree.endOfLineUnicode));

  });

  test("Tree 3x3", (){

    var tree = new Tree("Tree 3x3");
    var output = [
      'Tree 3x3\n'
      '│ ├ 0\n'
      '│ │ ├ 0x0\n'
      '│ │ ├ 0x1\n'
      '│ │ └ 0x2\n'
      '│ ├ 1\n'
      '│ │ ├ 1x0\n'
      '│ │ ├ 1x1\n'
      '│ │ └ 1x2\n'
      '│ ├ 2\n'
      '│ │ ├ 2x0\n'
      '│ │ ├ 2x1\n'
      '│ │ └ 2x2\n'
      ''
    ];

    tree.openGroup();

    for (int i = 0; i < 3; i++) {
      tree.add(i);
      tree.openGroup();
      for (int j = 0; j < 3; j++) {
        tree.add("${i}x${j}");
      }
      tree.closeGroup();
    }

    tree.closeGroup();

    // TODO join separator is not working on unknown reason
    expect(tree.toString(), output.join());

  });

}