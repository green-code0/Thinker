import 'package:flutter/material.dart';

import 'color.dart';

TextStyle textStyle(double fontsize) => TextStyle(
      color: alltexts,
      fontSize: fontsize,
      fontFamily: 'LilitaOne',
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      shadows: const [
        Shadow(
          color: Colors.black38,
          blurRadius: 10,
          offset: Offset(0, 0),
        ),
      ],
    );
