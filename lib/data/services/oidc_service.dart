import 'dart:convert';

import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/parsers/user_parser.dart';
import 'package:buffalo_bar/environment_config.dart';
import 'package:buffalo_bar/exceptions/ServerOfflineException.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:nonce/nonce.dart';
import 'package:url_launcher/url_launcher.dart';

class OidcService {
  final Dio dio = Dio();
  final JSONUserParser userParser = JSONUserParser();

  void redirectToOidc(String? state) async {
    String nonce = Nonce.generate();
    String nonceUrlSegment = '&nonce=$nonce';

    String scopeSegment = '&scope=openid+profile';
    String responseTypeSegment = '&response_type=code';

    String redirectUriSegment = '&redirect_uri=$oidcRedirectUrl';

    String constructedUrl = '$oidcLoginUrl?client_id=$oidcClientId';

    constructedUrl = '$constructedUrl$scopeSegment';

    if (state != null) {
      String urlEncodedState = Uri.encodeComponent(state);
      constructedUrl = '$constructedUrl&state=$urlEncodedState';
    }

    constructedUrl = '$constructedUrl$redirectUriSegment';
    constructedUrl = '$constructedUrl$responseTypeSegment';
    constructedUrl = '$constructedUrl$nonceUrlSegment';

    Uri redirectUrl = Uri.parse(constructedUrl);

    await launchUrl(redirectUrl, webOnlyWindowName: '_self');
  }

  Future<User> authenticateWithAuthCode(String code) async {
    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    var body = {'code': code};
    var jsonBody = jsonEncode(body);

    String authEndpoint = '$apiUrl/api/oidc';

    try {
      final response = await dio.post(authEndpoint, data: jsonBody);

      if (response.statusCode == 200) {
        return userParser.parseUser(response.data);
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        throw Exception('Error 403 Forbidden.');
      } else {
        throw Exception('Unexpected error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw ServerOfflineException(
            'The server seems to be unreachable. Please try again later.');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
