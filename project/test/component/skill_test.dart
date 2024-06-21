import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/skill_file.dart';

void main(){
  test("skill testing", (){
    Skill skill = Skill(id: 1, title: "skill 1");
    expect(skill.id, 1);
    expect(skill.title, "skill 1");
  });
}