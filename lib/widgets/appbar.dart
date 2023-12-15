import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/styles.dart';
import 'backbutton.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;

  CustomAppBar({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(57);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: const BackBtn(),
        actions: actions,
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: textStyle(36),
        ));
  }
}
