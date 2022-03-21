import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/providers/path_provider.dart';

class IdiomList {
  final List<Idiom> idioms;

  IdiomList(this.idioms);

  writeList(List<Idiom> list) async {
    final file = await PathProvider.localFile;
    file.writeAsString('$list');
  }

  Future<List<Idiom>> readList() async {
    try {
      final file = await PathProvider.localFile;

      // Read the file
      final contents = await file.readAsString();

      Iterable list = json.decode(contents);

      List<Idiom> idiomList =
          List<Idiom>.from(list.map((element) => Idiom.fromJson(element)));

      return idiomList;
    } catch (e) {
      // If encountering an error, return empty list
      return [];
    }
  }

  bool compareTwoList(list1, list2){
    return const DeepCollectionEquality().equals(list1, list2);
  }
}
