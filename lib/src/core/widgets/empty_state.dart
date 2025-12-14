import 'package:flutter/material.dart';

import 'state_message.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return StateMessage(
      icon: icon,
      title: title,
      subtitle: subtitle,
    );
  }
}
