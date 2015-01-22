# dlog

A useful library for output structured information of debugging into console

## Usage

The information can be structured as a table, tree or json. So it is possible to measure the performance of a function or piece of code.

### Table

    import "dart:math" as Math;
    import 'package:dlog/dlog.dart' as dlog;
    
    double rad(num deg) =>
      deg * (Math.PI / 180);
    
    main() {
    
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

Result:

    ┌──────┬──────────────────────┬────────────────────┐
    │ DEG° │ RADIAN               │ VECTOR (X, Y)      │
    ├──────┼──────────────────────┼────────────────────┤
    │ 0    │ 0.0                  │ [0.0000, 1.0000]   │
    ├──────┼──────────────────────┼────────────────────┤
    │ 1    │ 0.017453292519943295 │ [0.8415, 0.5403]   │
    ├──────┼──────────────────────┼────────────────────┤
    │ 2    │ 0.03490658503988659  │ [0.9093, -0.4161]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 3    │ 0.05235987755982989  │ [0.1411, -0.9900]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 4    │ 0.06981317007977318  │ [-0.7568, -0.6536] │
    ├──────┼──────────────────────┼────────────────────┤
    │ 5    │ 0.08726646259971647  │ [-0.9589, 0.2837]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 6    │ 0.10471975511965978  │ [-0.2794, 0.9602]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 7    │ 0.12217304763960307  │ [0.6570, 0.7539]   │
    ├──────┼──────────────────────┼────────────────────┤
    │ 8    │ 0.13962634015954636  │ [0.9894, -0.1455]  │
    ├──────┼──────────────────────┼────────────────────┤
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ├──────┼──────────────────────┼────────────────────┤
    │ 354  │ 6.178465552059927    │ [0.8415, -0.5403]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 355  │ 6.19591884457987     │ [-0.0000, -1.0000] │
    ├──────┼──────────────────────┼────────────────────┤
    │ 356  │ 6.213372137099813    │ [-0.8415, -0.5403] │
    ├──────┼──────────────────────┼────────────────────┤
    │ 357  │ 6.230825429619756    │ [-0.9093, 0.4162]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 358  │ 6.2482787221397      │ [-0.1411, 0.9900]  │
    ├──────┼──────────────────────┼────────────────────┤
    │ 359  │ 6.265732014659643    │ [0.7568, 0.6536]   │
    └──────┴──────────────────────┴────────────────────┘

### Tree

    import 'package:dlog/dlog.dart' as dlog;
    
    List<Map> users = [
      {
        "name": "Dmitry",
        "age": 23,
        "city": "Yekaterinburg"
      },
      {
        "name": "Alexandr",
        "age": 28,
        "city": "Moskow"
      }
    ];
    
    main() {
      
      var tree = new dlog.Tree("Users");
      
      // required opening root group
      tree.openGroup();
      
      for (int i = 0; i < users.length; i++) {
          tree
              // add name
              ..add(users[i]["name"])
              
              // open user group
              // (previous element is the name of the group following)
              ..openGroup()
              
              // subitems
              ..add("age: ${users[i]["age"]}")
              ..add("city: ${users[i]["city"]}")
              
              // close user group
              ..closeGroup()
              ;
      }
      
      // close root group and output in console
      print(tree..closeGroup());
    }

Result

    Users
    │ ├ Dmitry
    │ │ ├ age: 23
    │ │ └ city: Yekaterinburg
    │ ├ Alexandr
    │ │ ├ age: 28
    │ │ └ city: Moskow

### Json
    
    import "package:dlog/dlog.dart" as dlog;
    import "dart:convert";
    
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

      // no clear buffer [by default: true]
      debug.flush = false;
    
      // output
      print(debug);
    
    }
    

Result

    My json
    [
      0: {
        _id: "54bde2ec6d0c45fe2aad89a1",
        index: 0 <-- int,
        guid: "391ad3b0-e003-44fe-8f52-9a53b0d2ce52",
        isActive: true,
        balance: "$3,385.54",
        picture: "http://placehold.it/32x32",
        age: 25 <-- int,
        eyeColor: "blue",
        name: "Burns Avery",
        gender: "male",
        company: "COMTRAIL",
        email: "burnsavery@comtrail.com",
        phone: "+1 (829) 415-3400",
        address: "496 Hemlock Street, Hegins, New Mexico, 4698",
        about: "Qui ex labore irure proident aute veniam sit minim...",
        registered: "2014-09-19T00:05:13 -05:00",
        latitude: -2.302439,
        longitude: 92.194414,
        tags: [
          0: "commodo",
          1: "eu",
          2: "deserunt",
          3: "quis",
          4: "dolor",
          5: "nulla",
          6: "ad"
        ],
        friends: [
          0: {
            id: 0 <-- int,
            name: "Katheryn Rogers"
          },
          1: {
            id: 1 <-- int,
            name: "Corine Smith"
          },
          2: {
            id: 2 <-- int,
            name: "Jacobson Christensen"
          }
        ],
        greeting: "Hello, Burns Avery! You have 3 unread messages.",
        favoriteFruit: "strawberry"
      }
    ]

### Additional fetature

Opportunity to detect run-time function

    import "dart:math";
    import "package:dlog/dlog.dart" as dlog;
    
    sleep() {
      DateTime init = new DateTime.now();
      int ms = 1500;
      while (ms > new DateTime.now().difference(init).inMilliseconds);
    }
    
    main() {
    
      // create Time object and specity descrption
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
    
      debug.checkFunc("sleep function", sleep);
    
      debug.checkFunc("check power speed", (){
        for (int i = 0; i < 100000; i++) {
          pow(i, 100);
        }
      });
    
      // output
      print(debug);
    
    }

Result

    ────────────────────────────────────────────────
     Time test for power function
    ─────┬────────────────┬─────────────────────────
     1   │ 0:00:00.014000 │ complex random
     2   │ 0:00:01.500000 │ sleep function
     3   │ 0:00:00.414000 │ check power speed
    ─────┴────────────────┴─────────────────────────


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/vdakalov/DLog