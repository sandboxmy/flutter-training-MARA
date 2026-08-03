import 'package:flutter/material.dart';

/// Sample StatefulWidget
/// StatefulWidget = UI that CAN change.
/// Use when you need setState (counter, form, toggle, etc).
class SampleStatefulWidgetScreen extends StatefulWidget {
  const SampleStatefulWidgetScreen({super.key});

  @override
  State<SampleStatefulWidgetScreen> createState() =>
      _SampleStatefulWidgetScreenState();
}

class _SampleStatefulWidgetScreenState
    extends State<SampleStatefulWidgetScreen> {
  // This value can change
  int _counter = 0;

  void _increase() {
    // setState tells Flutter to rebuild the UI
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample StatefulWidget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value:'),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrease,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _increase,
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Tap buttons → setState → UI updates',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
