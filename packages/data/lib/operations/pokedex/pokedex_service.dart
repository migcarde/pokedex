import 'package:data/app_configuration.dart';
import 'package:data/network/network_request.dart' as http_interceptor;
import 'package:data/network/network_utils.dart';

enum QueryParameters { offset, limit }

class PokemonService {
  Future<Map<String, dynamic>> getPokemons(int offset, int limit) async =>
      await requestServer<Map<String, dynamic>>(() async {
        final queryParameters = {
          QueryParameters.offset.name: offset.toString(),
          QueryParameters.limit.name: limit.toString(),
        };
        final uri = Uri.https(
            AppConfiguration.of().baseUrl, '/api/v2/pokemon', queryParameters);
        final response = await http_interceptor.get(uri);

        return parsedResponse<Map<String, dynamic>>(response);
      });

  Future<Map<String, dynamic>> getPokemon(String url) async =>
      await requestServer<Map<String, dynamic>>(() async {
        final uri = Uri(path: url);
        final response = await http_interceptor.get(uri);

        return parsedResponse<Map<String, dynamic>>(response);
      });
}
