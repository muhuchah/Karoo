// import 'package:flutter/material.dart';
// import 'package:project/category/main_category.dart';
// import 'package:project/category/sub_category.dart';
//
// class DisplayCategories extends StatelessWidget {
//   String selected;
//   bool mainCategory;
//   bool subCategory;
//   bool list;
//   DisplayCategories({super.key , required this.mainCategory ,
//     required this.subCategory , required this.list , required this.selected});
//
//   @override
//   Widget build(BuildContext context) {
//     print("build");
//     if(mainCategory){
//       return MainCategoriesPage(
//         // onTap: (String value) {
//         //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//         //       builder: (context) => DisplayCategories(
//         //         mainCategory: false, subCategory: true,
//         //         list: false , selected: value,)));
//         // },
//       );
//     }
//     else if(subCategory){
//       return SubCategoryPage(
//         mainCategory: selected,
//         // onTap: (String value) {
//         //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//         //       builder: (context) => DisplayCategories(
//         //         mainCategory: false, subCategory: false,
//         //         list: true , selected: value,)));
//         // },
//         leading: IconButton(
//           onPressed: (){
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) => DisplayCategories(
//                   mainCategory: true, subCategory: false,
//                   list: false , selected: "",)));
//           },
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//       );
//     }
//     else{
//       return Placeholder();
//     }
//   }
// }
