import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Idiom extends Equatable {
  final String phrase;
  final String meaning;
  final String sentence;

  Idiom({required this.phrase, required this.meaning, required this.sentence});

  static Idiom fromSnapshot(DocumentSnapshot snap) {
    Idiom idiom = Idiom(
        phrase: snap['phrase'],
        meaning: snap['meaning'],
        sentence: snap['sentence']);
    return idiom;
  }

  @override
  String toString() => 'Phrase <$phrase>';

  @override
  List<Object?> get props => [this.phrase, this.meaning, this.sentence];
}
