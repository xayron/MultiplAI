import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplai/blocs/llm/llm_state.dart';
import 'package:multiplai/blocs/sidebar/sidebar_cubit.dart';
import 'package:multiplai/models/llm_service.dart';
import 'service_icon_list.dart';

class SidebarContent extends StatelessWidget {
  final LLMLoaded state;
  final List<LLMService>? services;
  final int? selectedIndex;
  final Function(String serviceName, int pageIndex)? onServiceSelected;

  const SidebarContent({
    super.key,
    required this.state,
    this.services,
    this.selectedIndex,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final servicesToUse = services ?? state.services;
    final selectedIndexToUse = selectedIndex ?? 0;

    return BlocBuilder<SidebarCubit, SidebarState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: MediaQuery.sizeOf(context).height,
          width: state.isExpanded ? 70 : 0,
          color: Theme.of(context).colorScheme.surface,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<SidebarCubit>().toggleSidebar();
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: state.isExpanded
                            ? const Icon(Icons.keyboard_arrow_left)
                            : const Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  ),
                  ServiceIconList(
                    services: servicesToUse,
                    selectedIndex: selectedIndexToUse,
                    onServiceSelected: onServiceSelected,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
