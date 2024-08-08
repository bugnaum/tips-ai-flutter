import 'package:design_system/theme/the_tipster_theme.dart';
import 'package:flutter/material.dart';

class SecondaryHeaderComponent extends StatelessWidget {
  final String title;

  const SecondaryHeaderComponent({
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
            style: AppTheme.of().titleSmall,
          ),
        ),
      ],
    );
  }
}
