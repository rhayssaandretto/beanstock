import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SidebarButton({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: RotatedBox(
        quarterTurns: 3,
        child: InkWell(
          onTap: onTap,
          child: Chip(
            label: Text(
              label,
              style: TextStyle(
                color: primaryBrownColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: secondaryCreamColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: primaryBrownColor),
            ),
          ),
        ),
      ),
    );
  }
}
