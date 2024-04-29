import 'dart:convert';

import 'package:project/component/job_file.dart';
import 'package:project/create_job/job_data.dart';

import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class JobRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _jobList = "jobs/list/";
  static const String _jobDetail = "jobs/detail/";
  static const String _userJobs = "jobs/user/info/";

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

  static Future<List<Job>> getUserJobs() async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_userJobs"),
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

  static Future<List<String>> getSkills(subCategory) async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_userJobs"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    List<dynamic> body = jsonDecode(response.body);

    if(response.statusCode == 200){
      List<String> skills = ["Plumber Skill 1","Plumber Skill 2","Plumber Skill 3"];
      return skills;
    }

    throw Exception("Unable to send Skills");
  }

  static Future<Job> createJob() async {
    User user = User();
    var response = await http.post(
        Uri.parse("$_base$_userJobs"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        },
      body: <String , String>{
        "title" : JobData.title,
        "SubCategory" : JobData.subCategory,
        "description" : JobData.description,
        "experiences" : JobData.experience,
        "approximation_cph" : JobData.costPerHour,
        "initial_cost" : JobData.initialCost,
        "Province" : JobData.province,
      }
    );

    print(JobData.province);
    print(response.body);

    if(response.statusCode == 201){
      print(response.body);
      Job newJob = Job.listJson(jsonDecode(response.body));
      return newJob;
    }

    throw Exception("Unable to create job");
  }
}