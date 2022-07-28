import 'dart:convert';

import 'package:data/models/base_pagination_response.dart';
import 'package:data/models/base_url_response.dart';
import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/network/repository_failure.dart';
import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_remote_data_source_mocks.dart';

void main() {
  late PokedexRemoteDataSource pokedexRemoteDataSorce;
  late PokemonServiceMock mockService;

  setUp(() {
    mockService = PokemonServiceMock();
    pokedexRemoteDataSorce = PokedexRemoteDataSource(service: mockService);
  });

  final pokedexJsonResponse = jsonDecode(
      '{"count":1126,"next":"https://pokeapi.co/api/v2/pokemon?offset=1&limit=1","previous":null,"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}]}');

  const pokedexExpectedResult = BasePaginationResponse<PokemonResponse>(
      count: 1126,
      next: 'https://pokeapi.co/api/v2/pokemon?offset=1&limit=1',
      results: [
        PokemonResponse(
            name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
      ]);

  group('Get pokedex', () {
    const limit = 1;
    const offset = 0;

    test('Get pokedex - Success', () async {
      // Given
      when(() => mockService.getPokemons(offset, limit))
          .thenAnswer((invocation) async => pokedexJsonResponse);

      // When
      final result = await pokedexRemoteDataSorce.getPokemons(offset, limit);

      // Then
      expect(result, pokedexExpectedResult);

      verify(() => mockService.getPokemons(offset, limit));
      verifyNoMoreInteractions(mockService);
    });

    test('Get pokedex - Repository exception', () async {
      // Given
      when((() => mockService.getPokemons(offset, limit)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemons(offset, limit),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex - Unauthorized exception', () async {
      // Given
      when((() => mockService.getPokemons(offset, limit)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemons(offset, limit),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex - Unknown expection', () async {
      // Given
      when((() => mockService.getPokemons(offset, limit))).thenThrow(Unknown());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemons(offset, limit),
          throwsA(isInstanceOf<Unknown>()));
    });
  });

  group('Get pokedex by url', (() {
    const url = 'https://pokeapi.co/api/v2/pokemon?limit=1';

    test('Get pokedex by url - Success', () async {
      // Given
      when(() => mockService.getPokemonsByUrl(url))
          .thenAnswer((invocation) async => pokedexJsonResponse);

      // When
      final result = await pokedexRemoteDataSorce.getPokemonsByUrl(url);

      // Then
      expect(result, pokedexExpectedResult);

      verify(() => mockService.getPokemonsByUrl(url));
      verifyNoMoreInteractions(mockService);
    });

    test('Get pokedex by url - Repository exception', () async {
      // Given
      when((() => mockService.getPokemonsByUrl(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonsByUrl(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex by url - Unauthorized exception', () async {
      // Given
      when((() => mockService.getPokemonsByUrl(url))).thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex buy url - Unknown expection', () async {
      // Given
      when((() => mockService.getPokemonsByUrl(url))).thenThrow(Unknown());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon', () {
    const url = 'https://pokeapi.co/api/v2/pokemon/1/';
    const pokemonExpectedSprite = PokemonSpriteResponse(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    const pokemonSlots = [
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'grass')),
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'poison')),
    ];
    const pokemonStats = [
      PokemonStatsResponse(
        baseStat: 45,
        effort: 0,
        stat: PokemonStatResponse(
          name: 'hp',
          url: 'https://pokeapi.co/api/v2/stat/1/',
        ),
      ),
    ];
    const pokemonSpecie = PokemonDetailsSpecieResponse(
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/');
    const pokemonForms = [
      PokemonFormResponse(name: 'name', url: 'url'),
    ];
    const pokemonExpectedResult = PokemonDetailsResponse(
      sprite: pokemonExpectedSprite,
      slots: pokemonSlots,
      specie: pokemonSpecie,
      stats: pokemonStats,
      forms: pokemonForms,
    );

    final pokemonJsonResponse = jsonDecode('''
{
    "abilities": [
        {
            "ability": {
                "name": "overgrow",
                "url": "https://pokeapi.co/api/v2/ability/65/"
            },
            "is_hidden": false,
            "slot": 1
        }
    ],
    "base_experience": 64,
    "forms": [
        {
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon-form/1/"
        }
    ],
    "game_indices": [
        {
            "game_index": 153,
            "version": {
                "name": "red",
                "url": "https://pokeapi.co/api/v2/version/1/"
            }
        }
    ],
    "height": 7,
    "held_items": [],
    "id": 1,
    "is_default": true,
    "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/1/encounters",
    "moves": [],
    "name": "bulbasaur",
    "order": 1,
    "past_types": [],
    "species": {
        "name": "bulbasaur",
        "url": "https://pokeapi.co/api/v2/pokemon-species/1/"
    },
    "sprites": {
        "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
        "back_female": null,
        "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
        "back_shiny_female": null,
        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        "front_female": null,
        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
        "front_shiny_female": null,
        "other": {
            "dream_world": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg",
                "front_female": null
            },
            "home": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
                "front_female": null,
                "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png",
                "front_shiny_female": null
            },
            "official-artwork": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
            }
        },
        "versions": {
            "generation-i": {
                "red-blue": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/1.png",
                    "back_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/gray/1.png",
                    "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/back/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/1.png",
                    "front_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/gray/1.png",
                    "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/1.png"
                },
                "yellow": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/1.png",
                    "back_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/gray/1.png",
                    "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/back/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/1.png",
                    "front_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/gray/1.png",
                    "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/1.png"
                }
            },
            "generation-ii": {
                "crystal": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/1.png",
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/shiny/1.png",
                    "back_shiny_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/shiny/1.png",
                    "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/1.png",
                    "front_shiny_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/shiny/1.png",
                    "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/1.png"
                },
                "gold": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/1.png",
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/shiny/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/shiny/1.png",
                    "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/transparent/1.png"
                },
                "silver": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/1.png",
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/shiny/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/shiny/1.png",
                    "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/transparent/1.png"
                }
            },
            "generation-iii": {
                "emerald": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/shiny/1.png"
                },
                "firered-leafgreen": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/1.png",
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/shiny/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/shiny/1.png"
                },
                "ruby-sapphire": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/1.png",
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/shiny/1.png",
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/1.png",
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/shiny/1.png"
                }
            },
            "generation-iv": {
                "diamond-pearl": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/back/1.png",
                    "back_female": null,
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/back/shiny/1.png",
                    "back_shiny_female": null,
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/1.png",
                    "front_shiny_female": null
                },
                "heartgold-soulsilver": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/1.png",
                    "back_female": null,
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/shiny/1.png",
                    "back_shiny_female": null,
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/shiny/1.png",
                    "front_shiny_female": null
                },
                "platinum": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/back/1.png",
                    "back_female": null,
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/back/shiny/1.png",
                    "back_shiny_female": null,
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/shiny/1.png",
                    "front_shiny_female": null
                }
            },
            "generation-v": {
                "black-white": {
                    "animated": {
                        "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/1.gif",
                        "back_female": null,
                        "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/shiny/1.gif",
                        "back_shiny_female": null,
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif",
                        "front_female": null,
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/shiny/1.gif",
                        "front_shiny_female": null
                    },
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/1.png",
                    "back_female": null,
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/shiny/1.png",
                    "back_shiny_female": null,
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/shiny/1.png",
                    "front_shiny_female": null
                }
            },
            "generation-vi": {
                "omegaruby-alphasapphire": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/1.png",
                    "front_shiny_female": null
                },
                "x-y": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/shiny/1.png",
                    "front_shiny_female": null
                }
            },
            "generation-vii": {
                "icons": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/icons/1.png",
                    "front_female": null
                },
                "ultra-sun-ultra-moon": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/1.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/1.png",
                    "front_shiny_female": null
                }
            },
            "generation-viii": {
                "icons": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/1.png",
                    "front_female": null
                }
            }
        }
    },
    "stats": [
        {
            "base_stat": 45,
            "effort": 0,
            "stat": {
                "name": "hp",
                "url": "https://pokeapi.co/api/v2/stat/1/"
            }
        }
    ],
    "types": [
        {
            "slot": 1,
            "type": {
                "name": "grass",
                "url": "https://pokeapi.co/api/v2/type/12/"
            }
        },
        {
            "slot": 2,
            "type": {
                "name": "poison",
                "url": "https://pokeapi.co/api/v2/type/4/"
            }
        }
    ],
    "weight": 69
}
''');

    test('Get pokemon - Success', () async {
      // Given
      when(() => mockService.getPokemon(url))
          .thenAnswer((invocation) async => pokemonJsonResponse);

      // When
      final result = await pokedexRemoteDataSorce.getPokemon(url);

      // Then
      expect(result, pokemonExpectedResult);

      verify(() => mockService.getPokemon(url));
      verifyNoMoreInteractions(mockService);
    });

    test('Get pokemon - Repository exception', () async {
      // Given
      when((() => mockService.getPokemon(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemon(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon - Unauthorized exception', () async {
      // Given
      when((() => mockService.getPokemon(url))).thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemon(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon - Unknown expection', () async {
      // Given
      when((() => mockService.getPokemon(url))).thenThrow(Unknown());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemon(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  });

  group('Get pokemon specie', (() {
    const url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
    const pokemonFlavorEntries = [
      PokemonFlavorEntryResponse(
        text:
            'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.',
        language: PokemonLanguageResponse(name: 'en'),
      ),
    ];
    const evolutionChain =
        BaseUrlResponse(url: 'https://pokeapi.co/api/v2/evolution-chain/1/');
    const pokemonSpecieExpectedResult = PokemonSpecieResponse(
      flavors: pokemonFlavorEntries,
      evolutionChain: evolutionChain,
    );
    final jsonResponse = jsonDecode('''
{
    "base_happiness": 50,
    "capture_rate": 45,
    "color": {
        "name": "green",
        "url": "https://pokeapi.co/api/v2/pokemon-color/5/"
    },
    "egg_groups": [
        {
            "name": "monster",
            "url": "https://pokeapi.co/api/v2/egg-group/1/"
        },
        {
            "name": "plant",
            "url": "https://pokeapi.co/api/v2/egg-group/7/"
        }
    ],
    "evolution_chain": {
        "url": "https://pokeapi.co/api/v2/evolution-chain/1/"
    },
    "evolves_from_species": null,
    "flavor_text_entries": [
        {
            "flavor_text": "A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.",
            "language": {
                "name": "en",
                "url": "https://pokeapi.co/api/v2/language/9/"
            },
            "version": {
                "name": "red",
                "url": "https://pokeapi.co/api/v2/version/1/"
            }
        }
    ],
    "form_descriptions": [],
    "forms_switchable": false,
    "gender_rate": 1,
    "genera": [
        {
            "genus": "たねポケモン",
            "language": {
                "name": "ja-Hrkt",
                "url": "https://pokeapi.co/api/v2/language/1/"
            }
        },
        {
            "genus": "씨앗포켓몬",
            "language": {
                "name": "ko",
                "url": "https://pokeapi.co/api/v2/language/3/"
            }
        },
        {
            "genus": "種子寶可夢",
            "language": {
                "name": "zh-Hant",
                "url": "https://pokeapi.co/api/v2/language/4/"
            }
        },
        {
            "genus": "Pokémon Graine",
            "language": {
                "name": "fr",
                "url": "https://pokeapi.co/api/v2/language/5/"
            }
        },
        {
            "genus": "Samen-Pokémon",
            "language": {
                "name": "de",
                "url": "https://pokeapi.co/api/v2/language/6/"
            }
        },
        {
            "genus": "Pokémon Semilla",
            "language": {
                "name": "es",
                "url": "https://pokeapi.co/api/v2/language/7/"
            }
        },
        {
            "genus": "Pokémon Seme",
            "language": {
                "name": "it",
                "url": "https://pokeapi.co/api/v2/language/8/"
            }
        },
        {
            "genus": "Seed Pokémon",
            "language": {
                "name": "en",
                "url": "https://pokeapi.co/api/v2/language/9/"
            }
        },
        {
            "genus": "たねポケモン",
            "language": {
                "name": "ja",
                "url": "https://pokeapi.co/api/v2/language/11/"
            }
        },
        {
            "genus": "种子宝可梦",
            "language": {
                "name": "zh-Hans",
                "url": "https://pokeapi.co/api/v2/language/12/"
            }
        }
    ],
    "generation": {
        "name": "generation-i",
        "url": "https://pokeapi.co/api/v2/generation/1/"
    },
    "growth_rate": {
        "name": "medium-slow",
        "url": "https://pokeapi.co/api/v2/growth-rate/4/"
    },
    "habitat": {
        "name": "grassland",
        "url": "https://pokeapi.co/api/v2/pokemon-habitat/3/"
    },
    "has_gender_differences": false,
    "hatch_counter": 20,
    "id": 1,
    "is_baby": false,
    "is_legendary": false,
    "is_mythical": false,
    "name": "bulbasaur",
    "names": [
        {
            "language": {
                "name": "ja-Hrkt",
                "url": "https://pokeapi.co/api/v2/language/1/"
            },
            "name": "フシギダネ"
        },
        {
            "language": {
                "name": "roomaji",
                "url": "https://pokeapi.co/api/v2/language/2/"
            },
            "name": "Fushigidane"
        },
        {
            "language": {
                "name": "ko",
                "url": "https://pokeapi.co/api/v2/language/3/"
            },
            "name": "이상해씨"
        },
        {
            "language": {
                "name": "zh-Hant",
                "url": "https://pokeapi.co/api/v2/language/4/"
            },
            "name": "妙蛙種子"
        },
        {
            "language": {
                "name": "fr",
                "url": "https://pokeapi.co/api/v2/language/5/"
            },
            "name": "Bulbizarre"
        },
        {
            "language": {
                "name": "de",
                "url": "https://pokeapi.co/api/v2/language/6/"
            },
            "name": "Bisasam"
        },
        {
            "language": {
                "name": "es",
                "url": "https://pokeapi.co/api/v2/language/7/"
            },
            "name": "Bulbasaur"
        },
        {
            "language": {
                "name": "it",
                "url": "https://pokeapi.co/api/v2/language/8/"
            },
            "name": "Bulbasaur"
        },
        {
            "language": {
                "name": "en",
                "url": "https://pokeapi.co/api/v2/language/9/"
            },
            "name": "Bulbasaur"
        },
        {
            "language": {
                "name": "ja",
                "url": "https://pokeapi.co/api/v2/language/11/"
            },
            "name": "フシギダネ"
        },
        {
            "language": {
                "name": "zh-Hans",
                "url": "https://pokeapi.co/api/v2/language/12/"
            },
            "name": "妙蛙种子"
        }
    ],
    "order": 1,
    "pal_park_encounters": [
        {
            "area": {
                "name": "field",
                "url": "https://pokeapi.co/api/v2/pal-park-area/2/"
            },
            "base_score": 50,
            "rate": 30
        }
    ],
    "pokedex_numbers": [
        {
            "entry_number": 1,
            "pokedex": {
                "name": "national",
                "url": "https://pokeapi.co/api/v2/pokedex/1/"
            }
        },
        {
            "entry_number": 1,
            "pokedex": {
                "name": "kanto",
                "url": "https://pokeapi.co/api/v2/pokedex/2/"
            }
        },
        {
            "entry_number": 226,
            "pokedex": {
                "name": "original-johto",
                "url": "https://pokeapi.co/api/v2/pokedex/3/"
            }
        },
        {
            "entry_number": 231,
            "pokedex": {
                "name": "updated-johto",
                "url": "https://pokeapi.co/api/v2/pokedex/7/"
            }
        },
        {
            "entry_number": 80,
            "pokedex": {
                "name": "kalos-central",
                "url": "https://pokeapi.co/api/v2/pokedex/12/"
            }
        },
        {
            "entry_number": 1,
            "pokedex": {
                "name": "letsgo-kanto",
                "url": "https://pokeapi.co/api/v2/pokedex/26/"
            }
        },
        {
            "entry_number": 68,
            "pokedex": {
                "name": "isle-of-armor",
                "url": "https://pokeapi.co/api/v2/pokedex/28/"
            }
        }
    ],
    "shape": {
        "name": "quadruped",
        "url": "https://pokeapi.co/api/v2/pokemon-shape/8/"
    },
    "varieties": [
        {
            "is_default": true,
            "pokemon": {
                "name": "bulbasaur",
                "url": "https://pokeapi.co/api/v2/pokemon/1/"
            }
        }
    ]
}
''');
    test('Get pokemon specie - Success', () async {
      // Given
      when(() => mockService.getPokemonSpecie(url))
          .thenAnswer((invocation) async => jsonResponse);

      // When
      final result = await pokedexRemoteDataSorce.getPokemonSpecie(url);

      // Then
      expect(result, pokemonSpecieExpectedResult);

      verify(() => mockService.getPokemonSpecie(url));
      verifyNoMoreInteractions(mockService);
    });

    test('Get pokemon specie - Repository exception', () async {
      // Given
      when((() => mockService.getPokemonSpecie(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonSpecie(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon specie - Unauthorized exception', () async {
      // Given
      when((() => mockService.getPokemonSpecie(url))).thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon specie - Unknown expection', () async {
      // Given
      when((() => mockService.getPokemonSpecie(url))).thenThrow(Unknown());

      // Then
      expect(() => pokedexRemoteDataSorce.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
