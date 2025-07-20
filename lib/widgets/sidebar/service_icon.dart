import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplai/blocs/llm/llm_bloc.dart';
import 'package:multiplai/blocs/llm/llm_event.dart';
import 'package:multiplai/models/llm_service.dart';
import 'service_icon_image.dart';

class ServiceIcon extends StatelessWidget {
  final LLMService service;
  final int index;
  final int selectedIndex;
  final Function(String serviceName, int pageIndex)? onServiceSelected;

  const ServiceIcon({
    super.key,
    required this.service,
    required this.index,
    required this.selectedIndex,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: InkWell(
        onTap: () {
          if (onServiceSelected != null) {
            onServiceSelected!(service.name, index);
          } else {
            context.read<LLMBloc>().add(SelectLLMService(service));
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withAlpha(80),
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ServiceIconImage(service: service, isDark: isDark),
        ),
      ),
    );
  }
}
