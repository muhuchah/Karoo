import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/comment/comment_container.dart';
import 'package:project/component/comment_file.dart';
import 'package:project/component/job_file.dart';

void main(){
  testWidgets("Comment container testing", (tester) async {
    Map listValues = {
      "id" : 1,
      "title" : "test job",
      "main_picture_url" : "some url",
      "description" : "this is test job",
      "average_rating" : 2.2,
      "province_name" : "Isfahan",
      "city_name" : "Shahreza"
    };
    Map infoValues = {...listValues,
      "user_email" : "Hamid@gmail.com",
      "pictures" : [
        {
          "image" : "image 1",
          "id" : 1
        },
        {
          "image" : "image 2",
          "id" : 2
        }
      ],
      "comments" :[
        {
          "id" : 1,
          "comment" : "good job",
          "title" : "good",
          "data" : "10 days ago",
          "rating" : 4,
          "user_email" : "Hamid@gmail.com",
          "user_full_name" : "Hamid"
        },
      ],
      "skills": [
        {
          "id" : 10,
          "title" : "plumber skill"
        },
        {
          "id" : 5,
          "title" : "coloring skill"
        }
      ],
      "experiences" : "10",
      "approximation_cph" : "10",
      "initial_cost" : "10",
      "Main_category_title" : "coloring",
      "Sub_category_title" : "doing coloring"
    };

    await tester.pumpWidget(MaterialApp(
      home: CommentTile(comment: Comment(id: 1, comment: "comment",userEmail: "some email",
        title: "good", date: "2024", rating: 3, userFullName: "some name"
      ),job: Job.infoJson(infoValues),),)
    );

    expect(find.text("good"), findsOneWidget);
    expect(find.text("comment"), findsOneWidget);
    expect(find.text("2024"), findsOneWidget);
  });
}