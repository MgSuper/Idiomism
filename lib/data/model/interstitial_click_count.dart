import 'package:hive/hive.dart';

part 'interstitial_click_count.g.dart';

@HiveType(typeId: 2)
class InterstitialClickCount extends HiveObject {
  @HiveField(0)
  late int count;

  @HiveField(1)
  DateTime? date;
}