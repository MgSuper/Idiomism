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
    return AdsClickCount()..count = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, AdsClickCount obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.count);
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
