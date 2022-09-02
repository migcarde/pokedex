// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_data_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokedexDataHiveModelAdapter extends TypeAdapter<PokedexDataHiveModel> {
  @override
  final int typeId = 0;

  @override
  PokedexDataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokedexDataHiveModel(
      id: fields[0] as int,
      name: fields[1] as String,
      frontPicture: fields[2] as String,
      backPicture: fields[3] as String,
      description: fields[4] as String,
      types: (fields[5] as List).cast<String>(),
      stats: (fields[6] as List).cast<PokemonStatsHiveModel>(),
      species: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokedexDataHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.frontPicture)
      ..writeByte(3)
      ..write(obj.backPicture)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.stats)
      ..writeByte(7)
      ..write(obj.species);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokedexDataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
