import 'package:design_system/theme/the_tipster_theme.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderComponent extends StatelessWidget {
  final String title;

  const PrimaryHeaderComponent({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 16,
            left: 24,
            right: 24,
          ),
          child: Text(
            title,
            style: AppTheme.of().titleLarge,
          ),
        ),
      ],
    );
  }
}
