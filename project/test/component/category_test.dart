import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/category.dart';

void main(){
  test("category json", (){
    Map jsonValues = {
      "id" : 1,
      "title" : "test",
      "description" : "this is test",
      "image" : "some url"
    };

    Category category = Category.fromJson(jsonValues);

    expect(category.id, 1);
    expect(category.title, "test");
    expect(category.description, "this is test");
    expect(category.image, "some url");
  });
}