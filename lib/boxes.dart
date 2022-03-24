import 'package:hive/hive.dart';
import 'package:idiomism/data/model/ads_click_count.dart';

class Boxes {
  static Box<AdsClickCount> getClickCount() =>
      Hive.box<AdsClickCount>('adsclickcount');
}
