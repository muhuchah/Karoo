import 'dart:convert';

import 'package:project/component/category.dart';
import 'package:http/http.dart' as http;
import 'package:project/component/user_file.dart';

class CategoryRequest{
  static const String _base = "http://172.19.51.84:8000/";
  static const String _mainCategory = "categories/maincategories/list/";
  static const String _subCategory = "categories/subcategories/list/?MainCategory__title=";
  
  static Future<List<Category>> mainCategory() async {
    User user = User();
    var response = await http.get(Uri.parse(_base+_mainCategory),
      headers: <String , String>{
        "Authorization": "Bearer ${user.accessToken!}"
      }
    );

    if(response.statusCode==200){
      List<Category> categories = [];
      List<dynamic> values = jsonDecode(response.body);

      for(int i = 0;i<values.length ; i++){
        categories.add(Category.fromJson(values[i]));
      }
      return categories;
    }

    throw Exception("unable to load categories");
  }

  static Future<List<Category>> subCategory(String category) async {
    User user = User();
    var response = await http.get(Uri.parse(_base+_subCategory+category),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    if(response.statusCode==200){
      List<Category> subCategories = [];
      List<dynamic> values = jsonDecode(response.body);

      for(int i = 0;i<values.length ; i++){
        subCategories.add(Category.fromJson(values[i]));
      }
      return subCategories;
    }

    throw Exception("unable to load sub categories");
  }
}