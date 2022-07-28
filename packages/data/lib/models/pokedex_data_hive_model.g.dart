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
      name: fields[0] as String,
      picture: fields[1] as String,
      description: fields[2] as String,
      types: (fields[3] as List).cast<String>(),
      stats: (fields[4] as List).cast<PokemonStatsHiveModel>(),
      evolutionChain: fields[5] as String,
      pokemonForm: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokedexDataHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.picture)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.types)
      ..writeByte(4)
      ..write(obj.stats)
      ..writeByte(5)
      ..write(obj.evolutionChain)
      ..writeByte(6)
      ..write(obj.pokemonForm);
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
