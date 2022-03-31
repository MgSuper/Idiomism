// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_click_count.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdsClickCountAdapter extends TypeAdapter<AdsClickCount> {
  @override
  final int typeId = 0;

  @override
  AdsClickCount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsClickCount()
      ..count = fields[0] as int
      ..date = fields[1] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, AdsClickCount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsClickCountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
