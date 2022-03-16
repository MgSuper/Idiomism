import 'package:cloud_firestore/cloud_firestore.dart';

class Idiom {
  String? phrase;
  String? meaning;
  String? sentence;

  // Constructor with named parameters
  Idiom({this.phrase, this.meaning, this.sentence});

  // Factory constructor to create an idiom from JSON
  factory Idiom.fromJson(Map<String, dynamic> json) => _idiomFromJson(json);

  // Factory constructor to create an idiom from a Firestore DocumentSnapshot
  factory Idiom.fromSnapshot(DocumentSnapshot snapshot) {
    final newIdiom = Idiom.fromJson(snapshot.data() as Map<String, dynamic>);
    return newIdiom;
  }

  @override
  String toString() => 'Phrase <$phrase>';
}

// Function to convert a map of key/value pairs into a idiom
_idiomFromJson(Map<String, dynamic> json) {
  return Idiom(
      phrase: json['phrase'] as String,
      meaning: json['meaning'] as String,
      sentence: json['sentence'] as String);
}
