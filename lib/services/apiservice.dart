import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List?>? loadJsonData() async {
  List alldata;
  Map<String, dynamic> map = {};
  var jsonText = await rootBundle.loadString('assets/mapdata.json');
  alldata = json.decode(jsonText);
  print(alldata.toString());
  // print(alldata[0].toString());
  for (int i = 0; i < alldata.length; i++) {
    print('$i iteration');
    //map.addAll(alldata[i]);
    map.putIfAbsent('$i', () => alldata[i]);
  }
  print(map.toString());
  return alldata;
}
