import 'package:flutter/material.dart';

import '../constant/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 44,
      height: 67,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bgbtn,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: borderbtn,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: alltexts,
            fontSize: 36,
            fontFamily: 'LilitaOne',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            shadows: [
              Shadow(
                color: Colors.black38,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
