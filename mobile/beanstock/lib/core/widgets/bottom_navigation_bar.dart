import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: GNav(
            onTabChange: (value) => onTabChange!(value),
            mainAxisAlignment: MainAxisAlignment.center,
            color: primaryBrownColor,
            activeColor: activeYellowColor,
            tabBackgroundColor: tabBackgroundYellowColor,
            tabBorderRadius: 24,
            tabActiveBorder: Border.all(color: activeTabBorderYellowColor),
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                text: 'Início',
              ),
              GButton(
                icon: Icons.list,
                text: 'Lista',
              ),
              GButton(
                icon: Icons.add,
                text: 'Adicionar',
              ),
            ]));
  }
}
