import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../core/constants/graphql_queries.dart';

class CountriesGraphqlService {
  const CountriesGraphqlService(this._client);
  final GraphQLClient _client;

  Future<List<Map<String, dynamic>>> fetchCountries({bool forceNetwork = false}) async {
    final result = await _client.query(
      QueryOptions(
        document: gql(GraphqlQueries.countries),
        fetchPolicy: forceNetwork ? FetchPolicy.networkOnly : FetchPolicy.cacheAndNetwork,
      ),
    );
    if (result.hasException) throw result.exception!;
    final data = result.data?['countries'] as List<dynamic>? ?? const [];
    return data.cast<Map<String, dynamic>>();
  }
}
