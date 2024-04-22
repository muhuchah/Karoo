import 'package:flutter/material.dart';

class JobAppBar extends StatelessWidget implements PreferredSizeWidget{
  const JobAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.asset("asset/plumber.jpg",height: 240,width: double.infinity,fit: BoxFit.fill,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0 , top: 8),
          child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios , size: 28,),
          ),
        ),
      ],
    );
    // return AppBar(
    //   leading: IconButton(
    //     onPressed: (){
    //       Navigator.of(context).pop;
    //     },
    //     icon: const Icon(Icons.arrow_back_ios , size: 28,),
    //   ),
    //   title: Image.asset("asset/plumber.jpg",height: 240,width: double.infinity,fit: BoxFit.fill,),
    // );
  }

  @override
  Size get preferredSize => const Size.fromHeight(240);
}
