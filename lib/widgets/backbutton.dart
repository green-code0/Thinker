import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/color.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SvgPicture.asset(
        fit: BoxFit.scaleDown,
        'assets/svg/backbtn.svg',
        // ignore: deprecated_member_use
        color: alltexts,
      ),
    );
  }
}
