import 'package:flutter/material.dart';

class MockProductHome extends StatelessWidget {
  final String name;
  final String image;

  const MockProductHome({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Image.asset(
          image,
          width: 300,
        )),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 55, right: 20),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 54, right: 17),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'R\$$price',
        //         style: const TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.black,
        //         ),
        //       ),
        //       Image.asset("images/card.png", width: 30),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
