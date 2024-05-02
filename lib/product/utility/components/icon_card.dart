import 'package:flutter/material.dart';
import 'package:wheather_app/feature/home/shared/styles/text_styles.dart';

class IconCard extends StatelessWidget {
  const IconCard(
      {super.key,
      required this.icon,
      required this.subtitle,
      required this.data});
  final IconData icon;
  final String subtitle;
  final data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 36,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "$data",
            style: dataStyle,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            subtitle,
            style: dataNameStyle,
          ),
        ],
      ),
    );
  }
}
