import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/my_karoo/my_karoo_list_tile.dart';

void main(){
  testWidgets("my karoo list tile is testing", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyKarooListTile(title: "test", icon: Icons.add, onPressed: (){},),)
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}