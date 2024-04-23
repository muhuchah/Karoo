import 'dart:convert';

import 'package:project/component/job_file.dart';

import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class JobRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _jobList = "jobs/list/";
  static const String _jobDetail = "jobs/detail/";

  static Future<List<Job>> getJobs() async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_jobList"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    List<dynamic> body = jsonDecode(response.body);

    if(response.statusCode == 200){
      List<Job> jobs = [];
      for(int i = 0;i<body.length;i++){
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to get jobs");
  }

  static Future<List<Job>> getJobsBySubCategory(String subCategory) async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_jobList?SubCategory__title=$subCategory"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    List<dynamic> body = jsonDecode(response.body);

    if(response.statusCode == 200){
      List<Job> jobs = [];
      for(int i = 0;i<body.length;i++){
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to send jobs");
  }

  static Future<Job> getJobDetail(int id) async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_jobDetail$id"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    if(response.statusCode == 200){
      print(response.body);
      Job job = Job.infoJson(jsonDecode(response.body));
      return job;
    }

    throw Exception("Unable to send jobs");
  }
}