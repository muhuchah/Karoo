import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/image.dart';

void main(){
  test("test for image file", (){
    ImageFile image = ImageFile(id: 1, imageUrl: "some url");
    expect(image.imageUrl, "some url");
    expect(image.id, 1);
  });
}