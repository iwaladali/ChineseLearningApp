import 'package:flutter/material.dart';

class HomeCategoryCard extends StatelessWidget {
  const HomeCategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  static const Color primaryRed = Color(0xFFE53935);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: lightRed,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Icon(
                icon,
                color: primaryRed,
              size: 28,),
            ),
            const Spacer(),
            Text(
                title,
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 6,),
            Text(
              subtitle,
              style: TextStyle(
                color: darkText,
                fontSize: 13
              ),
            )
          ],
        ),
      ),
    );
  }
}
