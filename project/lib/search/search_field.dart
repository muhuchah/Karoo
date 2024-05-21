import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/search/search.dart';
import 'package:project/search/search_data.dart';
import 'package:project/widgets/long_button.dart';

import '../category/main_category.dart';
import '../category/sub_category.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text.dart';
import '../widgets/my_appbars.dart';

class SearchFieldPage extends StatefulWidget {
  TextEditingController? controller;
  FocusNode focus = FocusNode();
  bool filter;
  String? text;

  SearchFieldPage({super.key , this.filter = false, this.text}){
    controller = TextEditingController(text: text);
    focus.requestFocus();
  }

  @override
  State<SearchFieldPage> createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {
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
              Column(
                children : _getWidgets(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: LongButton(
                  onTap: (){
                    if(widget.text!=null){
                      Navigator.of(context).pop();
                    }
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        return SearchPage(search: widget.controller!.text,
                          filterTypes: _checkFilterTypes(),
                        );
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

  Map<String , String>? _checkFilterTypes(){
    Map<String , String> values = {};
    if(widget.filter){
      if(SearchData.mainCategory != ""){
        values['SubCategory__MainCategory__title'] = SearchData.mainCategory;
      }
      if(SearchData.subCategory != ""){
        values['SubCategory__title'] = SearchData.subCategory;
      }
      if(values.isEmpty){
        return null;
      }
      return values;
    }
    return null;
  }

  List<Widget> _getWidgets(){
    List<Widget> children = [];
    children.add(
      Container(
        height: 60,
        margin: const EdgeInsets.only(left: 20 , right: 20 , top: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),color: Colors.white,),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0 , top: 5),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  SearchData.init();
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios , size: 24,),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focus,
                  decoration: const InputDecoration(hintText: "Search",
                      hintStyle: TextStyle(color: AppColor.hint),
                      border: InputBorder.none
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if(widget.filter){
                      SearchData.init();
                      widget.filter = false;
                    }
                    else{
                      widget.filter = true;
                    }
                  });
                },
                icon: const Icon(Icons.filter_alt_outlined , size: 24,)
              )
            ],
          ),
        ),
      )
    );

    if(widget.filter){
      children.add(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(text: "Main Category", size: 16,
                      textColor: Colors.black, weight: FontWeight.normal),
                  getCategoryName(true)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(text: "Sub Category", size: 16,
                      textColor: Colors.black, weight: FontWeight.normal),
                  getCategoryName(false)
                ],
              )
            ],
          ),
        )
      );
    }
    return children;
  }

  Widget getCategoryName(bool categoryCheck){
    return TextButton(
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainCategoriesPage(
            onTap: (mainCategory){
              if(categoryCheck){
                Navigator.of(context).pop();
                setState(() {
                  SearchData.mainCategory = mainCategory;
                });
              }
              else{
                mainCategoryOnTap(context, mainCategory);
              }
            },
            appBar: SubAppBar(text: "Category", leading: () {
              Navigator.of(context).pop();
            },),
          ),)
        );
      },
      child:Text(categoryCheck ?
        SearchData.mainCategory == "" ? "Select" : SearchData.mainCategory :
        SearchData.subCategory == "" ? "Select" : SearchData.subCategory ,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16 ,
          color: AppColor.loginText1,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  void mainCategoryOnTap(context , mainCategory){
    Navigator.of(context).push(
      MaterialPageRoute(builder : (context) =>
        SubCategoryPage(mainCategory: mainCategory,
          leading: (){
            Navigator.of(context).pop();
          },
          onTap: (subCategory , id){
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            setState(() {
              SearchData.subCategory = subCategory;
            });
          }
        )
      )
    );
  }
}
