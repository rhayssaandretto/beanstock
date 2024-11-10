import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';
import '../../forms/product_form_screen.dart';
import '../../list/product_list_screen.dart';
import 'side_bar_button.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: activeTabBorderYellowColor,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Best",
                style: TextStyle(fontSize: 20, color: primaryBrownColor),
              ),
            ),
            const Spacer(flex: 4),
            SidebarButton(
              label: "Cadastrar",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductFormPage()),
                );
              },
            ),
            const Spacer(),
            SidebarButton(
              label: "Visualizar Estoque",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListPage()),
                );
              },
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
