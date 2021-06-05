import 'dart:io';
import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

Future<List<Map<String, dynamic>>> excelToJson() async {
  List<Map<String, dynamic>> jsonmaps = new List<Map<String, dynamic>>();
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (result != null) {
    File filepath = File(result.files.single.path);
    PlatformFile file = result.files.first;

    print(file.name);
    print(file.bytes);
    print(file.size);
    print(file.extension);
    print(file.path);

    var bytes = File(file.path).readAsBytesSync();
    print(bytes);
    var excl = Excel.decodeBytes(bytes);
    print("jij");
    for (var table in excl.tables.keys) {
      // print(table); //sheet Name
      // print(excl.tables[table].maxCols);
      // print(excl.tables[table].maxRows);
      List<dynamic> keys = new List<dynamic>();
      var rows = excl.tables[table].rows;
      for (int i = 0; i < rows.length; i++) {
        if (i == 0) {
          keys = List.from(rows[i]);
        } else {
          print("${rows[i]}");
          Map<String, dynamic> m = {};
          for (int j = 0; j < rows[i].length; j++) {
            m.putIfAbsent(keys[j], () => rows[i][j]);
          }
          jsonmaps.add(m);
        }
      }
      return jsonmaps;
      // for (var row in excl.tables[table].rows) {
      //   print("$row");
      // }
    }
  } else {
    print("an error occured");
  }
}
