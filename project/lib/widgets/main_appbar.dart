import 'package:flutter/material.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';
import 'big_text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  String text;
  final List<Widget> actions;
  MainAppBar({super.key , required this.text , this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: BigText(text: text),
      actions: actions,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: MyDivider(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
