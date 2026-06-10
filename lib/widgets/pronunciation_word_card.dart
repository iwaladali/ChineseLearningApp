import 'package:flutter/material.dart';

class PronunciationWordCard extends StatelessWidget {
  const PronunciationWordCard({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.arabic,
  });

  final String hanzi;
  final String pinyin;
  final String arabic;

  static const Color primaryRed = Color(0xFFE53935);
  static const Color yellow = Color(0xFFD4A514);
  static const Color greyText = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            hanzi,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: primaryRed,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 32),

          Text(
            pinyin,
            style: const TextStyle(
              color: yellow,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            arabic,
            style: const TextStyle(
              color: greyText,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 30),

          const Icon(
            Icons.graphic_eq,
            color: primaryRed,
            size: 48,
          ),
        ],
      ),
    );
  }
}