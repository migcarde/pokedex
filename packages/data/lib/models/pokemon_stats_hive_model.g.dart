// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stats_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonStatsHiveModelAdapter extends TypeAdapter<PokemonStatsHiveModel> {
  @override
  final int typeId = 1;

  @override
  PokemonStatsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonStatsHiveModel(
      type: fields[0] as PokemonStatsTypeHiveModel,
      value: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonStatsHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonStatsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
