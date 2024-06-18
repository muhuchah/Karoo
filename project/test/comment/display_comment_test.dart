import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/comment/display_comment.dart';
import 'package:project/component/job_file.dart';

void main(){
  testWidgets("Comment list testing", (tester) async {

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


    Job job = Job.infoJson(infoValues);
    await tester.pumpWidget(MaterialApp(home: DisplayComments(job: job),));

    expect(find.text("good job"), findsOneWidget);
    expect(find.text("good"), findsOneWidget);
    expect(find.text("10 days ago"), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
  });
}