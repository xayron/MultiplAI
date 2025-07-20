import 'package:flutter/material.dart';

class ServiceLoadingWidget extends StatelessWidget {
  final String serviceName;

  const ServiceLoadingWidget({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading $serviceName...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha((0.7 * 10).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
