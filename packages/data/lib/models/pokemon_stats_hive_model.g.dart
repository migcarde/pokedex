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

class PokemonStatsTypeHiveModelAdapter
    extends TypeAdapter<PokemonStatsTypeHiveModel> {
  @override
  final int typeId = 2;

  @override
  PokemonStatsTypeHiveModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PokemonStatsTypeHiveModel.hp;
      case 1:
        return PokemonStatsTypeHiveModel.attack;
      case 2:
        return PokemonStatsTypeHiveModel.defense;
      case 3:
        return PokemonStatsTypeHiveModel.specialAttack;
      case 4:
        return PokemonStatsTypeHiveModel.specialDefense;
      case 5:
        return PokemonStatsTypeHiveModel.speed;
      default:
        return PokemonStatsTypeHiveModel.hp;
    }
  }

  @override
  void write(BinaryWriter writer, PokemonStatsTypeHiveModel obj) {
    switch (obj) {
      case PokemonStatsTypeHiveModel.hp:
        writer.writeByte(0);
        break;
      case PokemonStatsTypeHiveModel.attack:
        writer.writeByte(1);
        break;
      case PokemonStatsTypeHiveModel.defense:
        writer.writeByte(2);
        break;
      case PokemonStatsTypeHiveModel.specialAttack:
        writer.writeByte(3);
        break;
      case PokemonStatsTypeHiveModel.specialDefense:
        writer.writeByte(4);
        break;
      case PokemonStatsTypeHiveModel.speed:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonStatsTypeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
