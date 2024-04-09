import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class HomeListTile extends StatelessWidget {
  const HomeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Plumber", size: 20,
                  textColor: Colors.black, weight: FontWeight.bold),
              SizedBox(height: 20,),
              CustomText(text: "i'm a plumber and do plumbering", size: 14,
                  textColor: Colors.black, weight: FontWeight.normal),
              SizedBox(height: 20,),
              Text("Isfahan , Shahreza" , style: TextStyle(color: AppColor.loginText1,
                  fontSize: 14 , fontWeight: FontWeight.normal ,
                  fontStyle: FontStyle.italic),
              ),
          ],),
        ),
        Container(
          width: 180,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("asset/plumber.jpg",
                  fit: BoxFit.fitHeight,width: 150,height: 100,),
              ),
              SizedBox(height: 2,),
              Row(children: [
                CustomText(text: "4.4", size: 12,
                    textColor: AppColor.loginText1, weight: FontWeight.normal),
                Icon(Icons.star , color: AppColor.loginText1,size: 16,),
              ],),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ],
    );
  }
}
