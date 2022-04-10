// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interstitial_click_count.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InterstitialClickCountAdapter
    extends TypeAdapter<InterstitialClickCount> {
  @override
  final int typeId = 2;

  @override
  InterstitialClickCount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InterstitialClickCount()
      ..count = fields[0] as int
      ..date = fields[1] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, InterstitialClickCount obj) {
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
      other is InterstitialClickCountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
