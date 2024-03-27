import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/big_text.dart';

class MyKarooAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyKarooAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(text: "Karoo"),
      actions: [
        IconButton(onPressed: (){

        }, icon: Icon(Icons.add_alert_rounded),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        IconButton(onPressed: (){

        }, icon: Icon(Icons.settings),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        SizedBox(width: 10,)
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(color: AppColor.divider,height: 1,),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
