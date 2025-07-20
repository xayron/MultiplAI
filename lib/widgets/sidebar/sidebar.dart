import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplai/blocs/llm/llm_bloc.dart';
import 'package:multiplai/blocs/llm/llm_state.dart';
import 'package:multiplai/models/llm_service.dart';
import 'sidebar_content.dart';
import 'sidebar_state_widgets.dart';

class Sidebar extends StatelessWidget {
  final Function(String serviceName, int pageIndex)? onServiceSelected;
  final List<LLMService>? services;
  final int? selectedIndex;

  const Sidebar({
    super.key,
    this.onServiceSelected,
    this.services,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LLMBloc, LLMState>(
      builder: (context, state) {
        if (state is LLMLoading) {
          return const LoadingWidget();
        }

        if (state is LLMError) {
          return SidebarErrorWidget(message: state.message);
        }

        if (state is LLMLoaded) {
          return SidebarContent(
            state: state,
            services: services,
            selectedIndex: selectedIndex,
            onServiceSelected: onServiceSelected,
          );
        }

        return const EmptyWidget();
      },
    );
  }
}
