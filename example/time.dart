// Copyright (c) 2015, Viktor Dakalov. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dlog.example.time;

import "dart:math";
import "package:dlog/dlog.dart" as dlog;

sleep() {
  DateTime init = new DateTime.now();
  int ms = 1500;
  while (ms > new DateTime.now().difference(init).inMilliseconds);
}

main() {

  // create Time object and specity descrption
  // object can be used throughout the application
  var debug = new dlog.Time("Time test for power function");

  // call check before a separate logical operation
  debug.checkBegin("complex random");

  // some logic
  int len = 1000;
  while (len-- > 0) {
    sqrt(pow(new Random().nextDouble(), new Random().nextDouble()) * new Random().nextDouble());
  }

  // and after completion
  debug.checkEnd("complex random");

  // same as above
  debug.checkFunc("sleep function", sleep);

  debug.checkFunc("check power speed", (){
    for (int i = 0; i < 100000; i++) {
      pow(i, 100);
    }
  });

  // output
  print(debug);

}
