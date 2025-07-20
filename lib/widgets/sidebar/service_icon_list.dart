import 'package:flutter/material.dart';
import 'package:multiplai/models/llm_service.dart';
import 'service_icon.dart';

class ServiceIconList extends StatelessWidget {
  final List<LLMService> services;
  final int selectedIndex;
  final Function(String serviceName, int pageIndex)? onServiceSelected;

  const ServiceIconList({
    super.key,
    required this.services,
    required this.selectedIndex,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: services.asMap().entries.map((entry) {
        final index = entry.key;
        final service = entry.value;
        return ServiceIcon(
          service: service,
          index: index,
          selectedIndex: selectedIndex,
          onServiceSelected: onServiceSelected,
        );
      }).toList(),
    );
  }
}
