import 'package:flutter/material.dart';

class TableShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> mapsinit = ModalRoute.of(context).settings.arguments;
    // Map<String, String> m;
    // m.valu
    // print(maps);
    List<dynamic> maps = List.from(mapsinit);
    List<dynamic> klist = maps[0].keys.toList();
    Map<String, dynamic> m = {};
    for (var key in klist) {
      m.putIfAbsent(key, () => key);
    }
    maps.insert(0, m);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          color: Colors.grey[300],
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: maps.map((row) {
                              List<dynamic> vlistinit = row.values.toList();
                              List<dynamic> vlist = vlistinit.reversed.toList();
                              print(vlist);
                              return Container(
                                height: MediaQuery.of(context).size.height / 10,
                                child: Row(
                                  children: vlist.map((e) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            // width: MediaQuery.of(context).size.width / 3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            child: Center(
                                                child: Text(e.toString()))),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }).toList()),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
//                   child: ListView.builder(
//                 itemCount: maps.length,
//                 itemBuilder: (context, index) {
//                   List<dynamic> vlist = maps[index].values.toList();
// return Container(
//   height: MediaQuery.of(context).size.height / 10,
//   child: Row(
//     children: vlist.map((e) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black, width: 2),
//         ),
//         width: MediaQuery.of(context).size.width / 3,
//         height: MediaQuery.of(context).size.height / 15,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//               padding: EdgeInsets.all(5),
//               // width: MediaQuery.of(context).size.width / 3,
//               height: MediaQuery.of(context).size.height / 10,
//               child: Center(child: Text(e.toString()))),
//         ),
//       );
//     }).toList(),
//   ),
// );
//                 },
//               )),
