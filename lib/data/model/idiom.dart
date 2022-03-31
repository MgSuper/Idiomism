import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Idiom extends Equatable {
  final String id;
  final String phrase;
  final String meaning;
  final String sentence;
  final String mmMeaning;

  const Idiom(
      {required this.id,
      required this.phrase,
      required this.meaning,
      required this.sentence,
      required this.mmMeaning});

  static Idiom fromSnapshot(DocumentSnapshot snap) {
    Idiom idiom = Idiom(
        id: snap.id,
        phrase: snap['phrase'],
        meaning: snap['meaning'],
        sentence: snap['sentence'],
        mmMeaning: snap['mmMeaning']);
    return idiom;
  }

  @override
  String toString() => 'Phrase <$phrase>';

  @override
  List<Object?> get props =>
      [this.id, this.phrase, this.meaning, this.sentence];
}
