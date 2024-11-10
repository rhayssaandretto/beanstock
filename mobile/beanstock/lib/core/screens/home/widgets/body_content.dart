import 'package:beanstock/core/constants.dart';
import 'package:flutter/material.dart';
import '../../../models/mocks/mock_product_home.dart';

class BodyContent extends StatelessWidget {
  final Size size;

  const BodyContent({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      color: lightBackgroundColor,
      child: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20, top: 100, left: 20),
        child: Column(
          children: [
            MockProductHome(
                image: "assets/images/coffee_bag_1.png", name: "Café Arábica"),
            MockProductHome(
                image: "assets/images/coffee_bag_2.png", name: "Café Robusta"),
            MockProductHome(
                image: "assets/images/coffee_bag_3.png", name: "Café Gourmet"),
            MockProductHome(
                image: "assets/images/coffee_bag_4.png",
                name: "Café Tradicional"),
          ],
        ),
      ),
    );
  }
}
