import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class ProfileListTile extends StatelessWidget {
  final String label;
  final String text;
  final bool isPassword;
  const ProfileListTile({super.key , required this.label,
    required this.text , this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15,left: 15,right: 5),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: label, size: 16,
                        textColor: Colors.black, weight:FontWeight.normal),
                    SizedBox(height: 20,),
                    CustomText(text: getValues(), size: 16,
                        textColor: AppColor.hint, weight:FontWeight.normal)
                ],),
                IconButton(onPressed: (){
                  _showDialog(context, label);
                }, icon: Icon(Icons.arrow_forward_ios,)),
            ],),
          ],),
        ),
        SizedBox(height: 20,),
        Container(height: 1,color: AppColor.divider,
          margin: EdgeInsets.symmetric(horizontal: 10),)
      ],
    );
  }

  String getValues(){
    if(isPassword){
      String temp = "";
      for(int i=0;i<text.length;i++){
        temp+="*";
      }
      return temp;
    }
    return text;
  }

  void _showDialog(context , label){
    showDialog(context: context, builder: (context){
      TextEditingController controller = TextEditingController();
      return AlertDialog(
        title: Text("Enter $label :"),
        content: TextField(
          controller: controller,

        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Save")),
        ],
      );
    });
  }
}