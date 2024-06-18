import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/job_file.dart';
import 'package:project/create_job/job_data.dart';

void main(){
  test("job data test", (){
    JobData.init();

    expect(JobData.title, "");
    expect(JobData.isCreate, true);

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

    JobData.setEditValues(Job.infoJson(infoValues));

    expect(JobData.title, "test job");
    expect(JobData.isCreate, false);
    expect(JobData.province, "Isfahan");
  });
}