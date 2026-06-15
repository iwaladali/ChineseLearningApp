import 'package:flutter/material.dart';

class QuizAnswerTile extends StatelessWidget {
  const QuizAnswerTile({
    super.key,
    required this.answer,
    required this.onTap,
    this.isSelected = false,
  });

  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  static const Color primaryRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryRed.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? primaryRed
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          answer,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? primaryRed
                : const Color(0xFF2F3A3F),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}