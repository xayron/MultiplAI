import 'package:flutter/material.dart';

class ContentLoadingWidget extends StatelessWidget {
  const ContentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class ContentErrorWidget extends StatelessWidget {
  final String message;

  const ContentErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: $message',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentEmptyWidget extends StatelessWidget {
  const ContentEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_toy_outlined,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha((0.5 * 10).toInt()),
            ),
            const SizedBox(height: 16),
            Text(
              'Select an AI service to get started',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
