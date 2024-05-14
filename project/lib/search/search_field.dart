import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/search/search.dart';
import 'package:project/widgets/long_button.dart';

import '../utils/app_color.dart';

class SearchFieldPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  SearchFieldPage({super.key}){
    focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 20 , right: 20 , top: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),color: Colors.white,),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios , size: 24,),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focus,
                          decoration: const InputDecoration(hintText: "Search",
                            hintStyle: TextStyle(color: AppColor.hint),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context){
                              return SearchPage(search: controller.text);
                            })
                          );
                        },
                        icon: const Icon(Icons.search_outlined , size: 24,)
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: LongButton(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return SearchPage(search: controller.text);
                        })
                    );
                  },
                  text: "Search"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
