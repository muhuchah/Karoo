import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class CreateJobTextIcon extends StatelessWidget {
  Icon? icon;
  String? assetPath;
  String text;
  String? onTapAssetPath;
  String? onTapString;
  Function() onTap;
  CreateJobTextIcon({super.key , this.icon , required this.text, this.onTapAssetPath,
    this.onTapString , required this.onTap , this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            assetPath == null ? icon! : Image.asset(assetPath! , width: 15,height: 15,),
            const SizedBox(width: 10,),
            SizedBox(
              width: onTapAssetPath == null ? 100 : 150,
              child: CustomText(text: text, size: 16,
                  textColor: Colors.black, weight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(
          width: 60,
          child: Align(
            alignment: Alignment.center,
            child: onTapAssetPath == null ? TextButton(
              onPressed: onTap,
              child: CustomText(text: onTapString!, size: 16,
                textColor: AppColor.hint, weight: FontWeight.normal)) :
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(onTapAssetPath! , width: 15 , height: 15,)
            ),
          ),
        )
      ],
    );
  }
}
