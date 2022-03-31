import 'package:hive/hive.dart';

part 'flash_card.g.dart';

@HiveType(typeId: 1)
class FlashCard extends HiveObject {
  @HiveField(0)
  late String idiomID;

  @HiveField(1)
  late String phrase;

  @HiveField(2)
  late String meaning;

  @HiveField(3)
  late String mmMeaning;
}
