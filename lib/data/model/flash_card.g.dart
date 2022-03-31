// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashCardAdapter extends TypeAdapter<FlashCard> {
  @override
  final int typeId = 1;

  @override
  FlashCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlashCard()
      ..idiomID = fields[0] as String
      ..phrase = fields[1] as String
      ..meaning = fields[2] as String
      ..mmMeaning = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, FlashCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idiomID)
      ..writeByte(1)
      ..write(obj.phrase)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.mmMeaning);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
