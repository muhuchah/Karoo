import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/job/icon_text_button_widget.dart';

void main(){
  testWidgets("icon text button testing", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: IconTextButton(icon: Icon(Icons.add), text: 'test',
        textButton: TextButton(onPressed: (){}, child: Text("")),),)
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}