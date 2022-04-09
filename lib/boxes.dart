import 'package:hive/hive.dart';
import 'package:theidioms/data/model/ads_click_count.dart';
import 'package:theidioms/data/model/flash_card.dart';

class Boxes {
  static Box<AdsClickCount> getClickCount() =>
      Hive.box<AdsClickCount>('adsclickcount');

  static Box<FlashCard> getFlashCards() => Hive.box<FlashCard>('flashcards');
}
