import 'package:flutter/material.dart';
import 'package:multiplai/models/llm_service.dart';

class ServiceIconImage extends StatelessWidget {
  final LLMService service;
  final bool isDark;

  const ServiceIconImage({
    super.key,
    required this.service,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        service.icon,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.smart_toy,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              size: 16,
            ),
          );
        },
      ),
    );
  }
}
