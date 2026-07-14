import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants/app_constants.dart';

GraphQLClient createGraphqlClient() => GraphQLClient(
      link: HttpLink(AppConstants.countriesEndpoint),
      cache: GraphQLCache(store: HiveStore()),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.cacheAndNetwork),
      ),
    );
