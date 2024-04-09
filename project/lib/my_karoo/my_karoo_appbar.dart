import 'package:flutter/material.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';
import '../widgets/big_text.dart';

class MyKarooAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyKarooAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: const BigText(text: "Karoo"),
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
