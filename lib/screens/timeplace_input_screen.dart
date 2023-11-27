import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';

import '../extensions/extensions.dart';
import '../route/routes.dart';
import '../state/timeplace_input/timeplace_input_notifier.dart';
import '../utility/utility.dart';

// ignore: must_be_immutable
class TimeplaceInputScreen extends ConsumerWidget {
  TimeplaceInputScreen({super.key, required this.date, required this.diff});

  final DateTime date;
  final String diff;

  final Utility _utility = Utility();

  List<TextEditingController> tecPlaces = [];
  List<TextEditingController> tecPrices = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final timeplaceInputState = _ref.watch(timeplaceInputProvider(diff));

    makeTecs();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(date.yyyymmdd),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text('/'),
                        ),
                        Text(
                          (timeplaceInputState.diff != 0)
                              ? timeplaceInputState.diff.toString().toCurrency()
                              : timeplaceInputState.baseDiff.toCurrency(),
                          style: TextStyle(
                            color: (timeplaceInputState.diff == 0) ? Colors.yellowAccent : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await _ref.read(timeplaceInputProvider(diff).notifier).inputTimeplace(date: date);

                            await Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

                            if (_context.mounted) {
                              context.goNamed(RouteNames.home);
                            }
                          },
                          icon: const Icon(Icons.input, color: Colors.pinkAccent),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () => context.goNamed(RouteNames.home),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2, color: Colors.white.withOpacity(0.4)),
                Expanded(child: displayInputParts()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  void makeTecs() {
    for (var i = 0; i < 10; i++) {
      tecPlaces.add(TextEditingController(text: ''));
      tecPrices.add(TextEditingController(text: ''));
    }
  }

  ///
  Widget displayInputParts() {
    final timeplaceInputState = _ref.watch(timeplaceInputProvider(diff));

    final list = <Widget>[];

    for (var i = 0; i < 10; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: _context.screenSize.width * 0.2,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  readOnly: true,
                  controller: TextEditingController(text: timeplaceInputState.time[i]),
                  decoration: InputDecoration(
                    fillColor: Colors.yellowAccent.withOpacity(0.2),
                    filled: true,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  ),
                  onTap: () => showTP(pos: i),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: _context.screenSize.width * 0.3,
                child: TextField(
                  controller: tecPlaces[i],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) => _ref.read(timeplaceInputProvider(diff).notifier).setPlace(pos: i, place: value),
                ),
              ),
              Checkbox(
                activeColor: Colors.orangeAccent,
                value: timeplaceInputState.minusCheck[i],
                onChanged: (check) => _ref.read(timeplaceInputProvider(diff).notifier).setMinusCheck(pos: i),
                side: BorderSide(color: Colors.white.withOpacity(0.8)),
              ),
              SizedBox(
                width: _context.screenSize.width * 0.2,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tecPrices[i],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) =>
                      _ref.read(timeplaceInputProvider(diff).notifier).setSpendPrice(pos: i, price: value.toInt()),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Future<void> showTP({required int pos}) async {
    final selectedTime = await showTimePicker(
      context: _context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (selectedTime != null) {
      final time = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

      await _ref.read(timeplaceInputProvider(diff).notifier).setTime(pos: pos, time: time);
    }
  }
}
