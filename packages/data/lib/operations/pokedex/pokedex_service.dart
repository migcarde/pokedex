import 'package:data/app_configuration.dart';
import 'package:data/network/network_request.dart' as http_interceptor;
import 'package:data/network/network_utils.dart';

enum QueryParameters { offset, limit }

class PokemonService {
  Future<List<dynamic>> getPokemons(int offset, int limit) async =>
      await requestServer(() async {
        final queryParameters = {
          QueryParameters.offset.name: offset,
          QueryParameters.limit.name: limit,
        };
        final uri =
            Uri.https(AppConfiguration.of().baseUrl, '', queryParameters);
        final response = await http_interceptor.get(uri);

        return parsedResponse(response);
      });
}
