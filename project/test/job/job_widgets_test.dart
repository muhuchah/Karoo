import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/skill_file.dart';
import 'package:project/job/job_widgets.dart';

void main(){
  group("job widgets testing", () {
    testWidgets("job appbar testing", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: JobAppBar(images: const []),)
      );

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets("job user name testing", (tester) async {
      await tester.pumpWidget(
          MaterialApp(home: JobUserName(title: "some title", address: "Isfahan", rating: 2.2),)
      );

      expect(find.text("some title"), findsOneWidget);
      expect(find.text("Isfahan"), findsOneWidget);
      expect(find.text("2.2"), findsOneWidget);
    });

    testWidgets("job skill testing", (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: JobSkills(skills: [
          Skill(id: 1, title: "skill 1"),
          Skill(id: 2, title: "skill 2"),
        ]),)
      );

      expect(find.text("Skills"), findsOneWidget);
      expect(find.text("skill 1"), findsOneWidget);
      expect(find.text("skill 2"), findsOneWidget);
    });
  });
}