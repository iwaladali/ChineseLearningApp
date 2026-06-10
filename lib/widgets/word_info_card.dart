import 'package:flutter/material.dart';

class WordInfoCard extends StatelessWidget {
  const WordInfoCard({
    super.key,
  required this.child});

  final Widget child ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0,8)
          )
        ]
      ),
      child: child,
    );
  }
}
