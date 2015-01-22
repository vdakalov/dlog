// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example.time;

import "dart:math";
import "package:dlog/dlog.dart" as dlog;

// a function that is performed for a long time
power() {
  int len = 1000;
  while (len-- > 0) {
    sqrt(pow(new Random().nextDouble(), new Random().nextDouble()));
  }
}

power2() {
  power();
}

power3() {
  power();
}

main() {

  // create Time object and specity descrption
  // object can be used throughout the application
  var debug = new dlog.Time("Cycle")..init();

  // call check after separated logic operation
  debug.checkFunc("once call power", power);

  // call power several times
  debug.checkLoopFunc("call power in loop 10", 10, power3);

  // output
  print(debug);

}
