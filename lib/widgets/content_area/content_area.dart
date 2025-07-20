import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplai/blocs/llm/llm_bloc.dart';
import 'package:multiplai/blocs/llm/llm_state.dart';
import 'package:multiplai/widgets/index.dart';
import 'content_state_widgets.dart';
import 'content_loaded_view.dart';

class ContentArea extends StatelessWidget {
  final Map<String, WebviewController> webviewControllers;
  final Map<String, Widget> webviewWidgets;
  final int currentPageIndex;

  const ContentArea({
    super.key,
    required this.webviewControllers,
    required this.webviewWidgets,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LLMBloc, LLMState>(
      builder: (context, state) {
        if (state is LLMInitial || state is LLMLoading) {
          return const ContentLoadingWidget();
        }

        if (state is LLMError) {
          return ContentErrorWidget(message: state.message);
        }

        if (state is LLMLoaded) {
          return ContentLoadedView(
            state: state,
            currentPageIndex: currentPageIndex,
            webviewControllers: webviewControllers,
            webviewWidgets: webviewWidgets,
          );
        }

        return const ContentEmptyWidget();
      },
    );
  }
}
