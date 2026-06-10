import 'package:flutter/material.dart';

class AchievementTile extends StatelessWidget {
  const AchievementTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24)
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Color(0xFFFFF3C4),
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.emoji_events),
          ),
          
          const SizedBox(width: 16,),
          
          Expanded(child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              
              const SizedBox(height: 4,),
              
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey
                ),
              )
            ],
          )),
          const Icon(Icons.check_circle)
        ],
      ),
    );
  }
}
