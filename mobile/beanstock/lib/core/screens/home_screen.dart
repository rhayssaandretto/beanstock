import 'package:beanstock/core/constants.dart';
import 'package:beanstock/core/models/mocks/mock_product_home.dart';
import 'package:beanstock/core/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

import 'product_form_screen.dart';

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
            //TODO: componentizar
            sideBar(context),
            bodyParts(size, context),
          ],
        ),
        const SizedBox(
          height: 30,
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
    ));
  }

  Container bodyParts(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.8,
      color: lightBackgroundColor,
      child: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20, top: 100, left: 20),
        child: Column(
          children: [
            MockProductHome(
              image: "assets/images/coffee_bag_1.png",
              name: "Café Arábica",
            ),
            MockProductHome(
              image: "assets/images/coffee_bag_2.png",
              name: "Café Robusta",
            ),
            MockProductHome(
              image: "assets/images/coffee_bag_3.png",
              name: "Café Gourmet",
            ),
            MockProductHome(
              image: "assets/images/coffee_bag_4.png",
              name: "Café Tradicional",
            ),
          ],
        ),
      ),
    );
  }

  Expanded sideBar(BuildContext context) {
    return Expanded(
        child: Container(
      color: activeTabBorderYellowColor,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Best",
              style: TextStyle(fontSize: 20, color: primaryBrownColor),
            ),
          ),
          const SizedBox(
            height: 210,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: RotatedBox(
              quarterTurns: 3,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductFormPage(),
                    ),
                  );
                },
                child: Chip(
                  label: Text(
                    "Cadastrar",
                    style: TextStyle(
                        color: primaryBrownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: secondaryCreamColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: primaryBrownColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: RotatedBox(
              quarterTurns: 3,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListPage(),
                    ),
                  );
                },
                child: Chip(
                  label: Text(
                    "Visualizar Estoque",
                    style: TextStyle(
                        color: primaryBrownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: secondaryCreamColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: primaryBrownColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
