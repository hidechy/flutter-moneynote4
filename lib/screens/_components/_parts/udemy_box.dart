import 'package:flutter/material.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../../../models/udemy.dart';

class UdemyBox extends StatelessWidget {
  const UdemyBox({super.key, required this.udemy});

  final Udemy udemy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      width: context.screenSize.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(udemy.date),
              Text(udemy.category),
            ],
          ),
          Text(udemy.title),
          Container(
            alignment: Alignment.topRight,
            child: Text(udemy.price.toCurrency()),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Text(
              udemy.pay,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
