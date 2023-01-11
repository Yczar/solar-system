import 'package:flutter/material.dart';

class SceneTitileWidget extends StatelessWidget {
  const SceneTitileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          Text(
            'THE SOLAR SYSTEM WITH FLUTTER',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
