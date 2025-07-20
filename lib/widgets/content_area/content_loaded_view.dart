import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplai/blocs/llm/llm_state.dart';
import 'package:multiplai/blocs/sidebar/sidebar_cubit.dart';
import 'package:multiplai/widgets/index.dart';
import 'service_loading_widget.dart';
import '../../utils/webview_manager.dart';

class ContentLoadedView extends StatelessWidget {
  final LLMLoaded state;
  final int currentPageIndex;
  final Map<String, WebviewController> webviewControllers;
  final Map<String, Widget> webviewWidgets;

  const ContentLoadedView({
    super.key,
    required this.state,
    required this.currentPageIndex,
    required this.webviewControllers,
    required this.webviewWidgets,
  });

  @override
  Widget build(BuildContext context) {
    // Create all webview widgets for IndexedStack
    final webviewWidgets = state.services.map((service) {
      final serviceName = service.name;
      final isLoading = state.loadingStates[serviceName] ?? false;

      if (isLoading) {
        return ServiceLoadingWidget(serviceName: serviceName);
      }

      return WebviewManager.createWebviewWidget(
        service,
        state,
        webviewControllers,
        this.webviewWidgets,
      );
    }).toList();

    return BlocBuilder<SidebarCubit, SidebarState>(
      builder: (context, state) {
        return IndexedStack(index: currentPageIndex, children: webviewWidgets);
      },
    );
  }
}
