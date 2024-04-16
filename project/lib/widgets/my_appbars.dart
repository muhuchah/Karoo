import 'package:flutter/material.dart';
import 'package:project/widgets/divider.dart';

import '../utils/app_color.dart';
import 'big_text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  String text;
  final List<Widget> actions;
  final Widget? leading;
  MainAppBar({super.key , required this.text ,
    this.actions = const [],this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: BigText(text: text),
      actions: actions,
      leading: leading,
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

class SubAppBar extends StatelessWidget implements PreferredSizeWidget{
  Function() leading;
  String text;
  SubAppBar({required this.text , required this.leading});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.background,
      title: BigText(text: text,),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: IconButton(
          onPressed:leading,
          icon: const Icon(Icons.arrow_back_ios , size: 28,)),
      ),
      toolbarHeight: 70,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1,color: AppColor.divider,),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
