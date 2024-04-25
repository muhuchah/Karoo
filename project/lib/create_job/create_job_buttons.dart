import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../widgets/big_text.dart';

class ShortButton extends StatelessWidget {
  String text;
  Function() onTap;
  ShortButton({super.key , required this.onTap , required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.main,
          fixedSize: const Size(200, 40,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
      child: BigText(text: text,size: 20,textColor: Colors.white,),
    );
  }
}

