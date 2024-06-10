import 'package:flutter_test/flutter_test.dart';
import 'package:project/category/main_category.dart';
import 'package:project/widgets/my_appbars.dart';

void main(){
  testWidgets("category widget test", (widgetTester) async{
    await widgetTester.pumpWidget(MainCategoriesPage(
        appBar: SubAppBar(text: "appbar", leading: (){},)
      )
    );
  });
}