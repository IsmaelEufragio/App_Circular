// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../global/colors.dart';

class IncrementWidgets extends StatefulWidget {
  const IncrementWidgets({super.key});

  @override
  State<IncrementWidgets> createState() => _IncrementWidgetsState();
}

class _IncrementWidgetsState extends State<IncrementWidgets> {
  int _counter = 1;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 1) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _decrement();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        2,
                      ),
                      bottomLeft: Radius.circular(
                        2,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    _counter.toString(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _increment();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        2,
                      ),
                      bottomRight: Radius.circular(
                        2,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
