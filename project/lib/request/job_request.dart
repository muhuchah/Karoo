import 'dart:convert';
import 'dart:io';

import 'package:project/component/job_file.dart';
import 'package:project/create_job/job_data.dart';

import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class JobRequest{
  static const String _base = "https://karoo.liara.run/";
  static const String _jobList = "jobs/list/";
  static const String _jobDetail = "jobs/detail/";
  static const String _userJobs = "jobs/user/info/";
  static const String _userPictures = "jobs/user/pictures/";

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

    throw Exception("Unable to get jobs");
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
      Job job = Job.infoJson(jsonDecode(response.body));
      return job;
    }

    throw Exception("Unable to load job");
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

    throw Exception("Unable to get jobs");
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

    throw Exception("Unable to load Skills");
  }

  static Map getJobJson(){
    Map values = {};
    values["title"] = JobData.title;
    values["SubCategory"] = JobData.subCategoryId;
    values["province"] = JobData.province;
    values["city"] = JobData.city;

    if(JobData.description!= ""){
      values["description"] = JobData.description;
    }
    if(JobData.experience!= ""){
      values["experiences"] = JobData.experience;
    }
    if(JobData.costPerHour!= ""){
      values["approximation_cph"] = JobData.costPerHour;
    }
    if(JobData.initialCost!= ""){
      values["initial_cost"] = JobData.initialCost;
    }
    return values;
  }

  static Future<Job> createJob() async {
    User user = User();
    var response = await http.post(
        Uri.parse("$_base$_userJobs"),
        headers: <String , String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },
      body:jsonEncode(getJobJson())
    );

    if(response.statusCode == 201){
      Job newJob = Job.listJson(jsonDecode(response.body));
      return newJob;
    }

    throw Exception("Unable to create job");
  }

  static Future<void> createJobPicture(File image , id) async {
    User user = User();
    var request = http.MultipartRequest("POST", Uri.parse(_base+_userPictures));
    request.headers["Authorization"] = "Bearer ${user.accessToken!}";
    request.fields["job"] = "$id";
    request.files.add(await http.MultipartFile.fromPath("image",image.path));
    var response = await request.send();

    if(response.statusCode != 201){
      throw Exception("Unable to create image");
    }
  }
}