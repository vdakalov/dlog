# DLog

A useful library for output structured information of debugging into console

## Usage

The information can be structured as a table or a tree

### Table

    import "dart:math" as Math;
    import 'package:dlog/dlog.dart' as DLog;
    
    double rad(num deg) =>
      deg * (Math.PI / 180);
    
    main() {
    
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

    import 'package:dlog/dlog.dart' as DLog;
    
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
      
      var tree = new DLog.Tree("Users");
      
      // required opening root group
      tree.openGroup();
      
      for (int i = 0; i < users.length; i++) {
      tree
          // add name
          ..add(users[i]["name"])
          
          // open user group (previous element is the name of the group following)
          ..openGroup()
          
          // subitems
          ..add("age: ${users[i]["age"]}")
          ..add("city: ${users[i]["city"]}")
          
          // close user group
          ..closeGroup()
          ;
      }
      
      // clone root group and output in console
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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/vdakalov/DLog