import 'package:flutter/material.dart';

class SeiyuPage extends StatelessWidget {
  const SeiyuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/*


  ///
  Widget displaySeiyuPurchase() {
    final seiyuPurchaseDateState = _ref.watch(seiyuPurchaseDateProvider);

    final list = <Widget>[];

    var total = 0;

    for (var i = 0; i < seiyuPurchaseDateState.length; i++) {
      total += seiyuPurchaseDateState[i].price.toInt();
    }

    list.add(
      Container(
        width: double.infinity,
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              total.toString().toCurrency(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    for (var i = 0; i < seiyuPurchaseDateState.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(seiyuPurchaseDateState[i].date),
                    ),
                    Text(
                      seiyuPurchaseDateState[i].item,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(seiyuPurchaseDateState[i].tanka.toCurrency()),
                        const SizedBox(width: 20),
                        const Text('×'),
                        const SizedBox(width: 20),
                        Text(seiyuPurchaseDateState[i].kosuu),
                        const SizedBox(width: 20),
                        const Text('='),
                        const SizedBox(width: 20),
                        Text(seiyuPurchaseDateState[i].price.toCurrency()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  MoneyDialog(
                    context: _context,
                    widget: SeiyuItemAlert(
                      date: date,
                      item: seiyuPurchaseDateState[i].item,
                    ),
                  );
                },
                icon: Icon(
                  Icons.ac_unit,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        children: list,
      ),
    );
  }



*/
