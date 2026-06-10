import 'package:flutter/material.dart';

class VocabularyCard extends StatelessWidget {
  const VocabularyCard({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.arabic,
    required this.onPlay,
    required this.onTap
  });

  final String hanzi;
  final String pinyin;
  final String arabic;
  final VoidCallback onPlay;
  final VoidCallback onTap;

  static const Color primaryRed = Color(0xFFE53935);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: lightRed,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  hanzi,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: primaryRed,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hanzi,
                        style: const TextStyle(
                          color: darkText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pinyin,
                        style: const TextStyle(
                          color: greyText,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    arabic,
                    style: const TextStyle(
                      color: greyText,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: onPlay,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: lightRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volume_up,
                  color: primaryRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}