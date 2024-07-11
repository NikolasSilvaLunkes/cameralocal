import 'package:flutter/material.dart';

class ESMenu extends StatelessWidget {
  const ESMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/foto');
            },
            child: const Text('Tirar foto')),
      ],
    );
  }
}
