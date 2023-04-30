import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      color: Color.fromARGB(255, 131, 107, 107),
      thickness: 1.0,
    );
  }
}
