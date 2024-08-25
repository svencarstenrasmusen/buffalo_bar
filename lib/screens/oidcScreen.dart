import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/data/services/oidc_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OidcScreen extends StatefulWidget {
  final String? code;
  final String? error;
  final String? state;
  const OidcScreen({super.key, this.code, this.error, this.state});

  @override
  State<OidcScreen> createState() => _OidcScreenState();
}

class _OidcScreenState extends State<OidcScreen> {
  final OidcService _oidcService = OidcService();
  String _oidcResponse = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserIdentity(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                  child: Center(
                      child: _isLoading
                          ? _displayOidcLoading()
                          : _displayOidcResponse())),
              const SizedBox(height: 10)
            ],
          ),
        ));
  }

  void _getUserIdentity(String? code) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (code == null || code.isEmpty) {
      _setOidcResponse('Missing authorization code in url.');
    } else {
      _setLoading(true);
      _setOidcResponse('Getting user identity...');
      try {
        User user = await _oidcService.authenticateWithAuthCode(code);
        userProvider.setUser(user);
        _setLoading(false);
        if (widget.state != null) _handleState(state: widget.state!);
        // ignore: use_build_context_synchronously
        if (context.mounted) context.go('/main');
      } catch (e) {
        _setLoading(false);
        _setOidcResponse('Error: $e');
      }
    }
  }

  void _handleState({required String state}) {
    _setLoading(true);
    //Decode the URL encoded state.
    String decodedState = Uri.decodeComponent(state);
    _setLoading(false);

    //Redirect
    context.go(decodedState);
  }

  Text _displayOidcResponse() {
    return Text(_oidcResponse);
  }

  Column _displayOidcLoading() {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(),
      SizedBox(height: 10),
      Text('Loading...')
    ]);
  }

  void _setLoading(bool isLoading) {
    setState(() => _isLoading = isLoading);
  }

  void _setOidcResponse(String response) {
    setState(() => _oidcResponse = response);
  }
}
