import 'dart:convert';

import 'package:buffalo_bar/config.dart';
import 'package:buffalo_bar/exceptions/ServerOfflineException.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:nonce/nonce.dart';
import 'package:url_launcher/url_launcher.dart';

class OidcService {
  final Dio dio = Dio();

  static const String redirect = OIDC_REDIRECT_URL;
  String clientId = OIDC_CLIENT_ID;
  String oidcLoginUrl = OIDC_LOGIN_URL;

  void redirectToOidc(String? state) async {
    String nonce = Nonce.generate();
    String nonceUrlSegment = '&nonce=$nonce';

    String scopeSegment = '&scope=openid+profile';
    String responseTypeSegment = '&response_type=code';

    String redirectUriSegment = '&redirect_uri=$redirect';

    String constructedUrl = '$oidcLoginUrl?client_id=$clientId';

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

  Future<void> authenticateWithAuthCode(String code) async {
    BrowserHttpClientAdapter adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    var body = {'code': code};
    var jsonBody = jsonEncode(body);

    String authEndpoint = '$API_URL/api/oidc';

    try {
      final response = await dio.post(authEndpoint, data: jsonBody);

      if (response.statusCode == 200) {
        return;
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
