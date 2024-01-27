// ignore: file_names
import 'package:app_bloc_flutter/app/constants/index.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ConfigGraphQl {
  // httpLink
  static final HttpLink httpLink = HttpLink(ConfigApi.GRAPH_QL_APIURL);

  // query string
  static const String getUserQuery = "";

  // mutation string
  static const String loginMutation = """
    mutation login(\$loginInput: LoginInput!) {
        login(loginInput: \$loginInput) {
        success
        message
        code
        accessToken
    }
  """;
}
