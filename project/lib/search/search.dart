import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/widgets/long_button.dart';

import '../utils/app_color.dart';

class SearchPage extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  SearchPage({super.key}){
    focus.requestFocus();
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                          controller: widget.controller,
                          focusNode: widget.focus,
                          decoration: InputDecoration(hintText: "Search",
                            hintStyle: TextStyle(color: AppColor.hint),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){

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
