import 'package:flutter/material.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';
import 'big_text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  String text;
  MainAppBar({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: BigText(text: text),
      actions: [
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.add_alert_rounded),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.settings),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        const SizedBox(width: 10,)
      ],
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
