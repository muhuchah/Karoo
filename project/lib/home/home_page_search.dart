import 'package:flutter/material.dart';
import 'package:project/component/user_file.dart';
import 'package:project/search/search_field.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

class HomePageSearch extends StatelessWidget {
  const HomePageSearch({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Column(
      children: [
        const SizedBox(height: 20,),
        Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),color: Colors.white,),
          child: Row(
            children: [
              const SizedBox(width: 5,),
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.search_outlined , size: 32,)),
              const SizedBox(width: 5,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        return SearchFieldPage();
                      })
                    );
                  },
                  child: const CustomText(text: "Search", size: 16,
                      textColor: AppColor.hint, weight: FontWeight.normal),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 1,
                color: Colors.black,
              ),
              Container(width: 5,),
              Text(user.city!),
              IconButton(onPressed: (){
                Navigator.of(context).pushNamed("/address-filter");
              }, icon: const Icon(Icons.location_on_outlined))
            ],
          ),
        ),
        const MyDivider()
      ],
    );
  }
}