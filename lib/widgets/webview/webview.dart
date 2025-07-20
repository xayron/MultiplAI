import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_url_bar.dart';
import 'webview_stack.dart';

class Webview extends StatefulWidget {
  final String initialUrl;
  final String serviceName;

  const Webview({
    super.key,
    this.initialUrl = 'https://chat.openai.com',
    required this.serviceName,
  });

  @override
  State<Webview> createState() => WebviewState();
}

class WebviewState extends State<Webview> with AutomaticKeepAliveClientMixin {
  String _currentUrl = '';
  bool _isLoading = true;
  Key _webviewKey = UniqueKey();
  WebViewController? _macOSController;
  bool _isMacOS = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.initialUrl;
    _isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
  }

  void _setMacOSController(WebViewController controller) {
    _macOSController = controller;
  }

  void loadUrl(String url) {
    setState(() {
      _isLoading = true;
      _currentUrl = url;
    });

    if (_isMacOS && _macOSController != null) {
      _macOSController!.loadRequest(Uri.parse(url));
    } else {
      // Force WebviewStack to rebuild with new URL for non-macOS platforms
      setState(() {
        _webviewKey = UniqueKey();
      });
    }
  }

  void _resetToOriginalUrl() {
    setState(() {
      _isLoading = true;
      _currentUrl = widget.initialUrl;
    });

    if (_isMacOS && _macOSController != null) {
      _macOSController!.loadRequest(Uri.parse(widget.initialUrl));
    } else {
      // Force WebviewStack to rebuild with original URL for non-macOS platforms
      setState(() {
        _webviewKey = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        WebviewUrlBar(
          currentUrl: _currentUrl,
          isLoading: _isLoading,
          onRefresh: _resetToOriginalUrl,
        ),
        Expanded(
          child: WebviewStack(
            key: _webviewKey,
            currentUrl: _currentUrl,
            isLoading: _isLoading,
            onWebViewCreated: () {
              // WebView created callback
            },
            onMacOSControllerCreated: _setMacOSController,
            onLoadStart: (url) {
              setState(() {
                _isLoading = true;
                _currentUrl = url;
              });
            },
            onLoadStop: (url) {
              setState(() {
                _isLoading = false;
              });
            },
            onLoadError: (url, code, message) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ),
      ],
    );
  }
}

class WebviewController {
  final GlobalKey<WebviewState> _key = GlobalKey<WebviewState>();

  void loadUrl(String url) {
    _key.currentState?.loadUrl(url);
  }

  GlobalKey<WebviewState> get key => _key;
}
