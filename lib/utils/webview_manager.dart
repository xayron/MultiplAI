import 'package:flutter/material.dart';
import 'package:multiplai/blocs/llm/llm_state.dart';
import 'package:multiplai/models/llm_service.dart';
import 'package:multiplai/widgets/index.dart';

class WebviewManager {
  static Widget createWebviewWidget(
    LLMService service,
    LLMState state,
    Map<String, WebviewController> webviewControllers,
    Map<String, Widget> webviewWidgets,
  ) {
    final serviceName = service.name;

    // Create webview controller if not exists
    if (!webviewControllers.containsKey(serviceName)) {
      webviewControllers[serviceName] = WebviewController();
    }

    // Create webview widget if not exists
    if (!webviewWidgets.containsKey(serviceName)) {
      webviewWidgets[serviceName] = Webview(
        key: ValueKey('webview_$serviceName'),
        initialUrl: state is LLMLoaded
            ? (state.webviewUrls[serviceName] ?? service.url)
            : service.url,
        serviceName: serviceName,
      );
    }

    return webviewWidgets[serviceName]!;
  }
}
