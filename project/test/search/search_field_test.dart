import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/search/search_field.dart';

void main(){
  testWidgets("search field testing", (tester) async {
    await tester.pumpWidget(MaterialApp(home: SearchFieldPage(),));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.filter_alt_outlined), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.text("Main Category"), findsOneWidget);
    expect(find.text("Sub Category"), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.text("Main Category"), findsNothing);
    expect(find.text("Sub Category"), findsNothing);
  });
}