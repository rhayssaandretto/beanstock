import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';

import 'widgets/body_content.dart';
import 'widgets/side_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              const SideBar(),
              BodyContent(size: size),
            ],
          ),
          Positioned(
            top: 55,
            left: 25,
            child: Text(
              "Sellers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: primaryBrownColor,
                shadows: const [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 6.0,
                    color: Color.fromARGB(255, 156, 117, 103),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
