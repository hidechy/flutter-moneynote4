import 'package:flutter/material.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../../../models/credit_spend_all.dart';

class CreditDetailDialog extends StatelessWidget {
  const CreditDetailDialog({super.key, required this.creditDetail});

  final CreditSpendAll creditDetail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Positioned(
        bottom: 0,
        child: Container(
          width: context.screenSize.width - 100,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
            ),
            color: Colors.blueGrey.withOpacity(0.3),
          ),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(creditDetail.item),
                Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(creditDetail.date.yyyymmdd),
                        Text(creditDetail.kind),
                      ],
                    ),
                    Text(creditDetail.price.toCurrency()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
