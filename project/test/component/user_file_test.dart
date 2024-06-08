import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/user_file.dart';

void main(){
  test("singleton test", (){
    User user1 = User();
    User user2 = User();

    expect(user1, user2);
  });
}