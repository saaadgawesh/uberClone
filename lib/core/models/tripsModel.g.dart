// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tripsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripsModelAdapter extends TypeAdapter<TripsModel> {
  @override
  final int typeId = 1;

  @override
  TripsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripsModel(
      tripId: fields[0] as String,
      status: fields[1] as String,
      actionDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TripsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.actionDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
