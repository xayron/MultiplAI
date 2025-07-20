import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_all/webview_all.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewStack extends StatefulWidget {
  final String currentUrl;
  final bool isLoading;
  final void Function()? onWebViewCreated;
  final void Function(WebViewController)? onMacOSControllerCreated;
  final void Function(String)? onLoadStart;
  final void Function(String)? onLoadStop;
  final void Function(String, int, String)? onLoadError;

  const WebviewStack({
    super.key,
    required this.currentUrl,
    required this.isLoading,
    this.onWebViewCreated,
    this.onMacOSControllerCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onLoadError,
  });

  @override
  State<WebviewStack> createState() => _WebviewStackState();
}

class _WebviewStackState extends State<WebviewStack> {
  late WebViewController _controller;
  bool _isMacOS = false;

  @override
  void initState() {
    super.initState();
    _isMacOS = defaultTargetPlatform == TargetPlatform.macOS;

    if (_isMacOS) {
      // Initialize WebViewController for macOS
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              widget.onLoadStart?.call(url);
            },
            onPageFinished: (url) {
              widget.onLoadStop?.call(url);
            },
            onWebResourceError: (error) {
              widget.onLoadError?.call(
                error.url ?? '',
                error.errorCode,
                error.description,
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.currentUrl));

      // Pass the controller back to parent
      widget.onMacOSControllerCreated?.call(_controller);
    }

    // Notify that webview is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onWebViewCreated?.call();
    });
  }

  @override
  void didUpdateWidget(WebviewStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isMacOS && oldWidget.currentUrl != widget.currentUrl) {
      _controller.loadRequest(Uri.parse(widget.currentUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isMacOS)
          WebViewWidget(controller: _controller)
        else
          Webview(url: widget.currentUrl),
        if (widget.isLoading)
          Container(
            color: Theme.of(
              context,
            ).colorScheme.surface.withAlpha((0.8 * 255).toInt()),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
