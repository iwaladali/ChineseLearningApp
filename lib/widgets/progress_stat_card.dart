import 'package:flutter/material.dart';

class ProgressStatCard extends StatelessWidget {
  const ProgressStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6)
          ),
        ]
      ),
      child: Column(
        children: [
          Icon(
              icon,
          color: iconColor,
          size: 32,),

          const SizedBox(height: 14,),

          Text(value,style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),),

          const SizedBox(height: 6,),

          Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey
          ),)
        ],
      ),
    );
  }
}
