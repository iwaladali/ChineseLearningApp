import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({
    super.key,
  required this.icon,
  required this.iconColor,
  required this.iconBackground,
  required this.title,
  this.subtitle,
  required this.onTap});

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color borderGrey = Color(0xFFE5E7EB);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderGrey)
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Icon(icon,color: iconColor,),
              ),
              SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyle(
                    color: darkText,
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                  ),),
                  if(subtitle !=null) ...[
                    const SizedBox(height: 4,),
                    Text(subtitle!,
                    style: TextStyle(
                      color: greyText,
                      fontSize: 13
                    ),)
                  ]
                ],
              )),
              const Icon(Icons.chevron_left, color: greyText,)
            ],
          ),
        ),
      ),
    );
  }
}
