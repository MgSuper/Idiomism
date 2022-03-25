import 'package:hive/hive.dart';

part 'ads_click_count.g.dart';

@HiveType(typeId: 0)
class AdsClickCount extends HiveObject {
  @HiveField(0)
  late int count;

  @HiveField(1)
  DateTime? date;
}