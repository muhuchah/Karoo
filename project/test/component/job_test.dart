import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/comment_file.dart';
import 'package:project/component/image.dart';
import 'package:project/component/job_file.dart';
import 'package:project/component/skill_file.dart';

void main(){
  group("tests for job", () {
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
          "title" : "good"
        },
        {
          "id" : 3,
          "comment" : "bad job",
        }
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

    test("list json test 1", (){
      Job job = Job.listJson(listValues);

      expect(job.id, listValues["id"]);
      expect(job.title, "test job");
      expect(job.rating, 2.2);
      expect(job.city, "Shahreza");
    });
    test("list json test 2", (){
      Job job = Job.listJson(listValues);
      job.title = "changing title";

      expect(job.title, "changing title");
    });

    test("info json test", (){
      Job job = Job.infoJson(infoValues);

      expect(job.pictures![0].imageUrl, "image 1");
      expect(job.pictures![1].id, 2);
      expect(job.comments![0].comment, "good job");
      expect(job.comments![1].title, null);
      expect(job.skills![0].title, "plumber skill");
      expect(job.skills![1].id , 5);
    });
  });
}