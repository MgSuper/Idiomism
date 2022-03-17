import 'package:idiomism/data/model/idiom.dart';

abstract class BaseIdiomRepository {
  Stream<List<Idiom>> getAllIdioms();
}
